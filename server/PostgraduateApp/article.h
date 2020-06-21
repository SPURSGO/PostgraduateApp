#ifndef ARTICLE_H
#define ARTICLE_H

#include <string>
#include <vector>


// 文章类
class Article
{
public:
    Article() = delete ;
    Article(const std::string &filename);

    bool loadContent();  // 加载文件内容
    void viewContent();  // 获取文件内容(本地测试函数)

    void viewPicture();  // 本地测试函数


public:
    std::string m_filename;
    std::vector<std::string> m_lines;
    std::vector<std::string> m_pictures;

    void findPicture();  // 生成 m_pictures
};

#endif // ARTICLE_H
