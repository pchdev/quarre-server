import QtQuick 2.0
import QtQuick.Controls 2.0
import "items"

Rectangle
{
    // pitchbend + tempo variations + mode
    anchors.fill: parent
    color: "transparent"

    Canvas
    {
        id: string_canvas
        x: parent.width*0.5
        width: parent.width*0.5
        height: parent.height*0.5

        onPaint:
        {
            var ctx        = string_canvas.getContext('2d');

            ctx.strokeStyle  = "#ffffff";
            ctx.lineWidth    = 5;

            var xpos = string_canvas.width*0.5;
            ctx.moveTo(xpos, 0);
            ctx.lineTo(xpos, string_canvas.height);
            ctx.stroke();
        }

        MouseArea
        {
            id: marea
            property real origin: 0.0

            anchors.fill: parent
            onPressed: origin = mouseX;

            onPositionChanged:
            {
                if ( origin <= string_canvas.width/2 &&
                        mouse.x >= string_canvas.width/2 )
                {
                    ossia_net.oshdl.vibrate(50);
                    ossia_modules.jomon_arp_trigger = !ossia_modules.jomon_arp_trigger;
                    origin = string_canvas.width;
                }

                else if ( origin >= string_canvas.width/2 &&
                         mouse.x <= string_canvas.width/2 )
                {
                    ossia_net.oshdl.vibrate(50);
                    ossia_modules.jomon_arp_trigger = !ossia_modules.jomon_arp_trigger;
                    origin = 0;
                }
            }
        }
    }

    QuarreWheelSlider
    {
        from: -1; to: 1;
        midValue: 0.0

        height: parent.height * 0.5
        width: height * 0.4
        y: 0
        x: parent.height * 0.2
        value: ossia_modules.jomon_arp_bend
        live: true

        onValueChanged: ossia_modules.jomon_arp_bend = value
    }

    Rectangle
    {
        color: "transparent"
        width: parent.width
        height: parent.height*0.5
        y: parent.height * 0.55

        QuarreSlider
        {
            name: "réverbération"
            value: ossia_modules.jomon_reverb_level
            onValueChanged: ossia_modules.jomon_reverb_level = value
            height: parent.height * 0.2
        }

        QuarreSlider
        {
            name: "filtrage"
            min: 0.25; max: 1.0
            value: ossia_modules.jomon_lpf_freq
            onValueChanged: ossia_modules.jomon_lpf_freq = value
            y: parent.height*0.25
            height: parent.height * 0.2
        }

        ComboBox
        {
            id: cb
            y: parent.height*0.5
            height: parent.height*0.25
            width: parent.width*0.65
            anchors.horizontalCenter: parent.horizontalCenter
            model: [ "FIFO", "Down", "Up", "Up/Down", "Random" ]

            onActivated:
                ossia_modules.jomon_arp_mode = textAt(index);
        }
    }
}
