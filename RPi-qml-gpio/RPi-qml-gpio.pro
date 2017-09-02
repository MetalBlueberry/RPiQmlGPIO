#-------------------------------------------------
#
# Project created by QtCreator 2017-09-02T21:13:46
#
#-------------------------------------------------

QT       += quick core

TARGET = $$qtLibraryTarget(RPiQmlGPIO)
TEMPLATE = lib
CONFIG += c++11
CONFIG += plugin

DESTDIR = $$OUT_PWD/RPiQmlGPIO/

DEFINES += RPIQMLGPIO_LIBRARY

# The following define makes your compiler emit warnings if you use
# any feature of Qt which as been marked as deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if you use deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

OBJECTS_DIR = tmp
MOC_DIR = tmp

include(wiringPi/wiringPi.pri)

qmldir.files=$$PWD/qmldir
qmldir.path=$$DESTDIR

OTHER_FILES += qmldir

cpqmldir.files = qmldir
cpqmldir.path = $$[QT_INSTALL_QML]/RPiQmlGPIO/

COPIES += cpqmldir

SOURCES += \
        rpiqmlgpio.cpp \
    dht.cpp

HEADERS += \
        rpiqmlgpio.h \
    dht.h

unix {
    target.path = $$[QT_INSTALL_QML]/RPiQmlGPIO/
    INSTALLS += target cpqmldir
}

RESOURCES += \
    qml.qrc

