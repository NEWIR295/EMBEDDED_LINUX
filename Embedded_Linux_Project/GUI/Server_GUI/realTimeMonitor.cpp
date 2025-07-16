#include "realTimeMonitor.hpp"
#include <QVBoxLayout>

RealTimeMonitor::RealTimeMonitor(QWidget *parent) : QWidget(parent) {
    QVBoxLayout *layout = new QVBoxLayout(this);
    tempLabel = new QLabel("Temperature: N/A", this);
    ledLabel = new QLabel("LED Status: OFF", this);
    layout->addWidget(tempLabel);
    layout->addWidget(ledLabel);
    setLayout(layout);
}

void RealTimeMonitor::updateTemperature(double temp) {
    tempLabel->setText(QString("Temperature: %1°C").arg(temp));
}

void RealTimeMonitor::updateLED(bool on) {
    ledLabel->setText(QString("LED Status: %1").arg(on ? "ON" : "OFF"));
}
