#include "quickAccess.hpp"
#include <QPushButton>
#include <QVBoxLayout>
#include <QDesktopServices>
#include <QUrl>

QuickAccess::QuickAccess(QWidget *parent) : QWidget(parent) {
    QVBoxLayout *layout = new QVBoxLayout(this);
    QPushButton *fbButton = new QPushButton("Facebook", this);
    QPushButton *liButton = new QPushButton("LinkedIn", this);
    QPushButton *igButton = new QPushButton("Instagram", this);

    fbButton->setIcon(QIcon(":/facebook.png"));
    liButton->setIcon(QIcon(":/linkedin.png"));
    igButton->setIcon(QIcon(":/instagram.png"));

    layout->addWidget(fbButton);
    layout->addWidget(liButton);
    layout->addWidget(igButton);
    setLayout(layout);

    connect(fbButton, &QPushButton::clicked, []() {
        QDesktopServices::openUrl(QUrl("https://www.facebook.com"));
    });
    connect(liButton, &QPushButton::clicked, []() {
        QDesktopServices::openUrl(QUrl("https://www.linkedin.com"));
    });
    connect(igButton, &QPushButton::clicked, []() {
        QDesktopServices::openUrl(QUrl("https://www.instagram.com"));
    });
}
