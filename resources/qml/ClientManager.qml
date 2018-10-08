import QtQuick 2.0
import WPN114 1.0 as WPN114

Item
{
    property int maxClients;

    function dispatch(target, interaction)
    {
        var candidates = [];

        for ( var c = 0; c < maxClients; ++c )
        {
            var candidate;
            var client = clients.itemAt(c);

            candidate["target"]    = client;
            candidate["priority"]  = 0;

            if ( !client.connected ) continue;
            if ( client.status === "incoming" ) continue;
            else if ( client.status === "active_incoming" ) continue;
            else if ( client.status === "active" )
            {
                var acd = client.getActiveCountdown();
                if ( interaction.countdown < acd+5 ) continue;

                candidate["priority"] = 1;
            }
            else if ( client.status === "idle" );
            else continue;

            candidate["priority"] += client.interaction_count;
            candidates.push(candidate);
        }

        var winner;

        for ( var i = 0; i < candidates.length; ++i )
        {
            var select = candidates[i];
            if ( winner === undefined )
            {
                winner = select;
                continue;
            }

            if ( select["priority"] === winner["priority"] )
            {
                var r = Math.random();
                if ( r > 0.5 ) winner = select;
            }
            else if ( select["priority"] < winner["priority"] )
                winner = select;
        }

        winner["target"].notifyInteraction(interaction);
    }

    Repeater
    {
        id: clients
        model: maxClients

        QuarreClient { number: index }
    }
}
