#include <cstdio>
#include <cstdlib>
#include <list>
#include <unistd.h>
#include "network_IO.h"

using namespace std;

/*  在利用IO复用技术时，在epoll_wait()返回之后一定要仔细
 *  考察如何逐一、正确地处理所监听的所有事件，如：
 *  1.在if-else中，对事件处理的先后顺序(如果将条件检查的顺序改变，则可能会发生逻辑上的错误)
 *  2.要完善处理逻辑与监听事件类型一一匹配，不可遗漏
 *
 *  在使用多线程技术时，一定要正确使用线程同步对象,以及共享资源，
 *  特别是，多线程在竞争同一资源时，要正确的加锁和解锁(可以加注释以做标记).
 */

int main(int argc, char **argv )
{
//    if( argc < 3 )
//    {
//        printf("usage: %s <ip> <port>\n", argv[0]);
//        return 1;
//    }


    int epollfd = epoll_create(100);
    /* 初始化监听socket */
    int listenfd = init_listenfd("127.0.0.1", 9001); /* argv[1], atoi( argv[2] ) */
    if( listenfd < 0 )
    {
        printf("init_listenfd fail!\n");
        return 1;
    }
    addfd(epollfd, listenfd);

    /* 创建线程池,使用tids保存在create_threadpool内部动态创建的线程ID */
    create_threadpool();

    epoll_event events[1024];
    int event_num;
    while (1)
    {
        event_num = epoll_wait(epollfd, events, 1024, -1);
        for(int i = 0; i < event_num; ++i)
        {
            int sockfd = events[i].data.fd;
            if(sockfd == listenfd)
            {
                printf("new client comming...\n");
                sockaddr_in client;
                socklen_t len = sizeof (client);
                int connfd = accept(listenfd, reinterpret_cast<sockaddr *>(&client), &len);
                addfd(epollfd, connfd);
            }
            /* 此处一定要处理客户端关闭连接的这种情况，否则会造成服务器的退出 */
            else if (events[i].events &  EPOLLRDHUP )
            {
                printf("one client close the connection, server close connect socket %d.\n", events[i].data.fd);
                close(events[i].data.fd);
            }
            /*  对于用户发来的请求，总是应该在特殊情况发生之后再处理,
             *  此处当EPOLLIN事件产生时，说明是客户正常的请求，
             *  所以，将其请求(即连接socket)加入请求队列，让线程池中的线程
             *  去竞争处理.
             *
             *  特别注意，在连接socket上，当客户端关闭连接(触发EPOLLRDHUP事件)时，同时也会触发该
             *  连接socket上的EPOLLIN事件,
             *  所以在此之前一定要先处理客户端关闭连接的情况，否则会对工作线程产生影响
             */
            else if( events[i].events & EPOLLIN )
            {
                /* 在连接socket上，有客户请求到来时, */
                /* 就将其添加到请求队列中，让工作线程去进行处理 */
                printf("client request comming...\n");
                append(events[i].data.fd);
            }
        }
    }
}
