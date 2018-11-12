import QtQuick 2.0
import WPN114 1.0 as WPN114

Rectangle
{
    id: root
    property var setup
    property WPN114.Rooms target
    property var currentSources: [ ]

    color: "black"
    antialiasing: true

    Component.onCompleted:
    {
        var positions = setup.nodes[0].position;
        var infl = setup.nodes[0].influence;

        for ( var s = 0; s < positions.length; ++s )
        {
            var pos = positions[ s ];
            var component = Qt.createComponent("Speaker.qml");
            var speaker = component.createObject(root, {
                    "x": pos.x*root.width - 5,
                    "y": pos.y*root.height - 5 })

            var influence_width = root.width*infl*2;

            var inflcomponent = Qt.createComponent("SpeakerInfluence.qml");
            var influence_ring = inflcomponent.createObject(root, {
                    "x":  pos.x*root.width - root.width*infl,
                    "y":  pos.y*root.height - root.height*infl,
                    "width": influence_width })
        }

        var target_node = net.server.get("/woodpath/carre/audio");
        var sources = target_node.collect( "source" );

        for ( var s = 0; s < sources.length; ++s )
        {
            var source = sources[ s ];
            var component = Qt.createComponent("RoomSourceView.qml");
            var obj = component.createObject(root, { "node": source });

            currentSources.push( obj );
        }
    }

    Rectangle
    {
        y: parent.height/2
        width: parent.width
        height: 1

        color: "grey"
    }

    Rectangle
    {
        x: parent.width/2
        width: 1
        height: parent.height
        color: "grey"
    }
}
