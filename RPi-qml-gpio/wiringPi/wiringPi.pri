INCLUDEPATH += $$PWD/3rdParty/wiringPi
INCLUDEPATH += $$PWD/3rdParty/wiringPiD
INCLUDEPATH += $$PWD/3rdParty/devLib

HEADERS += \
    $$PWD/3rdParty/devLib/ds1302.h \
    $$PWD/3rdParty/devLib/font.h \
    $$PWD/3rdParty/devLib/gertboard.h \
    $$PWD/3rdParty/devLib/lcd.h \
    $$PWD/3rdParty/devLib/lcd128x64.h \
    $$PWD/3rdParty/devLib/maxdetect.h \
    #$$PWD/3rdParty/devLib/piFace.h \
    $$PWD/3rdParty/devLib/piGlow.h \
    $$PWD/3rdParty/devLib/piNes.h \
    $$PWD/3rdParty/devLib/scrollPhat.h \
    $$PWD/3rdParty/devLib/scrollPhatFont.h \
    $$PWD/3rdParty/wiringPi/ads1115.h \
    $$PWD/3rdParty/wiringPi/bmp180.h \
    $$PWD/3rdParty/wiringPi/drcNet.h \
    $$PWD/3rdParty/wiringPi/drcSerial.h \
    $$PWD/3rdParty/wiringPi/ds18b20.h \
    $$PWD/3rdParty/wiringPi/htu21d.h \
    $$PWD/3rdParty/wiringPi/max31855.h \
    $$PWD/3rdParty/wiringPi/max5322.h \
    $$PWD/3rdParty/wiringPi/mcp23008.h \
    $$PWD/3rdParty/wiringPi/mcp23016.h \
    $$PWD/3rdParty/wiringPi/mcp23016reg.h \
    $$PWD/3rdParty/wiringPi/mcp23017.h \
    $$PWD/3rdParty/wiringPi/mcp23s08.h \
    $$PWD/3rdParty/wiringPi/mcp23s17.h \
    $$PWD/3rdParty/wiringPi/mcp23x08.h \
    $$PWD/3rdParty/wiringPi/mcp23x0817.h \
    $$PWD/3rdParty/wiringPi/mcp3002.h \
    $$PWD/3rdParty/wiringPi/mcp3004.h \
    $$PWD/3rdParty/wiringPi/mcp3422.h \
    $$PWD/3rdParty/wiringPi/mcp4802.h \
    $$PWD/3rdParty/wiringPi/pcf8574.h \
    $$PWD/3rdParty/wiringPi/pcf8591.h \
    $$PWD/3rdParty/wiringPi/pseudoPins.h \
    $$PWD/3rdParty/wiringPi/rht03.h \
    $$PWD/3rdParty/wiringPi/sn3218.h \
    $$PWD/3rdParty/wiringPi/softPwm.h \
    $$PWD/3rdParty/wiringPi/softServo.h \
    $$PWD/3rdParty/wiringPi/softTone.h \
    $$PWD/3rdParty/wiringPi/sr595.h \
    $$PWD/3rdParty/wiringPi/wiringPi.h \
    $$PWD/3rdParty/wiringPi/wiringPiI2C.h \
    $$PWD/3rdParty/wiringPi/wiringPiSPI.h \
    $$PWD/3rdParty/wiringPi/wiringSerial.h \
    $$PWD/3rdParty/wiringPi/wiringShift.h \
    $$PWD/3rdParty/wiringPi/wpiExtensions.h \
    $$PWD/3rdParty/wiringPiD/daemonise.h \
    $$PWD/3rdParty/wiringPiD/drcNetCmd.h \
    $$PWD/3rdParty/wiringPiD/network.h \
    $$PWD/3rdParty/wiringPiD/runRemote.h \
    $$PWD/3rdParty/version.h

SOURCES += \
    $$PWD/3rdParty/devLib/ds1302.c \
    $$PWD/3rdParty/devLib/gertboard.c \
    $$PWD/3rdParty/devLib/lcd.c \
    $$PWD/3rdParty/devLib/lcd128x64.c \
    $$PWD/3rdParty/devLib/maxdetect.c \
#    $$PWD/3rdParty/devLib/piFace.c \
#    $$PWD/3rdParty/devLib/piFaceOld.c \
    $$PWD/3rdParty/devLib/piGlow.c \
    $$PWD/3rdParty/devLib/piNes.c \
    $$PWD/3rdParty/devLib/scrollPhat.c \
    $$PWD/3rdParty/gpio/gpio.c \
    $$PWD/3rdParty/gpio/pins.c \
    $$PWD/3rdParty/gpio/readall.c \
    $$PWD/3rdParty/wiringPi/ads1115.c \
    $$PWD/3rdParty/wiringPi/bmp180.c \
    $$PWD/3rdParty/wiringPi/drcNet.c \
    $$PWD/3rdParty/wiringPi/drcSerial.c \
    $$PWD/3rdParty/wiringPi/ds18b20.c \
    $$PWD/3rdParty/wiringPi/htu21d.c \
    $$PWD/3rdParty/wiringPi/max31855.c \
    $$PWD/3rdParty/wiringPi/max5322.c \
    $$PWD/3rdParty/wiringPi/mcp23008.c \
    $$PWD/3rdParty/wiringPi/mcp23016.c \
    $$PWD/3rdParty/wiringPi/mcp23017.c \
    $$PWD/3rdParty/wiringPi/mcp23s08.c \
    $$PWD/3rdParty/wiringPi/mcp23s17.c \
    $$PWD/3rdParty/wiringPi/mcp3002.c \
    $$PWD/3rdParty/wiringPi/mcp3004.c \
    $$PWD/3rdParty/wiringPi/mcp3422.c \
    $$PWD/3rdParty/wiringPi/mcp4802.c \
    $$PWD/3rdParty/wiringPi/pcf8574.c \
    $$PWD/3rdParty/wiringPi/pcf8591.c \
    $$PWD/3rdParty/wiringPi/piHiPri.c \
    $$PWD/3rdParty/wiringPi/piThread.c \
    $$PWD/3rdParty/wiringPi/pseudoPins.c \
    $$PWD/3rdParty/wiringPi/rht03.c \
    $$PWD/3rdParty/wiringPi/sn3218.c \
    $$PWD/3rdParty/wiringPi/softPwm.c \
    $$PWD/3rdParty/wiringPi/softServo.c \
    $$PWD/3rdParty/wiringPi/softTone.c \
    $$PWD/3rdParty/wiringPi/sr595.c \
    $$PWD/3rdParty/wiringPi/wiringPi.c \
    $$PWD/3rdParty/wiringPi/wiringPiI2C.c \
    $$PWD/3rdParty/wiringPi/wiringPiSPI.c \
    $$PWD/3rdParty/wiringPi/wiringSerial.c \
    $$PWD/3rdParty/wiringPi/wiringShift.c \
    $$PWD/3rdParty/wiringPi/wpiExtensions.c \
    $$PWD/3rdParty/wiringPiD/daemonise.c \
    $$PWD/3rdParty/wiringPiD/network.c \
    $$PWD/3rdParty/wiringPiD/runRemote.c
#    $$PWD/3rdParty/wiringPiD/wiringpid.c
