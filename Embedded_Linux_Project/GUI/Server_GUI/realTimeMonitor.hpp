#ifndef REALTIMEMONITOR_HPP
#define REALTIMEMONITOR_HPP

#include <QWidget>
#include <QLabel>

class RealTimeMonitor : public QWidget {
    Q_OBJECT
public:
    RealTimeMonitor(QWidget *parent = nullptr);
    void updateTemperature(double temp);
    void updateLED(bool on);
private:
    QLabel *tempLabel;
    QLabel *ledLabel;
};

#endif // REALTIMEMONITOR_HPP
