import QtQuick 2.0
import QtQuick.Controls 2.0
import "../basics/items"
import WPN114 1.0 as WPN114

Rectangle
{
    anchors.fill: parent
    color: "transparent"

    QuarreSlider
    {
        name: "hauteur"
        min: -3; max: 3;

        WPN114.Node on value { path: "/modules/vare/granular/pitch" }
        y: parent.height*0.05
    }

    QuarreSlider
    {
        name: "densité"
        min: 0.5; max: 4.0

        WPN114.Node on value { path: "/modules/vare/granular/overlap" }
        y: parent.height*0.2
    }

    QuarreSlider
    {
        name: "vitesse"
        min: 2.0; max: 110.0

        WPN114.Node on value { path: "/modules/vare/granular/rate" }
        y: parent.height*0.35
    }

    QuarreSlider
    {
        name: "position"

        WPN114.Node on value { path: "/modules/vare/granular/position" }
        y: parent.height*0.5
    }

    QuarreSlider
    {
        name: "position_mod"
        min: -1.0; max: 1.0

        WPN114.Node on value { path: "/modules/vare/granular/position-mod" }
        y: parent.height*0.65
    }

}
