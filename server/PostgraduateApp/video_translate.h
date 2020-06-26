#ifndef VIDEO_TRANSLATE_H
#define VIDEO_TRANSLATE_H

#include <cstdio>
#include <unistd.h>
#include <stdlib.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <string.h>
#include <netinet/in.h>
#include <string>

#define MAXLINE 409600

void sendVideo(int sockfd, const char *filename)
{
    // "r"  "a"  "w" 是针对文本文件的处理
    // "rb"  "ab"  "wb" 都是针对二进制文件的处理(在POSIX系统上其实并无区别)
    //  即对POSIX系统而言，文本文件和二进制代码文件并无区别
    FILE *fq;
    if( ( fq = fopen(filename,"rb") ) == NULL ){
        printf("File open.\n");
        close(sockfd);
        exit(1);
    }

    int filefd = open(filename, O_RDONLY);
    if( filefd < 0 )
        printf("open file error!\n");

    // 可以通过fstat获得文件的详细信息
    struct stat file_status;
    fstat(filefd, &file_status);
    printf("video file's size: %ld\n", file_status.st_size);
    std::string video_size = std::to_string(file_status.st_size);
    std::string response = "size:" + video_size;
    send(sockfd, response.c_str(), 20, 0);

    // 可以考虑设置以块大小的缓冲区(4096B),然后根据读入字节数循环发送完整个数据
    char  buffer[MAXLINE];
    int   len;
    memset(buffer,'\0',sizeof(buffer));
    while(!feof(fq)){
        // 实参说明
        // buffer:将二进制文件存入该缓冲区, 1: 由于读取的是二进制文件，所以每个二进制数就是一个结构
        // sizeof(buffer):一次读入的缓冲区大小， fp:指定从哪里读
        len = fread(buffer, 1, sizeof(buffer), fq);
        int rest = len;
        while (rest > 0)
        {
            int send_ret = send(sockfd, buffer, len, 0);
            rest -= send_ret;
        }
    }
}


#endif // VIDEO_TRANSLATE_H
