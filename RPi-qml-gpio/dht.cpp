#include "dht.h"

DHT::DHT(QQuickItem *parent): QQuickItem(parent)
  ,sampleTimer(new QTimer(this))
{
    sampleTimer->setInterval(this->samplePeriod());
    sampleTimer->start();
    connect(sampleTimer,SIGNAL(timeout()),this,SLOT(readDhtData()));

}

qreal DHT::farenheit()
{
    return this->_temp * 1.8f + 32;
}

qreal DHT::celsius()
{
    return this->_temp;
}

void DHT::setTemp(qreal value)
{
    if(this->_temp != value){
        this->_temp = value;
        emit tempChanged();
    }
}

qreal DHT::humidity()
{
    return this->_humidity;
}

void DHT::setHumidity(qreal value)
{
    if(this->_humidity != value){
        this->_humidity = value;
        emit humidityChanged();
    }
}

int DHT::samplePeriod()
{
    return this->_samplePeriod;
}

void DHT::setSamplePeriod(int value)
{
    if(this->_samplePeriod != value){
        this->_samplePeriod = value;
        emit samplePeriodChanged();
    }
}

int DHT::failReadRetryPeriod()
{
    return this->_failReadRetryPeriod;
}

void DHT::setFailReadRetryPeriod(int value)
{
    if(this->_failReadRetryPeriod != value){
        this->_failReadRetryPeriod = value;
        emit samplePeriodChanged();
    }
}

int DHT::pin()
{
    return this->_pin;
}

void DHT::setPin(int value)
{
    if (this->_pin != value){
        this->_pin = value;
        emit pinChanged();
        readDhtData();
    }
}

QDateTime DHT::lastValidData()
{
    return this->_lastValidData;
}

void DHT::readDhtData()
{
    if (this->_pin == -1){
        qWarning() << "DHT pin not set!";
        return;
    }
    uint8_t laststate	= HIGH;
    uint8_t counter		= 0;
    uint8_t j			= 0, i;

    data[0] = data[1] = data[2] = data[3] = data[4] = 0;

    /* pull pin down for 18 milliseconds */
    pinMode( _pin, OUTPUT );
    digitalWrite( _pin, LOW );
    delay( 18 );

    /* prepare to read the pin */
    pinMode( _pin, INPUT );

    /* detect change and read data */
    for ( i = 0; i < 85; i++ )
    {
        counter = 0;
        while ( digitalRead( _pin ) == laststate )
        {
            counter++;
            delayMicroseconds( 1 );
            if ( counter == 255 )
            {
                break;
            }
        }
        laststate = digitalRead( _pin );

        if ( counter == 255 )
            break;

        /* ignore first 3 transitions */
        if ( (i >= 4) && (i % 2 == 0) && j < 40)
        {
            /* shove each bit into the storage bytes */
            data[j / 8] <<= 1;
            if ( counter > 16 )
                data[j / 8] |= 1;
            j++;
        }
    }

    /*
         * check we read 40 bits (8bit x 5 ) + verify checksum in the last byte
         * print it out if data is good
         */
    if ( (j == 40) &&
         (data[4] == ( (data[0] + data[1] + data[2] + data[3]) & 0xFF) ) )
    {
        float h = (float)((data[0] << 8) + data[1]) / 10;
        if ( h > 100 )
        {
            h = data[0];	// for DHT11
        }
        float c = (float)(((data[2] & 0x7F) << 8) + data[3]) / 10;
        if ( c > 125 )
        {
            c = data[2];	// for DHT11
        }
        if ( data[2] & 0x80 )
        {
            c = -c;
        }
        float f = c * 1.8f + 32;
        //        qDebug("Humidity = %.1f %% Temperature = %.1f *C (%.1f *F)\n", h, c, f );

        this->setTemp(c);
        this->setHumidity(h);
        this->sampleTimer->setInterval(this->samplePeriod());

        this->_lastValidData = QDateTime::currentDateTime();
        emit readingComplete();

    }else  {
        //        qDebug("Data not good, skip\n" );
        this->sampleTimer->setInterval(this->failReadRetryPeriod());
    }

}
