import QtQuick 2.0
import WPN114 1.0 as WPN114

Item
{
    id: root

    property int idkey:             0
    property var owners:            [ ];
    property string title:          ""
    property string description:    ""
    property string module:         ""
    property string path:           ""
    property bool broadcast:        false

    property int countdown: 0
    property int length: 0

    property list<QuMapping> mappings

    property bool dispatched: false

    signal interactionNotify    ( );
    signal interactionBegin     ( );
    signal interactionEnd       ( );

    function notify(cd, le) //==================================================== INTERACTION_NOTIFY
    {
        root.countdown   = cd;
        root.length      = le;

        net.clients.dispatch(undefined, root)
        root.interactionNotify();
    }

    function begin() // ========================================================= INTERACTION_BEGIN
    {
        console.log("Beginning interaction:", root.title);
        owners.forEach(function(owner) {
            for ( var i = 0; i < mappings.length; ++i )
            {
                var mapping = mappings[i];
                owner.remote.listen(mapping.source);
                var node = owner.remote.get(mapping.source);
                node.valueReceived.connect(mapping.expression);
            }
            owner.beginInteraction(root);
        });

        root.interactionBegin();
    }

    function end() // ========================================================= INTERACTION_END
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
        root.dispatched.value = false;
        owners = [ ];
    }
}
