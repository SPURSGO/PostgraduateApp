#ifndef NETWORK_H
#define NETWORK_H

#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>

int getConnect( int fd, sockaddr_in &addr, socklen_t len );

#endif // NETWORK_H
