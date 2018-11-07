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
        name: "fréquence filtre"

        WPN114.Node on value { path: "/modules/mangler/filter/freq" }
        y: parent.height*0.2
    }

    QuarreSlider
    {
        name: "résonance filtre"

        WPN114.Node on value { path: "/modules/mangler/filter/res" }
        y: parent.height*0.2 * 2
    }

    WPN114.Node
    {
        id:     attitude
        path:   "/modules/mangler/filter/type"
        type:   WPN114.Type.Int
    }

    ComboBox
    {
        id: cb
        y: parent.height*0.2 *3
        height: parent.height*0.1
        width: parent.width*0.65
        anchors.horizontalCenter: parent.horizontalCenter
        model: [ "Passe-bas", "Passe-haut" ]

        onActivated: attitude.value = index;
    }

}
