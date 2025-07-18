#include "mainwindow.h"
#include <QApplication>

int main(int argc, char *argv[]) {
    QApplication app(argc, argv);
    MainWindow window("192.168.7.1", 8080);
    window.show();
    return app.exec();
}
