import QtMultimedia 5.0
import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.1

Page{
    property alias text1_txt: text1.text
//    property alias text2_txt: text2.text

    title:("More")

    Flickable{
        id:myflickable
        width: parent.width
        height: parent.height*2
        contentWidth: parent.width
        contentHeight: 7000
        flickableDirection: Flickable.VerticalFlick


        Column{
            anchors.fill: parent
            spacing: 20

            Text {
                id:text1
                width:parent.width
                wrapMode:Text.WordWrap  //文本自动换行
                font.pixelSize: 20
            }


            Rectangle{
                width: parent.width
                height: 300
                color: "black"

                MediaPlayer{
                    id:player
                    source:"file:///run/media/root/343c117f-ca55-4783-9631-a7a6c5c319cf/lost+found/PostgraduateAPP/北京大学.mp4"   //文件路径
                    autoPlay: false  //默认不播放
                }

                VideoOutput{
                    id:video
                    anchors.fill: parent
                    source: player
                }

                MouseArea {   //点击视频 暂停 和播放视频
                    anchors.fill: parent
                    property int status: 0
                    onClicked: {
                        if(status===1)
                        {
                            player.pause();

                            status=0;
                        }
                        else{
                            player.play() ;

                            status=1;
                        }
                    }
                }
            }

//            Text {
//                id:text2
//                width:parent.width

//                wrapMode:Text.WordWrap
//                font.pixelSize: 20
//            }
        }
    }
}
