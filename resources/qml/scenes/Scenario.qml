import QtQuick 2.0
import WPN114 1.0 as WPN114

import "stonepath"
import "woodpath"
import "mix"

Item
{
    id: root
    property alias introduction: introduction;
    property alias woodpath: woodpath;
    property alias stonepath: stonepath;
    property alias wpn214: wpn214;

    Introduction     { id: introduction }
    WoodPath         { id: woodpath  }
    StonePath        { id: stonepath }
    WPN214           { id: wpn214  }

    Instruments      { id: instruments }
    Effects          { id: effects }

    WPN114.Node //----------------------------------------------------------- AUDIO_RESET
    {
        id:     audio_reset
        path:   "/scenario/reset"
        type:   WPN114.Type.Impulse

        critical: true

        onValueReceived:
        {
            introduction.rooms.active    = false
            instruments.rooms.active     = false
            instruments.kaivo_1.active   = false
            instruments.kaivo_2.active   = false

            stonepath.reset ( );
            woodpath.reset  ( );
        }
    }

    function start() //----------------------------------------------------------- MAIN_START
    {
        if ( !audio_stream.active )
              audio_stream.active = true;

        introduction.scenario.start();
        timer.count = 0;

        if ( !timer.running ) timer.start();
    }

    WPN114.Node
    {
        id: scenario_start
        path: "/scenario/start"
        type: WPN114.Type.Impulse

        onValueReceived: root.start();
    }

    Item //----------------------------------------------------------------- TIMER
    {
        id: timer

        property bool running: false
        property int count;
        property string countstr;

        onCountstrChanged: console.log(countstr);

        function start()
        {
            audio_stream.tick.connect(timer.update)
            running = true;
        }

        function update( tick )
        {
            count += tick;
            countstr = functions.realToTime(count);
            mainview.timer.text = countstr;
        }
    }

    Connections // --------------------------------------------------------- CROSSROADS_CONNECTIONS
    {
        target: introduction
        onEnd:
        {
            if ( introduction.xroads_result === 0 )
            {
                woodpath.scenario.start();
                wpn214.fade_target = woodpath.jomon
            }
            else
            {
                stonepath.scenario.start();
                wpn214.fade_target = stonepath.ammon
            }
        }
    }

    Connections //--------------------------------------------------------- ENDING_CONNECTIONS
    {
        target: stonepath
        onEnd: wpn214.scenario.start();
    }

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
