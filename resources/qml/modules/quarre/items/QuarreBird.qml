import QtQuick 2.0

Rectangle
{
    property alias name: bird_text.text
    property int number_id: 0
    property bool paused: false

    id: bird_rect

    color: "black"
    opacity: 0.95

    height: parent.height*0.07
    width: parent.width*0.25

    Text
    {
        id:         bird_text
        text:       name
        color:      "#ffffff"

        horizontalAlignment:        Text.AlignHCenter
        verticalAlignment:          Text.AlignVCenter
        anchors.fill:               parent
        font.pointSize:             11 * root.fontRatio
        font.family:                font_lato_light.name
        antialiasing:               true

        MouseArea
        {
            anchors.fill: parent
            onPressed:
            {
                if ( !bird_rect.paused ) return;

                birds_node.value = Qt.vector3d(
                            number_id,
                            (bird_rect.x + bird_rect.width/2)/touchbirds_root.width,
                            (bird_rect.y + bird_rect.height/2)/touchbirds_root.height );

                bird_rect.color = "gray";
            }

            onReleased:
            {
                if ( !bird_rect.paused ) return;
                bird_rect.color = "black";
            }
        }
    }

    Timer
    {
        property real x_phs: 0
        property real y_phs: 0
        property real time_phs: 0
        property real duration: 2000

        property real destination_x: Math.random() * bird_rect.parent.width
        property real destination_y: Math.random() * bird_rect.parent.height

        id: movement_phase
        running: true
        interval: 30
        repeat: true

        onTriggered:
        {
            bird_rect.x     += x_phs;
            bird_rect.y     += y_phs;
            time_phs        += interval;

            if ( time_phs >= duration )
            {
                running     = false;
                time_phs    = 0;
                x_phs       = 0;
                y_phs       = 0;

                // setting new random values
                duration = Math.random() * 2000 + 500;
                destination_x = Math.random() * bird_rect.parent.width
                destination_y = Math.random() * bird_rect.parent.height

                // setting new xy phases
                x_phs = ( destination_x - bird_rect.x ) / duration * interval;
                y_phs = ( destination_y - bird_rect.y ) / duration * interval ;

                pause_timer.running = true;
                bird_rect.paused = true;
            }
        }
    }

    Timer
    {
        id: pause_timer
        running: false
        repeat: false
        interval: 5000

        onTriggered:
        {
            movement_phase.running = true;
            interval = Math.random() * 4000 + 1000;
            bird_rect.paused = false;
        }
    }
}
