import QtQuick 2.7
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.3
import QtCharts 2.2


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
                color:"black"
            }
            ColumnLayout{
                anchors.fill: parent
                Slider{
                    id: rangeSelector
                    from: 7*24*60
                    to: 1
                    value: 1
                    Layout.fillWidth: true
                    stepSize: 1
                }
                ChartView {
                    title: "Temperature Cº"
                    antialiasing: true
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    titleColor: "white"
                    legend.labelColor: "white"
                    DateTimeAxis{
                        id: xaxis
                        function updateAxis(){
                            var last1 = series1.at(series1.count-1).x
                            var last2 = series2.at(series2.count-1).x
                            var last = Math.min(last1, last2)
                            var now = new Date()
                            now.setTime(last)
                            max = now
                            now.setTime(last - rangeSelector.value*60*1000)
                            min = now;
                            if( rangeSelector.value > 24*60){
                                format = "yy/MM/dd hh:mm"
                            }else if (rangeSelector.value > 5) {
                                format = "hh:mm"
                            }else{
                                format = "hh:mm:ss"
                            }
                        }
                        labelsColor: "white"
                    }
                    backgroundColor: "transparent"
                    ValueAxis{
                        id: yaxis
                        min:0
                        max:40
                        labelsColor: "white"
                    }
                    LineSeries {
                        id: series1
                        name: "DHT 11"

                        axisX: xaxis
                        axisY: yaxis
                        onPointAdded:xaxis.updateAxis()
                    }
                    LineSeries {
                        id: series2
                        name: "DHT 22"
                        color: "red"
                        axisX: xaxis
                        axisY: yaxis
                        onPointAdded:xaxis.updateAxis()
                    }
                }
            }
        }
        GaugePage{
            dhtpin: 27
            onReadingComplete: {
                series1.append(  new Date() ,celsius)
            }


        }
        GaugePage{
            dhtpin: 23
            onReadingComplete: {
                series2.append(  new Date() ,celsius)
            }
        }

    }


    footer: TabBar {
        id: tabBar
        currentIndex: swipeView.currentIndex
        TabButton {
            text: qsTr("Graph")
        }
        TabButton {
            text: qsTr("DHT11")
        }
        TabButton {
            text: qsTr("DHT22")
        }
    }
}
