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
        min: 0.5; max: 1;

        WPN114.Node on value { path: "/modules/vare/granular/pitch" }
        y: parent.height*0.05
    }

    QuarreSlider
    {
        name: "hauteur_mod"

        WPN114.Node on value { path: "/modules/vare/granular/pitch-env" }
        y: parent.height*0.2
    }

    QuarreSlider
    {
        name: "densité"
        min: 0; max: 0.29

        WPN114.Node on value { path: "/modules/vare/granular/overlap" }
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

        WPN114.Node on value { path: "/modules/vare/granular/position-mod" }
        y: parent.height*0.65
    }

}
