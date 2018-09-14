import QtQuick 2.0
import QtQuick.Controls 2.0
import "items"

Rectangle
{
    anchors.fill: parent
    color: "transparent"

    QuarreSlider
    {
        name: "love"
        min: 0.0; max: 100.0;
        value: ossia_modules.jomon_mangler_love
        onValueChanged: ossia_modules.jomon_mangler_love = value
        y: parent.height*0.2
    }

    QuarreSlider
    {
        name: "jive"
        min: 0.0; max: 100.0;
        value: ossia_modules.jomon_mangler_jive
        onValueChanged: ossia_modules.jomon_mangler_jive = value
        y: parent.height*0.2 * 2
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
            ossia_modules.jomon_mangler_attitude = index;
    }

}
