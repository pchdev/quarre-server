import QtQuick 2.0
import WPN114 1.0 as WPN114

Rectangle
{
    id: root
    property var setup
    property var currentSources: [ ]
    color: "black"

    function clear()
    {
        for ( var i = 0; i < currentSources.length; ++i )
        {
            var item = currentSources[i];
            item.destroy();
        }

        currentSources.length = 0;
    }    

    function drawSetup()
    {
        var speakers = setup.speakerList();

        speakers.forEach(function(speaker){
            var position = speaker.position;
            var h_area = speaker.horizontalArea;
            var influence = h_area.radius;

            console.log(position);

            var component = Qt.createComponent("items/Speaker.qml");
            var obj = component.createObject(root, {
                        "x": position.x*root.width - 5,
                        "y": position.y*root.height -5 })

            var influence_width = root.width*influence*2;
            var infcomponent = Qt.createComponent("items/SpeakerInfluence.qml");
            var infobj = infcomponent.createObject(root, {
                        "x": position.x*root.width - root.width*influence,
                        "y": position.y*root.height - root.height*influence,
                        "width": influence_width })
        });
    }

    function drawScene(scene)
    {
        clear();

        var target_node = net.server.get(scene);
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
