#include "configuration.hpp"
#include <QVBoxLayout>

Configuration::Configuration(QWidget *parent) : QWidget(parent) {
    QVBoxLayout *layout = new QVBoxLayout(this);
    thresholdSpinBox = new QDoubleSpinBox(this);
    thresholdSpinBox->setRange(0, 100);
    thresholdSpinBox->setValue(30.0);
    QPushButton *applyButton = new QPushButton("Apply", this);
    layout->addWidget(thresholdSpinBox);
    layout->addWidget(applyButton);
    setLayout(layout);
    connect(applyButton, &QPushButton::clicked, this, [this]() {
        emit thresholdChanged(thresholdSpinBox->value());
    });
}
