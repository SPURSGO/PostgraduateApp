#ifndef NETWORK_IO_H
#define NETWORK_IO_H

#include <netinet/in.h>
#include <arpa/inet.h>
#include <cstring>
#include <fcntl.h>
#include <sys/epoll.h>
#include <pthread.h>
#include <cstdio>
#include <memory>
#include <list>
#include <semaphore.h>
#include <cstring>
#include <sstream>
#include <vector>
#include <iostream>
#include <sys/stat.h>
#include <sys/sendfile.h>
#include "redis_storage.h"
#include "video_translate.h"

/* 请求队列，线程共享 */
static std::list<int> request_queue;
/* 保护请求队列的互斥锁 */
static pthread_mutex_t queue_mutex = PTHREAD_MUTEX_INITIALIZER;
/* 表示请求队列状态的信号量 */
static sem_t queue_state;


/* 初始化监听socket,若成功：返回listenfd, 若失败：返回-1 */
int init_listenfd( const char *ip, int port )
{
    sockaddr_in addr;
    memset(&addr, '\0', sizeof(addr));
    addr.sin_family = AF_INET;
    addr.sin_port = htons(static_cast<unsigned short>(port));
    inet_pton(AF_INET, ip, &addr.sin_addr);

    int listenfd = socket(PF_INET, SOCK_STREAM, 0);
    if(listenfd < 0)
    {
        return -1;
    }
    if( bind(listenfd, reinterpret_cast<sockaddr *>(&addr), sizeof (addr)) < 0 )
    {
        return -1;
    }
    if( listen(listenfd, 1000) < 0 )
    {
        return -1;
    }

    return listenfd;
}


int setnonblock(int fd)
{
    int old_opt = fcntl(fd, F_GETFL);
    int new_opt = old_opt | O_NONBLOCK;
    fcntl(fd, F_SETFL, new_opt);
    return old_opt;
}


void addfd(int epollfd, int fd)
{
    epoll_event event;
    event.data.fd = fd;
    event.events = EPOLLIN | EPOLLET | EPOLLRDHUP;
    epoll_ctl(epollfd, EPOLL_CTL_ADD, fd, &event);
    setnonblock(fd);
}

/* 将协议中的每个单词提取出来 */
/* 注意，C++容器是非线程安全的 */
void requestAnalyze(const char *read_buf, std::vector<std::string> &items)
{
    std::string request(read_buf);
    std::istringstream requestItem(request);
    std::string temp;
    while (requestItem >> temp)
    {
        items.push_back(temp);
    }
}


/*  工作线程逻辑：
 *  在设计线程函数时，一旦涉及到互斥锁的应用时，一定要明确锁的状态,
 *  一定要如下一样，写明注释，在何处加锁，在何处解锁.
 *
 *  此外，在线程函数中，只能调用线程安全的函数.
 */
