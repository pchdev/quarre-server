import QtQuick 2.0
import WPN114 1.0 as WPN114
import "scenes"

Item
{
    id: root

    property int idkey:             0
    property var owners:            [ ];
    property string title:          ""
    property string description:    ""
    property int length:            0
    property int countdown:         0
    property string module:         ""
    property string path:           ""
    property bool broadcast:        false

    property list<QuMapping> mappings

    property alias dispatched: interaction_dispatched

    signal interactionNotify    ( );
    signal interactionBegin     ( );
    signal interactionEnd       ( );

    function notify()   { interaction_notify.value = 0; }
    function begin()    { interaction_begin.value = 0; }
    function end()      { interaction_end.value = 0; }
    function execute()  { executor.start() }

    WPN114.Node on title        { path: root.path+"/title" }
    WPN114.Node on description  { path: root.path+"/description" }
    WPN114.Node on length       { path: root.path+"/length" }
    WPN114.Node on countdown    { path: root.path+"/countdown" }
    WPN114.Node on module       { path: root.path+"/module" }
    WPN114.Node on broadcast    { path: root.path+"/broadcast" }

    Timer //------------------------------------------------------------ EXECUTOR
    {
        property int count: 0
        id: executor
        repeat: true
        interval: 1000
        triggeredOnStart: true

        onIntervalChanged: console.log("interval changed", interval)

        onTriggered:
        {
            if ( !count ) interaction_notify.value = 0;
            else if ( count === root.countdown ) interaction_begin.value = 0;

            if ( count === root.countdown+root.length )
            {
                interaction_end.value = 0;
                stop();
                count = 0;
            }

            else ++count;
        }
    }

    WPN114.Node //------------------------------------------------------------ INTERACTION_NOTIFY
    {
        id: interaction_notify
        path: root.path+"/notify"
        type: WPN114.Type.Impulse

        critical: true

        onValueReceived:
        {
            client_manager.dispatch(undefined, root)

            owners.forEach(function(owner) {
                for ( var i = 0; i < mappings.length; ++i )
                owner.remote.listen(mappings[i].source);
            });

            root.interactionNotify();
        }
    }

    WPN114.Node //------------------------------------------------------------ INTERACTION_BEGIN
    {
        id: interaction_begin
        path: root.path+"/begin"
        type: WPN114.Type.Impulse

        critical: true

        onValueReceived:
        {
            console.log("Beginning interaction:", root.title);
            owners.forEach(function(owner) {
                for ( var i = 0; i < mappings.length; ++i )
                {
                    var mapping = mappings[i];
                    var node = owner.remote.get(mapping.source);
                    node.valueReceived.connect(mapping.expression);
                }
                owner.beginInteraction(root);
            });

            root.interactionBegin();
        }
    }

    WPN114.Node //------------------------------------------------------------ INTERACTION_END
    {
        id: interaction_end
        path: root.path+"/end"
        type: WPN114.Type.Impulse

        critical: true

        onValueReceived:
        {
            console.log("Ending interaction:", root.title);
            owners.forEach(function(owner) {
                for ( var i = 0; i < mappings.length; ++i )
                {
                    var mapping = mappings[i];
                    owner.remote.ignore(mapping.source);
                    var node = owner.remote.get(mapping.source);
                    node.valueReceived.disconnect(mapping.expression);
                }
                owner.endInteraction(root);
            });

            root.interactionEnd();
            interaction_dispatched.value = false;
            executor.running = false;
            executor.count = 0;
            owners = [ ];
        }
    }

    WPN114.Node
    {
        id:     interaction_dispatched
        path:   root.path+"/dispatched"
        type:   WPN114.Type.Bool
        value:  false

        critical: true
    }

    WPN114.Node
    {
        id:     interaction_execute
        path:   root.path+"/execute"
        type:   WPN114.Type.Impulse

        onValueReceived: root.execute();
    }
}
