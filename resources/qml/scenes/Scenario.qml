import QtQuick 2.0
import WPN114 1.0 as WPN114

import "stonepath"
import "woodpath"

Item
{
    function initialize()
    {
        introduction.rooms.setup         = rooms_setup
        stonepath.cendres.rooms.setup    = rooms_setup
        stonepath.diaclases.rooms.setup  = rooms_setup
        stonepath.deidarabotchi.rooms.setup  = rooms_setup
        stonepath.markhor.rooms.setup    = rooms_setup
        stonepath.ammon.rooms.setup      = rooms_setup
        instruments.rooms.setup          = rooms_setup
        effects.rooms.setup              = rooms_setup
    }

    WPN114.Node
    {
        id:     audio_reset
        path:   "/scenario/reset"
        type:   WPN114.Type.Impulse

        critical: true

        onValueReceived:
        {
            console.log("AUDIO reset");
            introduction.rooms.active = false
            stonepath.cendres.rooms.active = false
            stonepath.diaclases.rooms.active = false
            stonepath.deidarabotchi.rooms.active = false
            stonepath.markhor.rooms.active = false
            stonepath.ammon.rooms.active = false
        }
    }

    WPN114.Node
    {
        id: scenario_start
        path: "/scenario/start"
        type: WPN114.Type.Impulse

        onValueReceived:
        {
            console.log("[LOGGER] Starting full scenario");
            if ( !audio_stream.active ) audio_stream.active = true;

            introduction.scenario.start();
            audio_stream.tick.connect(timer.update)
        }
    }

    Item //----------------------------------------------------------------- TIMER
    {
        id: timer
        property int count;
        property string countstr;

        onCountstrChanged: console.log(countstr);

        function update(tick)
        {
            count += tick;
            countstr = functions.realToTime(count);
        }
    }

    Connections // --------------------------------------------------------- CROSSROADS_CONNECTIONS
    {
        target: introduction
        onEnd:
        {
            if ( introduction.xroads_result === 0 );
            else stonepath.scenario.start();
        }
    }

//    Connections //--------------------------------------------------------- ENDING_CONNECTIONS
//    {
//        target: stonepath
//        onEnd: ; // wpn214 start & then loop
//    }

    Introduction    { id: introduction }
    //WoodPath        { id: woodpath }
    StonePath       { id: stonepath }
    //WPN214          { id: wpn214 }

    Instruments     { id: instruments }
    Effects         { id: effects }

}
