import QtQuick 2.15

Rectangle {
    width: 200
    height: 100
    color: "lightgray"
    Text {
        anchors.centerIn: parent
        text: "Temp: " + currentTemperature.toFixed(2) + "°C"
        font.pixelSize: 24
    }
}
