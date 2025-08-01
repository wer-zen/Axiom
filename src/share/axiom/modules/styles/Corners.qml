import QtQuick
import QtQuick.Shapes
import QtQuick.Controls

Item {
    id: root

    enum CornerEnum {
        TopLeft,
        TopRight,
        BottomLeft,
        BottomRight,
        StraightTopLeft,
        StraightTopRight,
        StraightBottomLeft,
        StraightBottomRight
    }
    property var corner: Corners.CornerEnum.TopLeft // Default to TopLeft

    property int size: 25
    property color color: "#000000"

    onColorChanged: {
        canvas.requestPaint();
    }
    onCornerChanged: {
        canvas.requestPaint();
    }

    implicitWidth: size
    implicitHeight: size

    Canvas {
        id: canvas

        anchors.fill: parent
        antialiasing: true

        onPaint: {
            var ctx = getContext("2d");
            var r = root.size;
            ctx.clearRect(0, 0, canvas.width, canvas.height);
            ctx.beginPath();
            switch (root.corner) {
            case Corners.CornerEnum.TopLeft:
                ctx.arc(r, r, r, Math.PI, 3 * Math.PI / 2);
                ctx.lineTo(0, 0);
                break;
            case Corners.CornerEnum.TopRight:
                ctx.arc(0, r, r, 3 * Math.PI / 2, 2 * Math.PI);
                ctx.lineTo(r, 0);
                break;
            case Corners.CornerEnum.BottomLeft:
                ctx.arc(r, 0, r, Math.PI / 2, Math.PI);
                ctx.lineTo(0, r);
                break;
            case Corners.CornerEnum.BottomRight:
                ctx.arc(0, 0, r, 0, Math.PI / 2);
                ctx.lineTo(r, r);
                break;
            }
            ctx.closePath();
            ctx.fillStyle = root.color;
            ctx.fill();
        }
    }
    Shape {
        anchors.fill: parent
        visible: root.corner >= Corners.CornerEnum.StraightTopLeft // Only show for straight corners

        ShapePath {
            strokeColor: "black"
            strokeWidth: 1
            fillColor: "black" // Make fill transparent so we only see the stroke

            property int joinStyleIndex: 0
            property variant styles: [ShapePath.BevelJoin, ShapePath.MiterJoin, ShapePath.RoundJoin]
            joinStyle: styles[joinStyleIndex]

            startX: {
                switch (root.corner) {
                case Corners.CornerEnum.StraightTopLeft:
                case Corners.CornerEnum.StraightBottomLeft:
                    return 0;
                case Corners.CornerEnum.StraightTopRight:
                case Corners.CornerEnum.StraightBottomRight:
                    return root.size;
                default:
                    return 0;
                }
            }

            startY: {
                switch (root.corner) {
                case Corners.CornerEnum.StraightTopLeft:
                case Corners.CornerEnum.StraightTopRight:
                    return 0;
                case Corners.CornerEnum.StraightBottomLeft:
                case Corners.CornerEnum.StraightBottomRight:
                    return root.size;
                default:
                    return 0;
                }
            }

            PathLine {
                x: {
                    switch (root.corner) {
                    case Corners.CornerEnum.StraightTopLeft:
                        return root.size;
                    case Corners.CornerEnum.StraightTopRight:
                        return root.size;
                    case Corners.CornerEnum.StraightBottomLeft:
                        return root.size;
                    case Corners.CornerEnum.StraightBottomRight:
                        return 0;
                    default:
                        return 0;
                    }
                }
                y: {
                    switch (root.corner) {
                    case Corners.CornerEnum.StraightTopLeft:
                        return 0;
                    case Corners.CornerEnum.StraightTopRight:
                        return root.size;
                    case Corners.CornerEnum.StraightBottomLeft:
                        return 0;
                    case Corners.CornerEnum.StraightBottomRight:
                        return 0;
                    default:
                        return 0;
                    }
                }
            }

            PathLine {
                x: {
                    switch (root.corner) {
                    case Corners.CornerEnum.StraightTopLeft:
                        return 0;
                    case Corners.CornerEnum.StraightTopRight:
                        return 0;
                    case Corners.CornerEnum.StraightBottomLeft:
                        return 0;
                    case Corners.CornerEnum.StraightBottomRight:
                        return 0;
                    default:
                        return 0;
                    }
                }
                y: {
                    switch (root.corner) {
                    case Corners.CornerEnum.StraightTopLeft:
                        return root.size;
                    case Corners.CornerEnum.StraightTopRight:
                        return 0;
                    case Corners.CornerEnum.StraightBottomLeft:
                        return 0;
                    case Corners.CornerEnum.StraightBottomRight:
                        return 0;
                    default:
                        return 0;
                    }
                }
            }
        }
    }

    Behavior on size {
        animation: Appearance?.animation.elementMoveFast.numberAnimation.createObject(this)
    }
}
