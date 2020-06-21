#ifndef NETWORKMANAGE_H
#define NETWORKMANAGE_H

#include <QObject>
#include <QString>

#define MaxSize 1024

class Networkmanage :public QObject
{
    Q_OBJECT
public:


    Q_INVOKABLE void connect_server();  //连接到服务器

    Q_INVOKABLE bool register_userinfo(const QString& username, const QString& pwd);    //注册

    Q_INVOKABLE bool login(const QString& username, const QString& pwd);  //登陆

    Q_INVOKABLE QString& receive_article();   //从服务器接收文章
private:
    int socketfd;   //
    char status[MaxSize];  //保存从服务器接收的一些状态信息

};

#endif // NETWORKMANAGE_H
