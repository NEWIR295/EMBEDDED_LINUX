#include "historicalAnalysis.hpp"
#include <QQuickWidget>
#include <QObject>
#include <QVBoxLayout>
#include <QQuickItem>

HistoricalAnalysis::HistoricalAnalysis(QWidget *parent) : QWidget(parent) {
    chartView = new QQuickWidget(this);
    chartView->setSource(QUrl("qrc:/chart.qml"));
    chartView->setResizeMode(QQuickWidget::SizeRootObjectToView);
    QVBoxLayout *layout = new QVBoxLayout(this);
    layout->addWidget(chartView);
    setLayout(layout);
    pointCount = 0;
}

void HistoricalAnalysis::addTemperature(double temp) {
    temperatures.push_back(temp);
    QQuickItem *root = chartView->rootObject();
    if (root) {
        QMetaObject::invokeMethod(root, "addPoint",
                              Q_ARG(QVariant, QVariant(pointCount)),
                              Q_ARG(QVariant, QVariant(temp)));
    }
    pointCount++;
}
