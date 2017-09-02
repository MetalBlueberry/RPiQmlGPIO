#ifndef DHT_H
#define DHT_H

#include <QQuickItem>
#include <QTimer>
#include <wiringPi.h>


class DHT : public QQuickItem
{
    Q_OBJECT
    Q_PROPERTY(qreal celsius READ celsius NOTIFY tempChanged)
    Q_PROPERTY(qreal farenheit READ farenheit NOTIFY tempChanged)
    Q_PROPERTY(qreal humidity READ humidity NOTIFY humidityChanged)
    Q_PROPERTY(int samplePeriod READ samplePeriod WRITE setSamplePeriod NOTIFY samplePeriodChanged)
    Q_PROPERTY(int failReadRetryPeriod READ failReadRetryPeriod WRITE setFailReadRetryPeriod NOTIFY failReadRetryPeriodChanged)
    Q_PROPERTY(int pin READ pin WRITE setPin NOTIFY pinChanged)

public:
    DHT(QQuickItem *parent = 0);

    qreal farenheit();
    qreal celsius();
    void setTemp(qreal value);

    qreal humidity();
    void setHumidity(qreal value);

    int samplePeriod();
    void setSamplePeriod(int value);

    int failReadRetryPeriod();
    void setFailReadRetryPeriod(int value);

    int pin();
    void setPin(int value);

signals:
    void tempChanged();
    void humidityChanged();
    void samplePeriodChanged();
    void pinChanged();
    void failReadRetryPeriodChanged();

public slots:

private slots:
     void readDhtData();

private:
    qreal _temp = 0;
    qreal _humidity = 0;
    int _samplePeriod = 1000;
    int _failReadRetryPeriod = 100;
    int _pin = -1;

    int data[5] = { 0, 0, 0, 0, 0 };

    QTimer *sampleTimer;

};



#endif // DHT_H
