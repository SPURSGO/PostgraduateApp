#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "networkmanage.h"
#include <QtQml>
#include <QQmlContext>
#include <QQuickView>

#include "userRegister.h"
#include "data.h"
#include "fileio.h"


int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);
    qmlRegisterType<FileIO>("ReadFileQML",1,0,"FileIo");
//    qmlRegisterType<UserRegister>("PGAPP.controls", 1, 0, "UserRegister");
    QQmlApplicationEngine engine;

    Networkmanage networkmange;
    networkmange.connect_server();

    qmlRegisterType<UserRegister>("PGAPP.controls", 1, 0, "UserRegister");
    qmlRegisterType<Networkmanage>("NetWorkManage",1, 0,"NetWorkManage");
    qmlRegisterType<Data>("JSON.Data",1,0,"Data");

    engine.rootContext()->setContextProperty("networkmange",&networkmange);

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
