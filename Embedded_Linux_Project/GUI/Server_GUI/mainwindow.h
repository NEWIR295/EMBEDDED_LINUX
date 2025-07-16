#ifndef MAINWINDOW_HPP
#define MAINWINDOW_HPP

#include <memory>
#include <QMainWindow>
#include <QTimer>
#include "serverChannel.hpp"

class RealTimeMonitor;
class HistoricalAnalysis;
class Configuration;
class QuickAccess;

class MainWindow : public QMainWindow {
    Q_OBJECT
public:
    MainWindow(QWidget *parent = nullptr);
    ~MainWindow();
private slots:
    void onTimerTimeout();
    void onThresholdChanged(double newThreshold);
private:
    QTimer *timer;
    std::shared_ptr<ServerChannel> serverChannel;
    RealTimeMonitor *realTimeTab;
    HistoricalAnalysis *historyTab;
    Configuration *configTab;
    QuickAccess *quickAccessTab;
    double currentThreshold;
    double lastSentThreshold;
    double lastTemperature;
};

#endif // MAINWINDOW_HPP
