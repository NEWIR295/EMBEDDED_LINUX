#ifndef HISTORICALANALYSIS_HPP
#define HISTORICALANALYSIS_HPP

#include <QWidget>
#include <QQuickWidget>
#include <vector>

class HistoricalAnalysis : public QWidget {
    Q_OBJECT
public:
    HistoricalAnalysis(QWidget *parent = nullptr);
    void addTemperature(double temp);
private:
    QQuickWidget *chartView;
    std::vector<double> temperatures;
    int pointCount = 0;
};

#endif // HISTORICALANALYSIS_HPP
