import QtQuick 2.0
import WPN114 1.0 as WPN114

import "stonepath"
import "woodpath"
import ".."

Scene
{
    id: root
    path: "/scenario"

    property Scene runningScene

    scenario: WPN114.TimeNode
    {
        source: audiostream
        duration: WPN114.TimeNode.Infinite

        onStart:
        {
            introduction.start();
            timer.count = 0;
            runningScene = introduction;
        }
    }

    Interactions     { id: interactions }
    Instruments      { id: instruments }
    Effects          { id: effects }

    Introduction     { id: introduction; path: root.fmt( "introduction" ) }

//    Woodpath         { id: woodpath  }
//    Stonepath        { id: stonepath }
//    WPN214           { id: wpn214  }

    Item //====================================================================== TIMER
    {
        id: timer

        property bool running: false
        property int count;
        property string countstr;

        onCountstrChanged: console.log(countstr);

        function start()
        {
            audiostream.tick.connect(timer.update)
            running = true;
        }

        function update( tick )
        {
            count += tick;
            countstr = functions.realToTime(count);
            mainview.timer.text = countstr;
        }
    }

   /* Connections // --------------------------------------------------------- CROSSROADS_CONNECTIONS
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

    */
}
