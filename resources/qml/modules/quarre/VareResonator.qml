import QtQuick 2.0
import "items"

Rectangle
{
    id: vres
    anchors.fill: parent
    color: "transparent"

    property var rates: [ 0.571, 0.8565, 1.142, 1.713, 2.284 ]

    function update(idx, st)
    {
        if ( st )
        {
            pad_repeater.itemAt(0).release();
            pad_repeater.itemAt(idx).push();

            ossia_modules.vare_seq_rate = rates[idx];
        }
        else
        {
            pad_repeater.itemAt(idx).release();
            pad_repeater.itemAt(0).push();

            ossia_modules.vare_seq_rate = rates[0];
        }
    }

    Row
    {
        spacing: 10
        width: parent.width
        height: parent.height*0.25
        y: parent.height *0.1
        x: parent.height*0.13

        Repeater
        {
            id: pad_repeater
            model: rates
            QuarrePad
            {
                pad_index: index
                onPressedChanged: vres.update(pad_index, pressed);
                height: vres.height*0.15
                width: height
            }
        }
    }

    QuarreSlider
    {
        name: "position"
        value: ossia_modules.vare_resonator_inpos
        onValueChanged: ossia_modules.vare_resonator_inpos = value
        y: parent.height*0.2*2
    }

    QuarreSlider
    {
        name: "échelle de résonance"
        min: -2.0; max: 2.0;
        onValueChanged: ossia_modules.vare_resonator_pitch_p = value
        value: ossia_modules.vare_resonator_pitch_p
        y: parent.height*0.2*3;
    }

    property bool proximity_state: false

    onEnabledChanged:
    {
        sensor_manager.proximity.active = enabled;
        poll.running = enabled;
    }

    Timer
    {
        id: poll
        interval: 50
        repeat: true

        onTriggered:
        {
            if ( sensor_manager.proximity.reading.near && !proximity_state )
            {
                proximity_state = true;
                ossia_modules.jomon_palm_state = true;
            }

            else if ( !sensor_manager.proximity.reading.near && proximity_state )
            {
                proximity_state = false;
                ossia_modules.jomon_palm_state = false;
            }
        }
    }
}
