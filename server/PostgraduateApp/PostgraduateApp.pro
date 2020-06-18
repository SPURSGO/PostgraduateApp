TEMPLATE = app
CONFIG += console c++11
CONFIG -= app_bundle
CONFIG -= qt

SOURCES += \
        article.cpp \
        main.cpp

HEADERS += \
    article.h \
    network_IO.h

LIBS += \
    -lpthread
