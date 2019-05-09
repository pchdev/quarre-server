import QtQuick 2.0
import WPN114 1.0 as WPN114
import "items"
import "../basics/items"

Rectangle
{
    anchors.fill: parent
    color: "transparent"

    QuarreSlider
    {
        name: "ton"

        WPN114.Node on value { path: "/modules/vare/body/tone" }
        y: parent.height*0.05
    }

    QuarreSlider
    {
        name: "fréquence de résonance"

        WPN114.Node on value { path: "/modules/vare/body/pitch" }
        y: parent.height*0.20
    }

    WPN114.Node
    {
        id: xy
        path: "/modules/vare/body/xy"
        type: WPN114.Type.Vec2f
        value: Qt.vector2d(0, 0)
    }

    QuarreSlider
    {
        name: "modèle horizontal"
        onValueChanged: xy.value.x = value;
        y: parent.height*0.35
    }

    QuarreSlider
    {
        name: "modèle vertical"
        onValueChanged: xy.value.y = value;
        y: parent.height*0.5
    }
}
