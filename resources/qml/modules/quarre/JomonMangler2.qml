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
        name: "attitude"
        min: 0; max: 3.1;
        WPN114.Node on value { path: "/modules/mangler/attitude" }
        y: parent.height*0.2
    }

    QuarreSlider
    {
        name: "love"
        min: 0; max: 100;
        WPN114.Node on value { path: "/modules/mangler/love" }
        y: parent.height*0.2 * 2
    }

    QuarreSlider
    {
        name: "jive"
        min: 0; max: 150;
        WPN114.Node on value { path: "/modules/mangler/jive" }
        y: parent.height*0.2 * 3
    }
}
