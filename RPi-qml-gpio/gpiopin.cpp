#include "gpiopin.h"
//#include <QGuiApplication>

GPIOPin::GPIOPin(QQuickItem *parent):
    QQuickItem(parent)
{
//    connect(QGuiApplication::instance(),SIGNAL(aboutToQuit()),this,SLOT(unexportGPIO()));
}

GPIOPin::~GPIOPin()
{
    unexportGPIO();
}

bool GPIOPin::value()
{
    return this->_value;
}

void GPIOPin::setValue(bool newValue)
{
    if(this->pinMode() == Modes::Input){
        qDebug() << "You can't set the pin state when it's configured as output";
    }else{
        setValueUnprotected(newValue);
        setOutputValue(newValue);
    }
}

void GPIOPin::setValueUnprotected(bool newValue)
{
    if( this->_value != newValue){
        this->_value = newValue;
        emit valueChanged();
    }
}

int GPIOPin::pin()
{
    return this->_pin;
}

void GPIOPin::setPin(int value)
{
    if (this->_pin != value){
//        qDebug() << "set pin " << value;
        if(this->gpio_value){
            this->gpio_value->close();
            this->gpio_value->deleteLater();
            unexportGPIO();
        }

        this->_pin = value;

        this->enableInputNotifications();

        emit pinChanged();
    }
}

GPIOPin::Modes GPIOPin::pinMode()
{
    return this->_pinMode;
}

void GPIOPin::setPinMode(GPIOPin::Modes value)
{
    if ( this->_pinMode != value){
        this->_pinMode = value;
        emit pinModeChanged();

        this->enableInputNotifications();
    }
}

void GPIOPin::handle_notification()
{
    this->gpio_value->seek(0);
    int state = this->gpio_value->readLine().trimmed().toInt();
    this->setValueUnprotected(state == 1);
}

QString GPIOPin::generateFilePath(QString file)
{
    return "/sys/class/gpio/gpio" + QString::number(this->pin()) + "/" +file;
}

void GPIOPin::setEdge(QString edge)
{
    QFile edgeFile(generateFilePath("edge"));
    if(edgeFile.open(QFile::WriteOnly)){
        edgeFile.write(edge.toUtf8());
        edgeFile.flush();
        edgeFile.close();

    }
}

void GPIOPin::setDirection(QString direction)
{
    QFile directionFile(generateFilePath("direction"));
    if(directionFile.open(QFile::WriteOnly)){
        directionFile.write(direction.toUtf8());
        directionFile.flush();
        directionFile.close();
    }
}

void GPIOPin::setOutputValue(bool value)
{
//    qDebug() << "seting pin " << this->pin() << " to " << value;
    this->gpio_value->write(QString::number(value).toUtf8());
    this->gpio_value->flush();
}

void GPIOPin::exportGPIO()
{
    qDebug() << "exporting new pin " << this->pin();
    QFile exportFile("/sys/class/gpio/export");
    if(exportFile.open(QFile::WriteOnly)){
        exportFile.write(QString::number(this->pin()).toUtf8());
        exportFile.flush();
        exportFile.close();
    }
}

void GPIOPin::unexportGPIO()
{
    qDebug() << "unexporting " << this->pin();
    QFile unexportFile("/sys/class/gpio/unexport");
    if(unexportFile.open(QFile::WriteOnly)){
        unexportFile.write(QString::number(this->pin()).toUtf8());
        unexportFile.flush();
        unexportFile.close();
    }
}

void GPIOPin::enableInputNotifications()
{
    if(!checkForValidPin()){
        qDebug() << "Invalid pin " << this->_pin;
        return;
    }


    if(!this->gpio_value || !this->gpio_value->isOpen()){
        exportGPIO();
        this->gpio_value = new QFile(this->generateFilePath("value"));
        this->gpio_value->open(QFile::ReadWrite);
    }


    if (pinMode() == Modes::Input){
        qDebug() << "Set mode Input " << this->pin();
        this->setDirection("in");
        this->setEdge("both");
    }else{
        qDebug() << "Set mode Output " << this->pin();
        this->setEdge("none");
        this->setDirection("out");
        this->setValue("0");
    }

    //    this->setDirection("out");
    //    this->setEdge("both");
    if(this->valueMonitor){
        this->valueMonitor->deleteLater();
    }
    this->valueMonitor = new QSocketNotifier(gpio_value->handle(),QSocketNotifier::Exception,gpio_value);
    connect(this->valueMonitor,SIGNAL(activated(int)),this,SLOT(handle_notification()));
}

void GPIOPin::disableInputNotifications()
{
    if(this->_pin != 18){
        qDebug() << "Invalid pin " << this->_pin;
        return;
    }
}

bool GPIOPin::checkForValidPin()
{
    for(uint x = 0; x < sizeof(validPins)/sizeof(int); x++){
        if (this->pin() == validPins[x]){
            qDebug() << this->pin() << " is valid";
            return true;
        }
    }
    return false;
}
