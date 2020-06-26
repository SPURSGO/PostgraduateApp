#include "data.h"
#include <QFile>
#include <QJsonDocument>

Data::Data(QObject *parent) : QObject(parent)
{

}

bool Data::getLoginstatus()
{
    return loginstatus;
}

bool Data::setLoginstatus(bool status)
{
    loginstatus = status;
    return true;
}

QString Data::getUsername()
{
    return username;
}

void Data::setUsername(QString Username)
{
    username = Username;
}

void Data::read(const QJsonObject &json)
{
    if(json.contains("loginstatus"))
        loginstatus = json["loginstatus"].toBool();
    if(json.contains("Username"))
        username = json["Username"].toString();
}

void Data::write(QJsonObject &json) const
{
    json["loginstatus"] = loginstatus;
    json["Username"] = username;
}

void Data::saveData()
{
    QFile saveFile(QStringLiteral("save.json"));

    if (!saveFile.open(QIODevice::ReadWrite)) {
        qWarning("Couldn't open save file.");
        return ;
    }

    QJsonObject gameObject;
    write(gameObject);
    QJsonDocument saveDoc(gameObject);
    saveFile.write(saveDoc.toJson());
}

bool Data::loadData()
{
    QFile loadFile(QStringLiteral("save.json"));

    if (!loadFile.open(QIODevice::ReadOnly)) {
        qWarning("Couldn't open save file.");
        return false;
    }

    QByteArray saveData = loadFile.readAll();

    QJsonDocument loadDoc(QJsonDocument::fromJson(saveData));

    read(loadDoc.object());
    return true;
}
