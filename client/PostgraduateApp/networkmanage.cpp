#include "networkmanage.h"
#include <network.h>
#include <iostream>
#include <string>


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
    std::cout<<"error"<<std::endl;

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

    return result=="ok!";
}

Q_INVOKABLE bool Networkmanage::login(const QString &username, const QString &pwd)
{
    std::string u = username.toLatin1().data();           //
    std::string p = pwd.toLatin1().data();
    std::string userInfo = "login "+u + " " + p;
    send(socketfd, userInfo.c_str(), userInfo.size(), 0);  //发送用户名到服务器进行验证

    memset(status, '\0', MaxSize);  //初始化

    recv(socketfd,status,10,0);  //接受服务器回应 进行判断 用户名是否存在,密码是否正确

    std::string result(status);

    return result=="ok!";
}

Q_INVOKABLE QString& Networkmanage::receive_article()
{

}
