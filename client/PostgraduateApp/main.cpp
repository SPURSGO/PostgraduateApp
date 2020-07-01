#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "networkmanage.h"
#include <QtQml>
#include <QQmlContext>
#include <QQuickView>

#include "data.h"
#include "fileio.h"


int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);
    qmlRegisterType<FileIO>("ReadFileQML",1,0,"FileIo");

    QQmlApplicationEngine engine;

    Networkmanage networkmange;
    networkmange.connect_server();  //声明一个 networkmange对象 注册到 qml 上下文中

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
