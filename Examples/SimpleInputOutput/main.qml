import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import RPiQmlGPIO 1.0

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: tabBar.currentIndex
        Page{
            background: Rectangle{
                color: pin24_light.value? "white" : "black"
            }
            ColumnLayout{
                anchors.fill: parent
                //
                width: 0
                spacing: 20
                ProgressBar{
                    Layout.alignment: Qt.AlignHCenter
                    from: 0
                    to: 5000
                    width: 200
                    value: shutdownTimer.progress * to

                }
                Text{
                    Layout.alignment: Qt.AlignHCenter
                    text: qsTr("Light is ") + (pin24_light.value? qsTr("on"):qsTr("off"))
                    color: pin24_light.value? "black" : "white"
                }
                Button{
                    Layout.alignment: Qt.AlignHCenter
                    text: qsTr("Quit App")
                    //                    anchors.centerIn: parent
                    onClicked: Qt.quit()
                }


            }
        }
    }

    GPIOPin{
        id: pin18_button
        pin: 18
        pinMode: GPIOPin.Input

        onValueChanged:{
            if (pin18_button.value){
                shutdownTimer.clearTicks()
            }
        }
    }
    GPIOPin{
        id: pin24_light
        pin: 24
        pinMode: GPIOPin.Output
        value: !shutdownTimer.completed
        Timer{
            id: shutdownTimer
            property int targetTicks: 20*10
            property bool completed: ticks <= 0
            property bool disabled: ticks < 0
            property real progress: 1 - Math.abs(ticks/targetTicks)
            property int ticks: 0
            interval: 100
            repeat: true
            running: ticks != 0

            function restartTicks(){
                shutdownTimer.ticks = shutdownTimer.targetTicks
                shutdownTimer.restart()
            }
            function clearTicks(){
                ticks = -shutdownTimer.targetTicks
            }
            onTriggered: {
                if(ticks > 0){
                    ticks--;
                }else{
                    ticks++
                }
            }



        }
    }
    GPIOPin{
        id:pin27_moventSensor
        pin: 27
        pinMode: GPIOPin.Input
        onValueChanged:{
            if(pin27_moventSensor.value){
                if(shutdownTimer.disabled){
                    console.log("sensor disabled temporaly")
                }else{
                    console.log("movent detected, restart")
                    shutdownTimer.restartTicks()
                }
            }
        }
    }

    footer: TabBar {
        id: tabBar
        currentIndex: swipeView.currentIndex
        TabButton {
            text: qsTr("Control")
        }
    }
}
