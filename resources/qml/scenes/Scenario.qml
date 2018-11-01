import QtQuick 2.0
import WPN114 1.0 as WPN114

import "stonepath"
import "woodpath"

Item
{
    Introduction    { id: introduction }
    WoodPath        { id: woodpath }
//    StonePath       { id: stonepath }
    WPN214          { id: wpn214 }

    Instruments     { id: instruments }
    Effects         { id: effects }

    function initialize()
    {
        introduction.rooms.setup  = rooms_setup
        instruments.rooms.setup   = rooms_setup
        effects.rooms.setup       = rooms_setup

//        stonepath.initialize    ( rooms_setup );
        woodpath.initialize     ( rooms_setup );
    }

    WPN114.Node //----------------------------------------------------------- AUDIO_RESET
    {
        id:     audio_reset
        path:   "/scenario/reset"
        type:   WPN114.Type.Impulse

        critical: true

        onValueReceived:
        {
            console.log("AUDIO reset");

            introduction.rooms.active = false
//            stonepath.reset ( );
            woodpath.reset  ( );

            instruments.rooms.active     = false
            instruments.kaivo_1.active   = false
            instruments.kaivo_2.active   = false
        }
    }

    WPN114.Node //----------------------------------------------------------- MAIN_START
    {
        id: scenario_start
        path: "/scenario/start"
        type: WPN114.Type.Impulse

        onValueReceived:
        {
            if ( !audio_stream.active ) audio_stream.active = true;

            introduction.scenario.start();
            timer.start();
        }
    }

    Item //----------------------------------------------------------------- TIMER
    {
        id: timer
        property int count;
        property string countstr;

        onCountstrChanged: console.log(countstr);

        function start()
        {
            audio_stream.tick.connect(timer.update)
        }

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
            if ( introduction.xroads_result === 0 )
                 woodpath.scenario.start();
//            else stonepath.scenario.start();
        }
    }

//    Connections //--------------------------------------------------------- ENDING_CONNECTIONS
//    {
//        target: stonepath
//        onEnd: wpn214.scenario.start();
//    }

    Connections
    {
        target: woodpath
        onEnd: wpn214.scenario.start();
    }

    Connections
    {
        target: wpn214
        onEnd: scenario_start.value = 1;
    }
}
