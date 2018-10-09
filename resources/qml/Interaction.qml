import QtQuick 2.0
import WPN114 1.0 as WPN114

Item
{
    id: root
    property int idkey: 0

    property var owners: [];

    property string title: ""
    property string description: ""
    property int length: 0
    property int countdown: 0
    property string module: ""
    property string path: ""
    property bool broadcast: false
    property var mappings

    function notify()   { interaction_notify.value = 0; }
    function begin()    { interaction_begin.value = 0; }
    function end()      { interaction_end.value = 0; }

    WPN114.Node on title        { path: "/interactions/"+root.path+"/title" }
    WPN114.Node on description  { path: "/interactions/"+root.path+"/description" }
    WPN114.Node on length       { path: "/interactions/"+root.path+"/length" }
    WPN114.Node on countdown    { path: "/interactions/"+root.path+"/countdown" }
    WPN114.Node on module       { path: "/interactions/"+root.path+"/module" }
    WPN114.Node on broadcast    { path: "/interactions/"+root.path+"/broadcast" }

    WPN114.Node //------------------------------------------------------------ INTERACTION_NOTIFY
    {
        id: interaction_notify
        path: "/interactions/"+root.path+"/notify"
        type: WPN114.Type.Impulse

        onValueReceived:
            client_manager.dispatch(undefined, root)
    }

    WPN114.Node //------------------------------------------------------------ INTERACTION_BEGIN
    {
        id: interaction_begin
        path: "/interactions/"+root.path+"/begin"
        type: WPN114.Type.Impulse

        onValueReceived:
        {
            owners.forEach(function(owner) {
                owner.beginInteraction(root);
            })
        }
    }

    WPN114.Node //------------------------------------------------------------ INTERACTION_END
    {
        id: interaction_end
        path: "/interactions/"+root.path+"/end"
        type: WPN114.Type.Impulse

        onValueReceived:
        {
            owners.forEach(function(owner) {
                owner.endInteraction(root);
            })
        }
    }
}
