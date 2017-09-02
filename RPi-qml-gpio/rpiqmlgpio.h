#ifndef RPIQMLGPIO_H
#define RPIQMLGPIO_H

#include <QQmlExtensionPlugin>

class RPiQmlGPIO : public QQmlExtensionPlugin
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID QQmlExtensionInterface_iid)

public:
    void registerTypes(const char *uri);
};


#endif // RPIQMLGPIO_H
