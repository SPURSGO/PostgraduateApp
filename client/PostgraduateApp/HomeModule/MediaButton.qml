import QtQuick 2.0

Rectangle{
    id:root

    property alias iconImage: img.source
    signal clicked

    Image {
        id: img

        anchors.fill: parent
    }

    MouseArea{
        id:mouse
        anchors.fill: parent
        onClicked:
            root.clicked()


    }
}
