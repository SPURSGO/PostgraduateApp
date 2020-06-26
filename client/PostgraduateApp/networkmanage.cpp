#include "networkmanage.h"
#include <network.h>
#include <iostream>
#include <string>
#include <error.h>
#include <QString>


Q_INVOKABLE void Networkmanage::connect_server()  //进行网络连接
{
    if((socketfd=socket(PF_INET,SOCK_STREAM,0))==-1)   //创建和服务器连接的套接字
    {
        /* fprintf(stderr,"Socket error:%s\n\a",strerror(errno));*/
        std::cerr<<"Socked error:"<<strerror(errno)<<std::endl;    //打印错误信息
        exit(1);
    }

    const char *ip = "127.0.0.1";   // 服务器ip 地址
    unsigned short port = 9001;   //服务器 端口号

    sockaddr_in serv;        //
    memset(&serv, '\0', sizeof (serv));   //初始化
    serv.sin_family = AF_INET;   // Internet地址族
    inet_pton(AF_INET, ip, &serv.sin_addr);
    serv.sin_port = htons(port);


    if(getConnect(socketfd, serv, sizeof (serv)) != -1)  //连接服务器
    {
        std::cerr<<"Connect error:"<<strerror(errno)<<std::endl;    //打印错误信息
    }

}

Q_INVOKABLE bool Networkmanage::register_userinfo(const QString& username, const QString& pwd)  //用户注册
{
    std::string u = username.toLatin1().data();           //
    std::string p = pwd.toLatin1().data();
    std::string userInfo = "register "+u + " " + p;
    send(socketfd, userInfo.c_str(), userInfo.size(), 0);  //发送用户名到服务器进行验证

    memset(status, '\0', MaxSize);  //初始化

    recv(socketfd,status,10,0);  //接受服务器回应 进行判断 用户名是否存在

    std::string result(status);

    return result=="OK!";
}

Q_INVOKABLE bool Networkmanage::login(const QString &username, const QString &pwd)
{
    std::string u = username.toLatin1().data();           //
    std::string p = pwd.toLatin1().data();
    std::string userInfo = "login "+u + " " + p;
    send(socketfd, userInfo.c_str(), userInfo.size(), 0);  //发送用户名到服务器进行验证

    memset(status, '\0', MaxSize);  //初始化

    recv(socketfd,status,MaxSize,0);  //接受服务器回应 进行判断 用户名是否存在,密码是否正确
    printf("status:  %s\n",status);
    std::string result(status);
//    std::cout<<result<<std::endl;

    return result == "OK!";
}

Q_INVOKABLE QString Networkmanage::receive_article()
{
    size_t size = receive_size();
    readn(size);
    std::string s(essay);
    QString article =QString::fromStdString(s);
    return article;
}

Q_INVOKABLE bool Networkmanage::sendsingal()
{
    std::string ask = "article * *";
    return send(socketfd,ask.c_str(),ask.size(),0);
}

Q_INVOKABLE int Networkmanage::receive_size()
{
    int size_fd;
    int size_get = 20;


    if ((size_fd = readn(size_get)) < 0){
        error(1,0,"recv failed -- receive_size");
    }

    std::string S(essay);
    std::cout << S << std::endl;
    std::string size(S.substr(S.find(":")+1));
    std::cout<<size<<std::endl;
    int num_size = atoi(size.c_str());
    std::cout<<num_size<<std::endl;
    return num_size;
}

Q_INVOKABLE bool Networkmanage::receive_vedio()  //接受视频
{
    FILE *fp;
    // 注意ab和wb的区别， a是追加，w是覆写(即将原文件截断为0之后再写)
    if((fp = fopen("newVideo.mp4","ab") ) == NULL )
    {
        printf("File open file.\n");
        //        exit(1);
    }

    int vedio_size =receive_size();


    int size =0;
    while(vedio_size){

        if(vedio_size>MaxPlus)
        {
            size = readn(MaxPlus);
        }else{
            size = readn(vedio_size);
        }
        vedio_size -=size;

        fwrite(essay, 1, size, fp);
    }
    essay[size] = '\0';
    fclose(fp);
}

size_t Networkmanage::readn(size_t size)
{
    int length = size;
    memset(essay,'\0', MaxPlus);
    char *buffer_pointer = essay;

    while (length > 0) {
        int result = recv(socketfd, buffer_pointer, length,0);

        if (result < 0) {
            if (errno == EINTR)
                continue;     /* 考虑非阻塞的情况，这里需要再次调用read */
            else
                return (-1);
        } else if (result == 0)
            break;                /* EOF(End of File)表示套接字关闭 */

        length -= result;
        buffer_pointer += result;
    }
    return (size - length);        /* 返回的是实际读取的字节数*/
}


