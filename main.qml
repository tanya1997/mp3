import QtQuick 2.3
import QtQuick.Controls 1.2
import QtQuick.Dialogs 1.2
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.1
import QtQuick.Window 2.0

ApplicationWindow {
    id: applicationWindow1
    visible: true
    width: 425
    height: 120
    maximumWidth: 425
    maximumHeight: 120
    property alias rectangle2: rectangle2
    title: qsTr("Player")

       Connections {
            target: mp3
            onSendToQml:
                {
                    text1.text = name
                    listModel.append({ textList: text1.text} )
                }
            onPositionChange:
                {
                    sliderHorizontal2.value =  position
                }
            onSetvolume:
                {
                    text2.text = volume
                }
            onSetprogress:
                {
                    text3.text = min + ":"+ second
                }
            onVolumeChange:
                {
                    sliderHorizontal1.value =  position2
                }
        }
       Connections {
              target: systemTray
              onSignalShow: {
                  applicationWindow1.show();
              }

              onSignalIconActivated: {
                           if(applicationWindow1.visibility === Window.Hidden) {
                               applicationWindow1.show()
                           } else {
                               applicationWindow1.hide()
                           }
                      }
              onSignalQuit:
              {
                  Qt.quit();
              }
       }

       onClosing: {

                       close.accepted = false
                       applicationWindow1.hide()

                  }


        Text {
            //  signal sendToQml(string name)
                id: text1
                x: 73
                y: 6
                width: 297
                height: 34

               // text: //qsTr("222")
                wrapMode: Text.WrapAnywhere
                z: 9
                color: "#0550c3"
                font.pixelSize: 12
                Keys.onPressed: {

                    listModel.append({ textList: text1.text })
                    if (text1.text !=="")
                        sliderHorizontal2.maximumValue = 1

                                }


            }

        Text {
            id: text2
            color: "#062e6b"
            opacity: 0.7
            x: 12
            y: 52
            text: qsTr("0%")
            z: 9
            font.pixelSize: 12

        }
        Text {
            id: text3
            color: "#062e6b"
            opacity: 0.7
            x: 376
            y: 52
            width: 39
            height: 14
            text: qsTr("0:0")
            z: 9
            font.pixelSize: 12

        }

    Slider {
        id: sliderHorizontal1
        opacity: 0
        x: 12
        y: 5
        width: 23
        height: 44
        orientation: Qt.Vertical
       // value: 0
        maximumValue: 100
        minimumValue: 0
        z: 1
        onPressedChanged:
            {
                mp3.setVolume(value)
            }
        style: SliderStyle {
            Rectangle {

                       color: "gray"
                       radius: 3

                      }

            Rectangle {
                       anchors.fill: parent
                       color: "transparent"
                       radius: 3
                       border.width: 2
                       border.color: "black"
                      }

               }

}
    Slider {
        id: sliderHorizontal2
        y: 49
        height: 22
        maximumValue: 1
        minimumValue: 0
        anchors.right: parent.right
        anchors.rightMargin: 54
        anchors.left: parent.left
        anchors.leftMargin: 61
        z: 2
        onPressedChanged:
            {
            if (text1.text ==="")
                {


                }
            else
                {

                    mp3.setPosition(value)
                }
            }


        style: SliderStyle {
                    Rectangle {
                               color: "gray"
                               radius: 3
                              }
                   Rectangle {
                       anchors.fill: parent
                       color: "transparent"
                       radius: 3
                       border.width: 2
                       border.color: "black"
                   }

               }
         }




    Rectangle {
        id: rectangle1
        color: "steelblue"
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        gradient: Gradient {
             GradientStop {
                 position: 0.00;
                 color: "#97c7ee";
             }
             GradientStop {
                 position: 1.00;
                 color: "#84bbee";
             }
         }
         anchors.fill: parent
    }
    Image {
        id: volume
        source: "/volume.png"
        x:10
        y:80
       width: 30; height: 30
        Button {
                id: button1
                opacity: 0
                text: qsTr("Звук")
                anchors.fill: parent
                    onClicked:
                        {

                           if (sliderHorizontal1.opacity === 0)
                           {
                               while (sliderHorizontal1.opacity <1)
                               {
                                        sliderHorizontal1.opacity +=0.1
                                      mp3.sleep()
                               }
                           }

                           else
                         {

                               sliderHorizontal1.opacity -=0.1
                             mp3.sleep()
                           }

                        }

                   }


        }

    Image {
        id: file
        source: "/file.png"
        x:60
        y:80
        width: 30; height: 30
        Button {
                opacity: 0
                anchors.fill: parent
                    onClicked:
                        {
                            mp3.open()
                     //       listModel.append({ textList: text1.text} )

                        }

                   }


        }



Image {
    id: nazad
    source: "/nazad.png"
    x:100
    y:80
    width: 30; height: 30

    Button {
        opacity: 0
        anchors.fill: parent
        text: qsTr("Пуск")
        onClicked: {
                    mp3.play(listView1.currentIndex,-1)
                   }
           }
}
Image {
    id: vpered
    x:385
    y:80
    width: 30; height: 30
    source: "/vniz.png"
    Button
        {
opacity: 0
            anchors.fill: parent
            text: qsTr("Пуск")
            anchors.rightMargin: 0
            anchors.bottomMargin: 0
            anchors.leftMargin: 0
            anchors.topMargin: 0
            onClicked:
                {
                if (applicationWindow1.height >120)
                    {
                     vpered.source = "/vniz.png"
                    while (applicationWindow1.height>120)
                        {
                                applicationWindow1.setHeight(applicationWindow1.height-20);
                                applicationWindow1.setMaximumHeight(applicationWindow1.height);

                                mp3.sleep();
                        }
                    }

                else
                    {
                    vpered.source = "/vverh.png"
                    while (applicationWindow1.height<500)
                        {
                                applicationWindow1.setMaximumHeight(applicationWindow1.height+20);
                                applicationWindow1.setHeight(applicationWindow1.height+20);

                                mp3.sleep();
                        }


                    }


                }
        }

       }
Image {
    id: stop
    source: "/stopi.png"
    x:140
    y:80
    width: 30; height: 30
    Button {
        id: button5
        opacity: 0
        anchors.fill: parent
        text: qsTr("Пуск")
        onClicked: {
            mp3.stop()
            play.source = "/play.png"
            button4.text="play";
        }
    }
}
Image {
    id: play
    source: "/play.png"
    x:180
    y:80
    width: 30; height: 30
    Button {
        id: button4
        opacity: 0
        anchors.fill: parent
        text: qsTr("play")
        onClicked: {
            mp3.play()
            if (button4.text==="play")
            {
              if (text1.text!=="")
                {
                    play.source = "/pause.png";
                    button4.text="pause";
                    mp3.play;
                }
            } else
            {play.source = "/play.png"; button4.text="play"; mp3.pause()}


                   }
    }
}
Image {
    source: "/vpered.png"
    id: vpere
    x:220
    y:80
    width: 30; height: 30
    Button
        {
            opacity: 0
            anchors.fill: parent
            text: qsTr("Пуск")
            onClicked:
                {
                    mp3.play(listView1.currentIndex, 1)
                }
        }

}
Image {
    id: minus
    source: "/minus.png"
    x:260
    y:80
    width: 30; height: 30
    Button
        {
            opacity: 0
            anchors.fill: parent
            text: qsTr("Пуск")
            onClicked:
                {
                    mp3.setVolume(false)
                }

        }

       }
Image {
    id: plus
    source: "/plus.png"
    x:300
    y:80
    width: 30; height: 30
    Button
        {
            opacity: 0
            anchors.fill: parent
            text: qsTr("Пуск")
            onClicked:
                {
                    mp3.setVolume(true)
                }
        }

       }
Image {
    id: retur
    source: "/return.png"
    x:340
    y:80
    width: 30; height: 30
    Button
        {
            opacity: 0
            anchors.fill: parent
            text: qsTr("Пуск")
            onClicked:
                {
                    mp3.play(listView1.currentIndex, 0)
                }
        }

}

Image {
    id: clos
    source: "/stop.png"
    x:385
    y:10
    width: 30; height: 30
    Button {
        opacity: 0
            id: closeb
            text: qsTr("выход")
            anchors.fill: parent
                onClicked:
                    {
                         Qt.quit();


                    }

               }


    }

ScrollView {
    id: scroll
    x: 22
    y: 138
    width: 385
    height: 348
    verticalScrollBarPolicy: 0
    z: 12
    highlightOnFocus: true
    visible: true



        ListView {
                id: listView1
                x: 10
                y: 138
                width: 397
                height: 347
                anchors.rightMargin: 0
                anchors.bottomMargin: 30
                anchors.top: parent.top
                anchors.topMargin: 10
                anchors.left: parent.left
                anchors.right: parent.right
                spacing: 10
                contentHeight: 300
                keyNavigationWraps: true
                interactive: true
                z: 14
                  delegate: Text
                    {
                        id:textitem
                        color: "#062e6b"
                        opacity: 0.7
                        text: textList
                        font.italic: true
                        wrapMode: Text.WordWrap
                        width: 300
                        horizontalAlignment: Text.AlignHCenter


                        Item{
                            id: spisok
                            property variant itemData: model.modelData
                            width: 300
                            height: 40
                            MouseArea{
                                   id: itemMouseArea
                                   anchors.fill: parent
                                   onPressed: {
                                        listView1.currentIndex = index
                                        mp3.play(listView1.currentIndex,0)
                                        text1.text = textitem.text


                                             }
                                     }


                             }
                        Item{
                            id: buttons
                            x: 340
                            width: 15
                            height: 15

                            property variant itemData: model.modelData


                                Image {

                                    source: "/gtk-close.png"
                                    anchors.fill: parent

                                }
                                 Rectangle{
                                anchors.fill: parent
                                color: "white"
                                border.color: "blue"
                                border.width: 1
                                opacity: 0

                            }
                            MouseArea{
                                   id: itemMouseArea2
                                   anchors.fill: parent
                                   onPressed: {
                                       mp3.setDeleteItem(index)
                                    listModel.remove(index)




                                          }
                                     }
                        }
        }



           model: ListModel {id: listModel}


     }

   }
Rectangle
        {
            color: "#ffffff"
            id: rectangle2
            x: 22
            y: 138
            width: 385
            height: 348
            radius: 3
            border.color: "#9097f9"
            z: 0
            opacity: 0.7
            border.width: 3

    }
}

