#include "network.h"

int getConnect( int fd, sockaddr_in &addr, socklen_t len )
{
    return connect(fd, reinterpret_cast<sockaddr *>(&addr), len);
}
