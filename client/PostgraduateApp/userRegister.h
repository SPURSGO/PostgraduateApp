#ifndef USERREGISTER_H
#define USERREGISTER_H

#include <QObject>
#include <QString>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <cstring>
#include <cassert>
#include <string>
#include "network.h"

class UserRegister : public QObject
{
    Q_OBJECT

public:
    Q_INVOKABLE void sendInfo(const QString &username, const QString &pwd)
    {
        const char *ip = "127.0.0.1";
        unsigned short port = 8080;

        sockaddr_in serv;
        memset(&serv, '\0', sizeof (serv));
        serv.sin_family = AF_INET;
        inet_pton(AF_INET, ip, &serv.sin_addr);
        serv.sin_port = htons(port);

        int sockfd = socket(PF_INET, SOCK_STREAM, 0);
        assert( sockfd >= 0 );

        assert( getConnect(sockfd, serv, sizeof (serv)) != -1 );

        std::string u = username.toLatin1().data();
        std::string p = pwd.toLatin1().data();
        std::string userInfo = "register " + u + " " + p;  // username password
        send(sockfd, userInfo.c_str(), userInfo.size(), 0);
        char registerStatus[1024];
        memset(registerStatus, '\0', 1024);
    }

};

#endif // USERREGISTER_H