void* worker(void *)
{
    while (1)
    {
        /* 等待请求队列中的任务 */
        sem_wait(&queue_state);

        pthread_mutex_lock(&queue_mutex); /* 加锁 */

        if( request_queue.empty() )
        {
            pthread_mutex_unlock(&queue_mutex);
            continue;
        }
        int connfd = request_queue.front();
        request_queue.pop_front();
        pthread_mutex_unlock(&queue_mutex); /* 解锁 */

        /* -------------------- 在此，对读取到的数据进行分析，然后再响应请求 --------------------- */
        char read_buf[1024];
        memset(read_buf, '\0', 1024);
        auto readbytes = recv(connfd, read_buf, 1024, 0);
        if( readbytes == 0 ) /* recv返回0则说明连接的对方已经关闭连接了 */
            continue;

        /*  客户请求格式：
         *  register username pwssword
         *  login username password
         */
        std::string request(read_buf);
        std::string requestType(request.substr(0, request.find(" ")));
        std::string requestContent(request.substr(request.find(" ")+1));
        std::string contentFirst(requestContent.substr(0, requestContent.find(" ")));
        std::string contentSecond(requestContent.substr(requestContent.find(" ") + 1));

        if(requestType == "register")
        {
            std::cout << "username:" << contentFirst << "  password:" << contentSecond << std::endl;
            // 向redis中存储 用户名-密码 键值对
            const char *redis_addr = "127.0.0.1:6379";
            acl::redis_client conn(redis_addr);
            if( register2Redis(conn, contentFirst.c_str(), contentSecond.c_str()) )
            {
                std::string result = "OK!";
                std::cout << result << std::endl;
                send(connfd, result.c_str(), result.size(), 0);
            }
            else
            {
                std::string result = "ERROR!";
                std::cout << result << std::endl;
                send(connfd, result.c_str(), result.size(), 0);
            }
        }
        else if(requestType == "login")
        {
            // 向redis中验证 用户名的密码是否正确
            const char *redis_addr = "127.0.0.1:6379";
            acl::redis_client conn(redis_addr);
            if( loginCheck(conn, contentFirst.c_str(), contentSecond) )
            {
                std::string result = "OK!";
                std::cout << result << std::endl;
                send(connfd, result.c_str(), result.size(), 0);
            }
            else
            {
                std::string result = "ERROR!";
                std::cout << result << std::endl;
                send(connfd, result.c_str(), result.size(), 0);
            }
        }
        else if(requestType == "article")
        {
            std::cout << "client request: article!\n";
            // 响应文章内容,一次性依次向客户端发送6篇文章
            for(int i = 1; i <= 6; ++i)
            {
                std::string article = std::to_string(i) + ".txt";
                std::cout << "article is :" <<  article << std::endl;
                int filefd = open(article.c_str(), O_RDONLY);
                if(filefd < 0)
                    std::cout << "open file error!\n";
                else
                {
                    struct stat stat_buf;
                    fstat(filefd, &stat_buf);
                    std::string size = std::to_string(stat_buf.st_size);
                    std::string response = "size:" + size;
                    std::cout << "send " << send(connfd, response.c_str(), 20, 0) << " bytes with head.\n";
                    auto sendBytes = sendfile(connfd, filefd, NULL, stat_buf.st_size);
                    if(sendBytes < 0)
                        std::cout << "send file error!\n";
                    else
                        std::cout << "send " << sendBytes << " bytes from file.\n";
                }
            }
            // 向客户端传输视频资源
            sendVideo(connfd, "video1.mp4");
        }

     /* unsigned long tid = pthread_self();
        char tid_to_char[40];
        sprintf(tid_to_char, "%lu", tid);

        char send_buf[1024] = "data from server with thread. ";
        strcat(send_buf, tid_to_char);

        // 若往已经关闭的连接socket中写数据，则会造成线程函数的异常退出,从而使所有线程退出
        auto sendbytes = send(connfd, send_buf, 1024, 0);
        if(sendbytes < 0)
        {
            printf("send data fail!\n");
            continue;
        }
       */
    }
}


/* 创建指定数量的线程,用tids数组存储线程ID */
/* 注意，NPTL中的例程均返回0或者错误码(errno,大于0) */
#define THREAD_NUMBER 4
/* 保存线程ID，以此作为pthread_create的第一个实参 */
static pthread_t tids[THREAD_NUMBER];
void create_threadpool()
{
    /* 在创建线程池的同时对信号量进行初始化 */
    sem_init(&queue_state, 0, 0);

    for(int i = 0; i < THREAD_NUMBER; ++i)
    {
        printf("create the %dth thread\n", i);
        if( pthread_create( &tids[i], nullptr, worker, nullptr ) != 0 )
        {
            printf("fail to create thread!\n");
        }
        if( pthread_detach( tids[i] ) )
        {
            printf("detach fail!\n");
        }
    }
}


/* 当主线程接收到客户请求时，就将此请求(连接socket)加入请求队列中，让工作线程竞争 */
void append(int connfd)
{
    /* 操作请求队列时，必须对其加锁，因为这是所有线程所共享的 */
    pthread_mutex_lock(&queue_mutex);
    request_queue.push_back(connfd);
    pthread_mutex_unlock(&queue_mutex);

    /* 唤醒等待在该信号量上的工作线程 */
    sem_post(&queue_state);
}



#endif // NETWORK_IO_H
