import QtMultimedia 5.0
import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import QtQuick.Dialogs 1.2
import QtQuick.Window 2.0

Page{
    property alias text1_txt: text1.text
//    property alias text2_txt: text2.text
    id:kPlayer
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
                id:media
                width: parent.width
                height: 300
                color: "black"

                MediaPlayer{
                    id:player
                    source:"file:///run/media/root/343c117f-ca55-4783-9631-a7a6c5c319cf/lost+found/PostgraduateAPP/北京大学.mp4"   //文件路径
                    autoPlay: false  //默认不播放
                     volume: voice.value    //声音
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
                            start.status=0;
                            start.iconImage="qrc:/images/images/pause.png"
                            status=0;
                        }
                        else{
                            player.play() ;
                            start.status=1;
                            start.iconImage="qrc:/images/images/start.png"
                            status=1;
                        }
                    }
                }
            }

            Rectangle{  //  最下面 一排  播放进度和声音条
                id:control
                color:"#80202020"
                border.color: "gray"
                border.width: 1
                width:kPlayer.width
                height: 20
                Row{    //横
                    spacing: 10   //间隔
                    anchors.verticalCenter: parent.verticalCenter   //
                    anchors.leftMargin: 10   //左间隔
                    anchors.left: parent.left


                    //调节播放速度
                    Slider{  //滑块    (进度条 滑块)
                        id:playPos
                        width: kPlayer.width*0.75
                        height: 10

                        maximumValue: player.duration  //视频的长度
                        minimumValue: 0

                        value:player.position    //视频当前播放的位置
                        anchors.verticalCenter: parent.verticalCenter

                        stepSize:0     //每一次滑动的距离





                        style: SliderStyle {    //自定义滑块样式
                            groove: Rectangle {
                                id:rect
                                property alias rect: rect

                                width: kPlayer.width*0.75
                                height: 8
                                color: "gray"
                                radius: 2
                                Rectangle {
                                    anchors.left: parent.left
                                    anchors.top: parent.top
                                    anchors.bottom: parent.bottom
                                    width: player.duration>0?parent.width*player.position/player.duration:0       //进度条根据当前视频播放位置确定
                                    color: "blue"
                                }
                            }

                            handle: Rectangle {   //进行处理
                                anchors.centerIn: parent
                                color: control.pressed ? "white" : "darkgray"

                                border.color: "gray"

                                border.width: 2  //边框宽度

                                implicitWidth: 15
                                implicitHeight: 15
                                radius:7.5

                                Rectangle{

                                    width: parent.width-8
                                    height: width
                                    radius: width/2
                                    color: "blue"
                                    anchors.centerIn: parent

                                }
                            }
                        }

                        //点击鼠标设置播放位置
                        MouseArea {
                            property int pos
                            anchors.fill: parent
                            onClicked: {
                                if (player.seekable)
                                    pos = player.duration * mouse.x/parent.width   //以鼠标点击的位置计算视频播放的进度
                                player.seek(pos)
                                playPos.value=pos;  //进赋值后 原先绑定失效  ??
                            }
                        }



                    }


                    Slider{
                        id:voice
                        width: kPlayer.width*0.2
                        height: 10
                        value: 1>0 ? 1.0:player.volume
                        stepSize: 0.1
                        maximumValue: 1
                        minimumValue: 0
                        anchors.verticalCenter: parent.verticalCenter
                        style: SliderStyle {
                            groove: Rectangle {
                                implicitWidth: kPlayer.width*0.2
                                implicitHeight: 8
                                color: "gray"
                                radius: 2
                                Rectangle {
                                    anchors.left: parent.left
                                    anchors.top: parent.top
                                    anchors.bottom: parent.bottom
                                    width: player.volume>0?parent.width*player.volume:0  //当前声音进度条长度
                                    color: "blue"
                                }
                            }
                            handle: Rectangle {
                                anchors.centerIn: parent
                                color: control.pressed ? "white" : "darkgray"
                                border.color: "gray"
                                border.width: 2
                                implicitWidth: 15
                                implicitHeight: 15
                                radius:7.5
                                Rectangle{
                                    width: parent.width-8
                                    height: width
                                    radius: width/2
                                    color: "blue"
                                    anchors.centerIn: parent
                                }
                            }
                        }
                    }
                }
            }

            //控制区域
            Rectangle{
                id:bottom
                color:"#80202020"
                border.color: "gray"
                border.width: 1
                width: kPlayer.width
                height: 30
                Row{
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                    spacing: 10
                    MediaButton{
                        id:start
                        width: 30
                        height: 30
                        property int status: 0  //默认播放
                        iconImage: "qrc:/images/images/pause.png"
                        onClicked: {
                            if(status===1)
                            {
                                player.pause();
                                //                            tooltip="开始";
                                console.log("start")
                                status=0;
                                iconImage="qrc:/images/images/pause.png"
                            }
                            else{
                                player.play() ;
                                //                            tooltip="暂停";
                                console.log("pause")
                                status=1;
                                iconImage="qrc:/images/images/start.png"
                            }
                        }
                    }
                    MediaButton{
                        width: 30
                        height: 30
                        onClicked: player.stop()
                        //                    tooltip: "停止"
                        iconImage: "qrc:/images/images/quict.png"
                    }
                    //快进快退10s
                    MediaButton{
                        width: 30
                        height: 30
                        onClicked: player.seek(player.position+10000)
                        //                    tooltip: "快退"
                        iconImage: "qrc:/images/images/back.png"
                    }
                    MediaButton{
                        width: 30
                        height: 30
                        onClicked: player.seek(player.position-10000)
                        //                    tooltip: "快进"
                        iconImage: "qrc:/images/images/quick.png"
                    }

                    Text{
                        anchors.verticalCenter: parent.verticalCenter
                        text:parent.currentTime(player.position)+"/"+parent.currentTime(player.duration)
                        color: "white"
                    }
                    //时间格式化
                    function currentTime(time)
                    {
                        var sec= Math.floor(time/1000);
                        var hours=Math.floor(sec/3600);
                        var minutes=Math.floor((sec-hours*3600)/60);
                        var seconds=sec-hours*3600-minutes*60;
                        var hh,mm,ss;
                        if(hours.toString().length<2)
                            hh="0"+hours.toString();
                        else
                            hh=hours.toString();
                        if(minutes.toString().length<2)
                            mm="0"+minutes.toString();
                        else
                            mm=minutes.toString();
                        if(seconds.toString().length<2)
                            ss="0"+seconds.toString();
                        else
                            ss=seconds.toString();
                        return hh+":"+mm+":"+ss
                    }

                }

            }

        }
    }
}
