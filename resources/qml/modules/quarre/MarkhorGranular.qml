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
        min: -2.0; max: 2.0;
        y: parent.height*0.2

        WPN114.Node on value { path: "/modules/markhor/granular/pitch_env" }
    }

    QuarreSlider
    {
        name: "hauteur"
        min: -3; max: 3;
        y: parent.height*0.2*2

        WPN114.Node on value { path: "/modules/markhor/granular/pitch" }
    }

    QuarreSlider
    {
        name: "densité"
        min: 0.125; max: 0.35
        y: parent.height*0.2*3

        WPN114.Node on value { path: "/modules/markhor/granular/overlap" }
    }
}
