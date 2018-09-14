import QtQuick 2.0

Rectangle
{
    property alias animation:           trigger_animation
    property alias title:               gesture_label.text
    property alias description:         gesture_description.text
    property alias trigger_animation:   trigger_animation
    property var gestures:              [ ]

    onEnabledChanged:
    {
        if ( enabled ) gesture_manager.backend.gestures = gestures;
        else gesture_manager.backend.gestures = [ ];

        gesture_manager.backend.enabled = enabled;
    }

    color: "transparent"

    Text //------------------------------------------------ GESTURE_LABEL
    {
        id:         gesture_label
        y:          parent.height*0.05
        width:      parent.width
        height:     parent.height
        color:      "#ffffff"
        text:       ""

        horizontalAlignment:    Text.AlignHCenter
        font.family:            font_lato_light.name
        font.pointSize:         34 * root.fontRatio
        textFormat:             Text.PlainText

        antialiasing: true
    }

    Text //------------------------------------------------ GESTURE_DESCRIPTION
    {
        id:         gesture_description
        y:          parent.height * 0.2
        text:       ""
        color:      "#ffffff"
        height:     parent.height/2
        width:      parent.width * 0.9
        wrapMode:   Text.WordWrap

        horizontalAlignment:        Text.AlignHCenter
        verticalAlignment:          Text.AlignTop
        anchors.horizontalCenter:   parent.horizontalCenter
        font.pointSize:             14 * root.fontRatio
        font.family:                font_lato_light.name
        antialiasing:               true
    }

    Rectangle
    {
        id: trigger_animation_circle
        color: "transparent"
        border.color: "white"
        border.width: 5
        x: parent.width/2 - width/2
        y: parent.height/2 - height/2
    }

    ParallelAnimation
    {
        id: trigger_animation
        NumberAnimation
        {
            target: trigger_animation_circle
            property: "width"
            from: 0
            to: parent.width
            duration: 1250
        }
        NumberAnimation
        {
            target: trigger_animation_circle
            property: "height"
            from: 0
            to: parent.width
            duration: 1250
        }
        NumberAnimation
        {
            target: trigger_animation_circle
            property: "radius"
            from: 0
            to: parent.width*0.5
            duration: 1250
        }
        SequentialAnimation
        {
            NumberAnimation
            {
                target: trigger_animation_circle
                property: "opacity"
                from: 0
                to: 0.8
                duration: 625
            }
            NumberAnimation
            {
                target: trigger_animation_circle
                property: "opacity"
                from: 0.8
                to: 0
                duration: 625
            }
        }
    }
}
