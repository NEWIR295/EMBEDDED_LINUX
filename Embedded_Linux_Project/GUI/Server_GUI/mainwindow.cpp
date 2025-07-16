#include "mainwindow.h"
#include <QTabWidget>
#include "realTimeMonitor.hpp"
#include "historicalAnalysis.hpp"
#include "configuration.hpp"
#include "quickAccess.hpp"
#include "TCPsocket.hpp"

MainWindow::MainWindow(QWidget *parent) : QMainWindow(parent) {
    QTabWidget *tabs = new QTabWidget(this);
    realTimeTab = new RealTimeMonitor(this);
    historyTab = new HistoricalAnalysis(this);
    configTab = new Configuration(this);
    quickAccessTab = new QuickAccess(this);
    tabs->addTab(realTimeTab, "Real-Time Monitor");
    tabs->addTab(historyTab, "Historical Analysis");
    tabs->addTab(configTab, "Configuration");
    tabs->addTab(quickAccessTab, "Quick Access");
    setCentralWidget(tabs);

    tabs->setStyleSheet("QTabWidget::pane { background-image: url(:/background.jpg); } "
                        "QTabBar { background: transparent; }");

    timer = new QTimer(this);
    connect(timer, &QTimer::timeout, this, &MainWindow::onTimerTimeout);
    connect(configTab, &Configuration::thresholdChanged, this, &MainWindow::onThresholdChanged);
    timer->start(1000);

    serverChannel = std::make_shared<ServerChannel>(std::make_shared<TCPSocket>());
    serverChannel->start();

    currentThreshold = 30.0;
    lastSentThreshold = 0.0;
    lastTemperature = 0.0;
}

MainWindow::~MainWindow() {
    serverChannel->stop();
}

void MainWindow::onTimerTimeout() {
    if (currentThreshold != lastSentThreshold) {
        std::string status = (lastTemperature > currentThreshold) ? "ON" : "OFF";
        std::string message = "set threshold " + std::to_string(currentThreshold) + " " + status;
        serverChannel->send(message);
        lastSentThreshold = currentThreshold;
        realTimeTab->updateLED(status == "ON");
    } else {
        serverChannel->send("get Temp");
        std::string tempStr = serverChannel->receive();
        lastTemperature = std::stod(tempStr);
        realTimeTab->updateTemperature(lastTemperature);
        historyTab->addTemperature(lastTemperature);
        realTimeTab->updateLED(lastTemperature > currentThreshold);
    }
}

void MainWindow::onThresholdChanged(double newThreshold) {
    currentThreshold = newThreshold;
}
