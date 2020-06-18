#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include <QtQml>
#include "userRegister.h"

#include "fileio.h"


int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);
    qmlRegisterType<FileIO>("ReadFileQML",1,0,"FileIo");
    qmlRegisterType<UserRegister>("PGAPP.controls", 1, 0, "UserRegister");
    QQmlApplicationEngine engine;

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
