import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Extras 1.4
import QtQuick.Layouts 1.3
import RPiQmlGPIO 1.0

Page{
    id: base
    property alias dhtpin: dht.pin
    property alias celsius: dht.celsius
    property alias humidity: dht.humidity

    signal readingComplete();

    background: Rectangle{
        anchors.fill: parent
        color: "black"
    }
    GridLayout{
        anchors.fill: parent
        columns: 3
        rows:2
        Text{
            Layout.column: 0
            Layout.row: 0
            Layout.columnSpan: 2
            text: "Last Data " + dht.lastValidData
            color:"white"
        }
        CircularGauge{
            Layout.column: 0
            Layout.row: 1
            //                      Layout.preferredHeight: 200
            //                    Layout.preferredWidth: 200
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            //                    Layout.fillHeight: true
            //                    Layout.fillWidth: true
            //                    anchors.centerIn: parent
            //                    height: parent.height
            value: dht.celsius
            maximumValue: 50
            minimumValue: -20
            Text{
                anchors.verticalCenterOffset: parent.height/10
                anchors.centerIn: parent
                horizontalAlignment: Qt.AlignCenter
                text:qsTr("Temp") + "\n" + dht.celsius.toFixed(2) + " Cº"
                color:"white"
            }

        }
        CircularGauge{
            Layout.column: 1
            Layout.row: 1
            //                    Layout.preferredHeight: 200
            //                    Layout.preferredWidth: 200
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            //                    Layout.fillHeight: true
            //                    Layout.fillWidth: true

            value: dht.humidity
            maximumValue: 100
            minimumValue: 0
            Text{
                anchors.verticalCenterOffset: parent.height/10
                anchors.centerIn: parent
                horizontalAlignment: Qt.AlignCenter
                text:qsTr("Humidity") + "\n" + dht.humidity.toFixed(2) + " %"
                color:"white"
            }
        }
    }
    DHT{
        id: dht
        pin: 27
        samplePeriod: 1000
        onReadingComplete: base.readingComplete()
    }
}
