import QtQuick 2.0
import QtQuick.Controls 2.0
import WPN114 1.0 as WPN114
import "items"
import "../basics/items"

Rectangle
{
    anchors.fill: parent
    color: "transparent"

    QuarreSlider
    {
        name: "hauteur mod"
        y: parent.height*0.2

        WPN114.Node on value { path: "/modules/markhor/granular/pitch_env" }
    }

    QuarreSlider
    {
        name: "hauteur"
        y: parent.height*0.2*2

        WPN114.Node on value { path: "/modules/markhor/granular/pitch" }
    }

    QuarreSlider
    {
        name: "densité"
        max: 0.29
        y: parent.height*0.2*3

        WPN114.Node on value { path: "/modules/markhor/granular/overlap" }
    }
}
