import QtQuick 2.0
import WPN114 1.0 as WPN114
import "items"

Rectangle
{
    id:         root
    color:      "#232426"
    opacity:    0.8

    property int recording_phase:   0;
    property int sending_phase:     0;
    property var trajectory:        []
    property int trajectory_size:   0;
    property bool recording:        false

    property vector2d recording_value: Qt.vector2d(0, 0)

    WPN114.Node
    {
        id:     node_trigger
        path:   "/modules/trajectories/trigger"
        type:   WPN114.Type.Impulse
    }

    WPN114.Node
    {
        id:     node_position2D
        path:   "/modules/trajectories/position2D"
        type:   WPN114.Type.Vec2f
    }

    Timer
    {
        id: record_timer
        running: false
        repeat: true
        interval: 25

        onTriggered:
        {
            var x = trajectory_area.mouseX/trajectory_area.width;
            var y = trajectory_area.mouseY/trajectory_area.height;
            recording_value = Qt.vector2d(x,y);

            trajectory[recording_phase] = Qt.vector2d(x,y);
            recording_phase++;
            trajectory_size++;
            trajectory_canvas.requestPaint();
        }
    }

    Timer
    {
        id: send_timer
        running: false
        repeat: true
        interval: 25

        onTriggered:
        {
            node_position2D.value = trajectory[sending_phase];
            sending_phase++;

            trajectory_canvas.requestPaint();

            if ( sending_phase >= trajectory_size )
                running = false;
        }
    }

    SpatializationSphere { }

    MouseArea
    {
        id: trajectory_area
        anchors.fill: parent

        onPressed:
        {
            // start polling timer, poll with limited time (3 or 4 seconds max)

            trajectory.length   = 0;
            recording_phase     = 0;
            sending_phase       = 0;
            trajectory_size     = 0;
            recording           = true;

            trajectory_canvas.getContext('2d').reset();
            record_timer.running = true;
        }

        onReleased:
        {
            // send trigger
            // start sender timer, poll recorded data
            trajectory_canvas.getContext('2d').reset();
            node_trigger.value = 0;
            record_timer.running = false;
            send_timer.running = true;
            recording = false;
        }

        Canvas
        {
            id: trajectory_canvas
            anchors.fill: parent
            onPaint:
            {
                var ctx = trajectory_canvas.getContext('2d');
                var w = trajectory_canvas.width * 0.1
                var x = 0, y = 0;

                if ( recording )
                {
                    ctx.strokeStyle = "red";
                    x = recording_value.x * trajectory_canvas.width - w;
                    y = recording_value.y * trajectory_canvas.height -w;
                }
                else
                {
                    ctx.strokeStyle = "#ffffff";
                    x = node_position2D.value.x * trajectory_canvas.width - w;
                    y = node_position2D.value.y * trajectory_canvas.height - w;
                }
                ctx.ellipse(x,y,w,w);
                ctx.stroke();
            }
        }
    }
}
