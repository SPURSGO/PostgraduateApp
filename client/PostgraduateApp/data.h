#ifndef DATA_H
#define DATA_H

//使用json 进行本地数据保存

#include <QObject>
#include <QJsonObject>
#include <QString>

class Data : public QObject
{
    Q_OBJECT

    Q_PROPERTY(bool loginstatus READ getLoginstatus WRITE setLoginstatus)
    Q_PROPERTY(QString username READ getUsername WRITE setUsername)

public:
    explicit Data(QObject *parent = nullptr);
    Q_INVOKABLE bool getLoginstatus();
    Q_INVOKABLE bool setLoginstatus(bool status);

    Q_INVOKABLE QString getUsername();
    Q_INVOKABLE void setUsername(QString Username);


    Q_INVOKABLE void read(const QJsonObject &json);
    Q_INVOKABLE void write(QJsonObject &json) const;
    Q_INVOKABLE void saveData();
    Q_INVOKABLE bool loadData();


protected:
    bool loginstatus;
    QString username;
};

#endif // DATA_H
