import QtQuick 2.0
import WPN114 1.0 as WPN114

Rectangle
{
    color: "transparent"

    WPN114.Node
    {
        id:     node_strings
        path:   "/modules/strings/display"
        type:   WPN114.Type.Int
        critical: true

        value:  0

        onValueReceived: string_canvas.requestPaint();
    }

    WPN114.Node
    {
        id:     node_trigger
        path:   "/modules/strings/trigger"
        type:   WPN114.Type.Impulse
        critical: true
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
            var nstrings   = node_strings.value;

            ctx.reset( );
            if ( !nstrings ) return;

            var tspace   = ( nstrings-1 )*spacing;
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
                    system.vibrate(100);
                    node_trigger.value = 0;
                    origin = string_canvas.width;
                }

                else if ( origin >= string_canvas.right_edge &&
                         mouse.x <= string_canvas.left_edge )
                {
                    system.vibrate(100);
                    node_trigger.value = 0;
                    origin = 0;
                }
            }
        }
    }
}
