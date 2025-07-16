import QtQuick 2.15
import QtCharts 2.15

Item {
    width: 400
    height: 300

    ChartView {
        anchors.fill: parent
        title: "Temperature Over Time"
        legend.visible: true
        antialiasing: true

        LineSeries {
            id: temperatureSeries
            name: "Temperature"
            axisX: ValueAxis {
                min: 0
                max: 10
            }
            axisY: ValueAxis {
                min: 0
                max: 100
            }
        }
    }

    function addPoint(x, y) {
        temperatureSeries.append(x, y);
        if (temperatureSeries.count > 10) {
            temperatureSeries.remove(0);
        }
        var axisX = temperatureSeries.axisX;
        axisX.min = temperatureSeries.count > 10 ? temperatureSeries.at(0).x : 0;
        axisX.max = temperatureSeries.at(temperatureSeries.count - 1).x;
    }
}