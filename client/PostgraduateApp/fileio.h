#ifndef FILEIO_H

#define FILEIO_H



#include <QObject>

#include <QTextCodec>

#include <QDebug>



class FileIO : public QObject

{

    Q_OBJECT



public:

    Q_PROPERTY(QString source

               READ source

               WRITE setSource

               NOTIFY sourceChanged)

    explicit FileIO(QObject *parent = 0);



    Q_INVOKABLE QString read();

    Q_INVOKABLE bool write(const QString& data);



    QString source() { return mSource; };



public slots:

    void setSource(const QString& source) { mSource = source; };



signals:

    void sourceChanged(const QString& source);

    void error(const QString& msg);



private:

    QString getenv(const QString envVarName) const;



private:

    QString mSource;

    QString datapath;

};



inline QString GBK2UTF8(const QString &inStr)

{

    QList<QByteArray> codecs = QTextCodec::availableCodecs();



    for ( int i = 0; i < codecs.length(); i ++ ) {

//        qDebug() << "codec: " + QTextCodec::codecForMib(1015)->toUnicode(codecs.at(i));

        qDebug() << "codec: " << QString::fromLocal8Bit(codecs.at(i));

    }



    QTextCodec *gbk = QTextCodec::codecForName("GBK");



    QTextCodec::setCodecForLocale(QTextCodec::codecForLocale());

//    QTextCodec *utf8 = QTextCodec::codecForName("UTF-8");



    QString g2u = gbk->toUnicode(gbk->fromUnicode(inStr)); // gbk  convert utf8

    return g2u;

}



#endif // FILEIO_H
