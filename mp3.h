#ifndef MP3_H
#define MP3_H
#include <QMediaPlaylist>
#include <QMediaPlayerControl>
#include <QFileDialog>
#include <QDir>
#include <QFileInfo>
#include <QObject>
#include <iostream>
#include <QStandardItemModel>
#include <QStandardItem>
#include <QTimer>
#include <QSettings>
#include <QDir>

using namespace std;

class mp3: public QObject
{
    Q_OBJECT
public:

    explicit mp3(QObject *parent = 0);
private:
    //QTimer *time= new QTimer;
    QMediaPlayer *player;
    QMediaPlaylist *playlist;
    QString fileName;
    QString name;
    QString n;
    int count;
    float volume;
    QStandardItemModel *model;
    QStandardItem *item;
    QSettings settings;
    int i;
    QTimer *timeraudio;


public slots:
        void playlistload();
    void clear();
    void open();
    void play();
    void stop();
    void pause();
    void setVolume(float volume);
    void setVolume(bool plus);
    void setPosition (float position);
    void play (int znachenie, int n);
    void Position();
    void setDeleteItem (int item);
    void sleep();
    void savevolume(float volumes);
signals:
     void sendToQml(QString name);
     void setvolume(QString volume);
     void volumeChange(float position2);
     void positionChange(float position);
     void setprogress (QString min, QString second);
};

#endif // MP3_H
