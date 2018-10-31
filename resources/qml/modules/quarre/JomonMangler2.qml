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
        name: "love"
        min: 0.0; max: 100.0;

        WPN114.Node on value { path: "/modules/mangler/love" }
        y: parent.height*0.2
    }

    QuarreSlider
    {
        name: "jive"
        min: 0.0; max: 100.0;

        WPN114.Node on value { path: "/modules/mangler/jive" }
        y: parent.height*0.2 * 2
    }

    WPN114.Node
    {
        id:     attitude
        path:   "/modules/mangler/attitude"
        type:   WPN114.Type.Int
    }

    ComboBox
    {
        id: cb
        y: parent.height*0.2 *3
        height: parent.height*0.1
        width: parent.width*0.65
        anchors.horizontalCenter: parent.horizontalCenter
        model: [ "Aucun", "Attitude 1", "Attitude 2", "Attitude 3" ]                

        onActivated:
            attitude.value = index;
    }

}
