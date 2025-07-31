import Quickshell
import QtQuick
import qs.styles

PanelWindow {
    id: root
    anchors {
        left: true
        right: true
        top: true
    }

    height: heightBar

    color: "transparent"

    mask: Region {}

    property real heightBar: 60

    StyledRect {

        color: "transparent"
        anchors.top: parent.top
        width: parent.width
        height: root.heightBar

        Row {
            anchors.fill: parent
            StyledRect {
                id: leftWing
                anchors.left: parent.left
                width: parent.width * 0.25
                height: parent.height
            }
            Corners {
                anchors.left: leftWing.right
                corner: Corners.CornerEnum.StraightTopLeft
                size: 60
                x: 0
            }

            StyledRect {

                height: parent.height * 0.8

                width: parent.width * 0.17
                radius: 50
                anchors.centerIn: parent
            }
            Corners {
                anchors.right: rightWing.left
                corner: Corners.CornerEnum.StraightTopRight
                size: 60
            }

            StyledRect {
                id: rightWing
                height: parent.height
                width: parent.width * 0.25
                anchors.right: parent.right
            }
        }
    }
}
