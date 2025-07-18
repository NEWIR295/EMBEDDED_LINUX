import QtQuick 2.15
import QtCharts 2.15

ChartView {
    title: "Historical Temperature"
    anchors.fill: parent
    legend.visible: false
    antialiasing: true

    LineSeries {
        id: series
        axisX: ValueAxis {
            min: 0
            max: temperatureModel.rowCount() > 0 ? temperatureModel.rowCount() - 1 : 0
        }
        axisY: ValueAxis {
            min: 0
            max: 100
        }
    }

    Component.onCompleted: {
        var mapper = Qt.createQmlObject('import QtCharts 2.15; XYModelMapper {}', series);
        mapper.model = temperatureModel;
        mapper.xColumn = 0;
        mapper.yColumn = 1;
        mapper.series = series;
    }
}
