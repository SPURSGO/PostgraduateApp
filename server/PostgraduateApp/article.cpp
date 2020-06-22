#include "article.h"
#include <fstream>
#include <iostream>

using std::ifstream;            using std::cout;
using std::string;              using std::endl;

Article::Article(const std::string &filename):m_filename(filename){}


bool Article::loadContent()  // 加载文件内容
{
    ifstream file(m_filename);
    if(!file)
        return false;
    string line;
    while (getline(file, line))
    {
        m_lines.push_back(line + "\r\n");
    }
    return true;
}



void Article::viewContent()  // 获取文件内容
{
    for(const auto &elem : m_lines)
        cout << elem;  // 如果每一行中自带换行符，则会自动刷新换行
}



void Article::findPicture()
{
    for(const auto &elem : m_lines)
    {
        if(elem[0] == '[' && elem[1] == '<')
        {
            auto pos = elem.find(">]");
            m_pictures.push_back(elem.substr(2, pos - 2));
        }
    }
}


void Article::viewPicture()
{
    findPicture();
    for(const auto &elem : m_pictures)
        cout << elem;
}
