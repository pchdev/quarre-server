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
        name: "fréquence modulation"

        WPN114.Node on value { path: "/modules/mangler/lfo/rate" }
        y: parent.height*0.2
    }

    QuarreSlider
    {
        name: "drive modulation"

        WPN114.Node on value { path: "/modules/mangler/lfo/drive" }
        y: parent.height*0.2 * 2
    }

    WPN114.Node
    {
        id:     waveform
        path:   "/modules/mangler/lfo/waveform"
        type:   WPN114.Type.Float
    }

    ComboBox
    {
        id: cb
        y: parent.height*0.2 *3
        height: parent.height*0.1
        width: parent.width*0.65
        anchors.horizontalCenter: parent.horizontalCenter
        model: [ "Sinus", "Carré", "Triangle", "Aléatoire" ]

        onActivated: waveform.value = index/4;
    }

}
