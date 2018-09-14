import QtQuick 2.0

Rectangle
{
    color: "transparent"

    Connections
    {
        target: ossia_modules.strings
        onValueChanged: string_canvas.requestPaint();
    }

    Canvas
    {
        id: string_canvas
        anchors.fill: parent
        property real spacing: width*0.1
        property real left_edge: 0
        property real right_edge: 0

        onPaint:
        {
            var ctx        = string_canvas.getContext('2d');
            var nstrings   = ossia_modules.strings.value;

            ctx.reset( );
            if ( !nstrings ) return;

            var tspace   = (nstrings-1)*spacing;
            var l_edge   = string_canvas.width/2-tspace/2;

            string_canvas.left_edge  = l_edge;
            string_canvas.right_edge = l_edge+tspace

            ctx.strokeStyle  = "#ffffff";
            ctx.lineWidth    = 5;

            for ( var i = 0; i < nstrings; ++i )
            {
                var xpos = l_edge+spacing*i;
                ctx.moveTo(xpos, 0);
                ctx.lineTo(xpos, string_canvas.height);
                ctx.stroke();
            }
        }

        MouseArea
        {
            property real origin: 0.0

            anchors.fill: parent
            onPressed: origin = mouseX;

            onPositionChanged:
            {
                if ( origin <= string_canvas.left_edge &&
                        mouse.x >= string_canvas.right_edge )
                {
                    ossia_net.oshdl.vibrate(100);
                    ossia_modules.strings_trigger = !ossia_modules.strings_trigger;
                    origin = string_canvas.width;
                }

                else if ( origin >= string_canvas.right_edge &&
                         mouse.x <= string_canvas.left_edge )
                {
                    ossia_net.oshdl.vibrate(100);
                    ossia_modules.strings_trigger = !ossia_modules.strings_trigger;
                    origin = 0;
                }
            }
        }
    }
}
