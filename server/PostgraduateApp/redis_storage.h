#ifndef REDIS_STORAGE_H
#define REDIS_STORAGE_H

#include "acl/lib_acl/include/lib_acl.h"
#include "acl/lib_acl_cpp/include/acl_cpp/lib_acl.hpp"
#include <iostream>
#include <string>


/*  向redis服务器写入用户注册的用户名与密码:
 *  以用户名为键，密码为值
 *  返回true则为注册成功，返回false则为注册失败
 *
 */
bool register2Redis( acl::redis_client &conn, const char *key, const char *value )
{
    // redis_key：redis 所有数据类型的统一键操作类；
    // 因为 redis 的数据结构类型都是基本的 KEY-VALUE 类型，其中 VALUE 分为不同的数据结构类型；
    // 此处探测给定 key 是否存在于 redis-server 中，需要创建 redis_key类对象,同时将 redis 连接对象与之绑定
    acl::redis_key key_opt;
    key_opt.set_client(&conn);  // 将连接对象与操作对象进行绑定

    bool result = key_opt.exists(key);
    if( result == false )
    {
        /* 创建redis string键值类型的命令操作类对象
         * 对于不同类型的键值，存在不同命令，如:字符串(set,get),散列(hset,hget)
         * 同时将连接类对象与操作类对象进行绑定
         */
        acl::redis_string string_opt(&conn);
        while(1)
        {
            if(string_opt.set(key, value) == true)
                break;
        }
        return true;
    }
    return !result;
}


bool loginCheck( acl::redis_client &conn, const char *key, const std::string &pwd )
{
    acl::redis_string string_opt(&conn);
    // 从 redis-server 中取得对应 key 的值
    acl::string buf;
    bool redis_result = string_opt.get(key,buf);
    if(redis_result)
    {
        std::string result(buf.c_str());
        if(result == pwd)
            return true;
        else
            return false;
    }
    else
        return redis_result;
}


#endif // REDIS_STORAGE_H
