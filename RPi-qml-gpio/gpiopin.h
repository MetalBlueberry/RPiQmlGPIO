#ifndef GPIOPIN_H
#define GPIOPIN_H

#include <QQuickItem>
#include <QSocketNotifier>
#include <QFile>
#include <QPointer>

class GPIOPin : public QQuickItem
{
    Q_OBJECT
    Q_PROPERTY(bool value READ value WRITE setValue NOTIFY valueChanged)
    Q_PROPERTY(int pin READ pin WRITE setPin NOTIFY pinChanged)
    Q_PROPERTY(Modes pinMode READ pinMode WRITE setPinMode NOTIFY pinModeChanged)
    Q_ENUMS(Modes)

public:

    enum Modes: int {Input, Output, Undefined};

    GPIOPin(QQuickItem *parent = 0);
    ~GPIOPin();

    bool value();
    void setValue(bool newValue);
    void setValueUnprotected(bool newValue);

    int pin();
    void setPin(int value);

    Modes pinMode();
    void setPinMode(Modes value);

signals:
    void valueChanged();
    void pinChanged();
    void pinModeChanged();

private slots:
    void handle_notification();

    void exportGPIO();
    void unexportGPIO();


private:
    QString generateFilePath(QString file);

    void setEdge(QString edge);
    void setDirection(QString direction);
    void setOutputValue(bool value);


    void enableInputNotifications();
    void disableInputNotifications();

    int validPins[3] = {18, 24, 27};
    bool checkForValidPin();

    bool _value = true;
    int _pin = -1;
    Modes _pinMode = Modes::Undefined;

    QPointer<QSocketNotifier> valueMonitor;
    QPointer<QFile> gpio_value;
};

#endif // GPIOPIN_H
