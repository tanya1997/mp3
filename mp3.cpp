#include "mp3.h"
#include <QDebug>
#include <windows.h>

mp3::mp3(QObject *parent) : QObject(parent)
{
    QSettings settings("TEST",QSettings::IniFormat);
    QTimer *timer = new QTimer(this);
    connect(timer, SIGNAL(timeout()), this, SLOT(Position()));
    i = settings.value("i","").toInt();
    timeraudio = new QTimer(this);

    timer->start(100);
    timeraudio->start(100);
    connect(timeraudio, SIGNAL(timeout()), this, SLOT(playlistload()));

    model = new QStandardItemModel;
    player = new QMediaPlayer;
    playlist = new QMediaPlaylist;

}

void mp3::open()
{


   QSettings settings("TEST",QSettings::IniFormat);
   fileName = QFileDialog::getOpenFileName(NULL,
                               QString::fromUtf8("Открыть файл"),
                               settings.value("papka").toString(),
                               "Music (*.mp3);;All files (*.*)");
   qDebug() << fileName;

   if (fileName!="")
       {
           playlist->addMedia(QUrl::fromLocalFile(fileName));
           player->setPlaylist(playlist);
           player->setVolume((settings.value("sound")).toInt());
           player->play();
           QFileInfo fi(fileName);

           name = fi.fileName();
           emit sendToQml(name);
           i++;
           emit volumeChange (player->volume());
           emit setvolume (QString::number(player->volume())+"%");
           settings.setValue("papka",fi.path());
           settings.setValue("i",i);
           settings.setValue(QString("Row%1").arg(i),fileName);
           settings.sync();
       }
}
void mp3::savevolume(float volumes)
{
    QSettings settings("TEST",QSettings::IniFormat);
    settings.setValue("sound", QString::number(volumes));
    qDebug() << volumes;
}

void mp3::stop()
{
    player->stop();

}

void mp3::pause()
{
    player->pause();  
}

void mp3::play()
{
    player->play();
}

void mp3::setVolume(float volume)
{
    player->setVolume(volume);
    qDebug() << volume;
    setvolume(QString::number(floor(volume))+"%");
    savevolume(player->volume());

}

void mp3::setVolume(bool plus)
{
    if (plus == true)
        player->setVolume(player->volume()+10);
    else
        player->setVolume(player->volume()-10);
    emit setvolume(QString::number(player->volume())+"%");
    emit volumeChange(player->volume());
    savevolume(player->volume());
}

void mp3::setPosition(float position)
{
    player->setPosition(position*player->duration());
}


void mp3::play(int znachenie, int n)
{
    playlist->setCurrentIndex(znachenie+n);
    player->play();


}
void mp3::sleep()
{
    Sleep(50);
}

void mp3::Position()
{
    if (player->duration()!=0) emit positionChange((float)player->position()/player->duration());
    setprogress(QString::number(floor(player->position()/60000.0)),QString::number((player->position() % 60000) / 1000));
}

void mp3::clear()
{
    playlist->clear();
}

void mp3::playlistload()
{
    QSettings settings("TEST",QSettings::IniFormat);
    for (int t = 0; t<=settings.value("i","").toInt(); t++)
        {
            playlist->addMedia(QUrl::fromLocalFile((settings.value(QString("Row%1").arg(t),"")).toString()));
            player->setPlaylist(playlist);
            if (settings.value(QString("Row%1").arg(t),"").toString()!="")
            {
             emit sendToQml((settings.value(QString("Row%1").arg(t),"")).toString());
            }
        }
    player->setVolume((settings.value("sound")).toInt());
    emit volumeChange (player->volume());
    emit setvolume (QString::number(player->volume())+"%");
    timeraudio->stop();
    disconnect(timeraudio, SIGNAL(timeout()), this, SLOT(playlistload()));
}

void mp3::setDeleteItem(int item)
{
    QSettings settings("TEST",QSettings::IniFormat);
    qDebug()<<item;
    settings.remove(QString("Row%1").arg(item));
    playlist->removeMedia(item);
}
