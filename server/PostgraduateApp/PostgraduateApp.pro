TEMPLATE = app
CONFIG += console c++11
CONFIG -= app_bundle
CONFIG -= qt

SOURCES += \
        article.cpp \
        main.cpp \
        redis_storage.cpp

HEADERS += \
    article.h \
    network_IO.h \
    redis_storage.h \
    video_translate.h

LIBS += \
    -lpthread \
    -L/usr/local/lib/ -lacl_all
