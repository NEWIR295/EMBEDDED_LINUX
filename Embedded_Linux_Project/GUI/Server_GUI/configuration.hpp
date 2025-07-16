#ifndef CONFIGURATION_HPP
#define CONFIGURATION_HPP

#include <QWidget>
#include <QDoubleSpinBox>
#include <QPushButton>

class Configuration : public QWidget {
    Q_OBJECT
public:
    Configuration(QWidget *parent = nullptr);
signals:
    void thresholdChanged(double newThreshold);
private:
    QDoubleSpinBox *thresholdSpinBox;
};

#endif // CONFIGURATION_HPP
