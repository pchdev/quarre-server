import QtQuick 2.0
import QtQuick.Controls 2.0
import "items"

Rectangle
{
    anchors.fill: parent
    color: "transparent"

    QuarreSlider
    {
        name: "hauteur mod"
        min: -2.0; max: 2.0;
        value: ossia_modules.markhor_granular_pitch_env
        onValueChanged: ossia_modules.markhor_granular_pitch_env = value
        y: parent.height*0.2
    }

    QuarreSlider
    {
        name: "hauteur"
        min: -3; max: 3;
        value: ossia_modules.markhor_granular_pitch
        onValueChanged: ossia_modules.markhor_granular_pitch = Math.floor(value)
        y: parent.height*0.2*2
    }

    QuarreSlider
    {
        name: "densité"
        min: 0.125; max: 0.5
        value: ossia_modules.markhor_granular_overlap
        onValueChanged: ossia_modules.markhor_granular_overlap= value
        y: parent.height*0.2*3
    }

    /*ComboBox
    {
        y: parent.height*0.2*4
        height: parent.height*0.1
        width: parent.width*0.65
        anchors.horizontalCenter: parent.horizontalCenter
        model: [ "Model 1", "Model 2", "Model 3", "Model 4" ]
        onCurrentIndexChanged: ossia_modules.markhor_granular_sample = currentIndex;
    }*/
}
