#include "rpiqmlgpio.h"
#include <qqml.h>
#include "dht.h"
#include "gpiopin.h"
#include <wiringPi.h>

void RPiQmlGPIO::registerTypes(const char *uri)
{
    wiringPiSetupGpio();
    qmlRegisterType<DHT>(uri, 1, 0, "DHT");
    qmlRegisterType<GPIOPin>(uri,1,0,"GPIOPin");
    //qmlRegisterType<NeuralNetworkInterface>(uri,1,0,"NeuralNetworkInterface");
}
