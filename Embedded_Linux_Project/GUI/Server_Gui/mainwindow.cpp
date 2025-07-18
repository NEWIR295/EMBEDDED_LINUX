#include "mainwindow.h"
#include <QTabWidget>
#include <QQuickWidget>
#include <QDoubleSpinBox>
#include <QPushButton>
#include <QDesktopServices>
#include <QUrl>
#include <QLabel>
#include <QVBoxLayout>
#include <QHBoxLayout>
#include <QQmlContext>
#include <QStatusBar>

class TemperatureModel : public QStandardItemModel {
public:
    TemperatureModel(QObject* parent = nullptr) : QStandardItemModel(parent) {
        setColumnCount(2);
        setHorizontalHeaderLabels({"Index", "Temperature"});
    }

    void addTemperature(double temperature) {
        int row = rowCount();
        setItem(row, 0, new QStandardItem(QString::number(row)));
        setItem(row, 1, new QStandardItem(QString::number(temperature)));
    }
};

MainWindow::MainWindow(const std::string& ip, int port, QWidget* parent)
    : QMainWindow(parent), currentThreshold(30.0) {
    QTabWidget* tabWidget = new QTabWidget;

    // Tab 1: Real Time Monitor
    QQuickWidget* meterWidget = new QQuickWidget;
    meterWidget->setSource(QUrl("qrc:///qml/meter.qml"));
    meterWidget->rootContext()->setContextProperty("currentTemperature", 0.0);
    tabWidget->addTab(meterWidget, "Real Time Monitor");

    // Tab 2: Historical Analysis
    temperatureModel = new TemperatureModel(this);
    QQuickWidget* chartWidget = new QQuickWidget;
    chartWidget->setSource(QUrl("qrc:///qml/chart.qml"));
    chartWidget->rootContext()->setContextProperty("temperatureModel", temperatureModel);
    tabWidget->addTab(chartWidget, "Historical Analysis");

    // Tab 3: Configuration
    QWidget* configTab = new QWidget;
    QVBoxLayout* configLayout = new QVBoxLayout(configTab);
    QDoubleSpinBox* thresholdSpinBox = new QDoubleSpinBox;
    thresholdSpinBox->setRange(0.0, 100.0);
    thresholdSpinBox->setValue(currentThreshold);
    configLayout->addWidget(new QLabel("Set Threshold (°C):"));
    configLayout->addWidget(thresholdSpinBox);
    configLayout->addStretch();
    tabWidget->addTab(configTab, "Configuration");

    // Tab 4: Quick Access
    QWidget* quickAccessTab = new QWidget;
    QHBoxLayout* quickAccessLayout = new QHBoxLayout(quickAccessTab);
    QPushButton* fbButton = new QPushButton("Facebook");
    fbButton->setIcon(QIcon(":/icons/facebook.png"));
    connect(fbButton, &QPushButton::clicked, [](){ QDesktopServices::openUrl(QUrl("https://www.facebook.com/share/19hfjncKaN/")); });
    quickAccessLayout->addWidget(fbButton);
    QPushButton* linkedinButton = new QPushButton("LinkedIn");
    linkedinButton->setIcon(QIcon(":/icons/linkedin.png"));
    connect(linkedinButton, &QPushButton::clicked, [](){ QDesktopServices::openUrl(QUrl("https://www.linkedin.com/company/edges-for-training/")); });
    quickAccessLayout->addWidget(linkedinButton);
    QPushButton* instagramButton = new QPushButton("Instagram");
    instagramButton->setIcon(QIcon(":/icons/instagram.png"));
    connect(instagramButton, &QPushButton::clicked, [](){ QDesktopServices::openUrl(QUrl("https://www.instagram.com/edgesfortraining")); });
    quickAccessLayout->addWidget(instagramButton);
    quickAccessLayout->addStretch();
    tabWidget->addTab(quickAccessTab, "Quick Access");

    setCentralWidget(tabWidget);

    // LED Status
    ledLabel = new QLabel("LED: OFF");
    ledLabel->setStyleSheet("background-color: red; color: white; padding: 5px;");
    statusBar()->addWidget(ledLabel);

    // Connect threshold change
    connect(thresholdSpinBox, &QDoubleSpinBox::valueChanged, [this](double value){
        currentThreshold = value;
        emit thresholdChanged(value);
    });

    // Worker thread setup
    workerThread = new QThread;
    worker = new Server(ip, port);
    worker->moveToThread(workerThread);
    connect(workerThread, &QThread::started, worker, &Server::start);
    connect(worker, &Server::temperatureReceived, this, &MainWindow::onTemperatureReceived);
    connect(this, &MainWindow::thresholdChanged, worker, &Server::onThresholdChanged);
    workerThread->start();

    // Optional background
    setStyleSheet("QMainWindow { background-image: url(:/icons/background.jpg); }");
}

MainWindow::~MainWindow() {
    workerThread->quit();
    workerThread->wait();
    delete worker;
    delete workerThread;
}

void MainWindow::onTemperatureReceived(double temperature) {
    QQuickWidget* meterWidget = qobject_cast<QQuickWidget*>(centralWidget()->findChild<QQuickWidget*>());
    if (meterWidget) {
        meterWidget->rootContext()->setContextProperty("currentTemperature", temperature);
    }
    temperatureModel->addTemperature(temperature);
    ledLabel->setText(temperature > currentThreshold ? "LED: ON" : "LED: OFF");
    ledLabel->setStyleSheet(temperature > currentThreshold ? "background-color: green; color: white; padding: 5px;" : "background-color: red; color: white; padding: 5px;");
}
