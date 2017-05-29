#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "mp3.h"
#include <QSystemTrayIcon>

#include "systemtray.h"
int main(int argc, char *argv[])
{

    QApplication app(argc, argv);
    QQmlApplicationEngine engine;
    mp3 model;
    QQmlContext *context = engine.rootContext();
    context->setContextProperty("mp3", &model);
    SystemTray * systemTray = new SystemTray();
    context->setContextProperty("systemTray", systemTray);

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    return app.exec();
}

