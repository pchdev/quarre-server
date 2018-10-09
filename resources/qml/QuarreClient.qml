import QtQuick 2.0
import WPN114 1.0 as WPN114

Item
{
    id: root
    property int number: 0
    property int interaction_count: 0
    property bool connected: false
    property string status: "disconnected"

    function getInteractionMessage(interaction)
    {
        var interaction_arr = [];

        // arg0: title
        // arg1: description
        // arg2: module
        // arg3: length
        // arg4: countdown
        interaction_arr.push(interaction.title);
        interaction_arr.push(interaction.description);
        interaction_arr.push(interaction.module);
        interaction_arr.push(interaction.length);
        interaction_arr.push(interaction.countdown);

    return interaction_arr;
    }

    function notifyInteraction(interaction)
    {
        var interaction_arr = getInteractionMessage(interaction);
        remote.sendMessage("/interactions/next/incoming", interaction_arr, true);

        interaction.owners.push(root);
        root.interaction_count++;
        if ( status === "active") root.status = "active_incoming";
        else root.status = "incoming";
    }

    function beginInteraction(interaction)
    {
        var interaction_arr = getInteractionMessage(interaction);
        remote.sendMessage("/interactions/next/begin", interaction_arr, true);
        root.status = "active";
    }

    function endInteraction(interaction)
    {
        remote.sendMessage("/interactions/current/end", 0, true);
    }

    function getActiveCountdown()
    {
        return remote.value("/interactions/current/countdown");
    }

    WPN114.OSCQueryClient
    {
        // when connected, remote will download the different module files
        // then go into idle state
        id: remote
        zeroConfHost: number ? "quarre-remote"+"("+number+")" : "quarre-remote"

        onConnected:
        {
            console.log("client connected");
            root.status = "idle"
            root.connected = true
        }

        onDisconnected:
        {
            console.log("client disconnected");
            root.status = "disconnected"
            root.connected = false;
        }
    }

}
