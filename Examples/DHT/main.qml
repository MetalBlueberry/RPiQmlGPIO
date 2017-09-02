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
            Column{
                anchors.centerIn: parent
                width: 100
                Label{
                    text: "Temp Cº : " + dht.celsius.toFixed(2)
//                    anchors.centerIn: parent
                }
                Label{
                    text: "Temp: Fº " + dht.farenheit.toFixed(2)
//                    anchors.centerIn: parent
                }
                Label{
                    text: "Humidity: % " + dht.humidity.toFixed(2)
//                    anchors.centerIn: parent
                }
            }

        }
//        Page1 {
//        }

//        Page {
//            Label {
//                text: qsTr("Second page")
//                anchors.centerIn: parent
//            }
//        }
    }
    DHT{
        id: dht
        pin: 27

    }

    footer: TabBar {
        id: tabBar
        currentIndex: swipeView.currentIndex
        TabButton {
            text: qsTr("First")
        }
        TabButton {
            text: qsTr("Second")
        }
    }
}
