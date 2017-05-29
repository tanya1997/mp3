#ifndef TRAY_H
#define TRAY_H

#include <QMenu>
#include <QMessageBox>
#include <QSystemTrayIcon>

class tray
{
public:
    tray();
private slots:
       void changeEvent(QEvent*);
       void trayIconActivated(QSystemTrayIcon::ActivationReason reason);
       void trayActionExecute();
       void setTrayIconActions();
       void showTrayIcon();
private:
       QMenu *trayIconMenu;
       QAction *minimizeAction;
       QAction *restoreAction;
       QAction *quitAction;
       QSystemTrayIcon *trayIcon;
};

#endif // TRAY_H
