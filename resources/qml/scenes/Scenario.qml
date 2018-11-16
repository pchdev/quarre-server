import QtQuick 2.0
import WPN114 1.0 as WPN114

import "stonepath"
import "woodpath"
import "demos"
import ".."

Scene
{
    id: root
    path: "/scenario"

    property Scene runningScene
    notify: false
    audio: false

    scenario: WPN114.TimeNode
    {
        source: audiostream
        duration: WPN114.TimeNode.Infinite

        onStart:
        {
            introduction.start()
            timer.count = 0;
        }
    }

    //================================================================================ SCENES

    Interactions     { id: interactions }
    Instruments      { id: instruments }
    Effects          { id: effects }

    Introduction     { id: introduction; path: root.fmt( "scenes/introduction" ) }
    Woodpath         { id: woodpath; path: root.fmt("scenes/woodpath") }
    Stonepath        { id: stonepath; path: root.fmt("scenes/stonepath") }
    WPN214           { id: wpn214; path: root.fmt("scenes/wpn214") }

    Demos            { id: demos; path: root.fmt("demos");

    Item //=========================================================================== TIMER
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

    Connections // --------------------------------------------------------- CROSSROADS_CONNECTIONS
    {
        target: introduction
        onNext:
        {
            if ( interactions.xroads_result === 0 )
                 woodpath.start();
            else stonepath.start();
        }
    }

    Connections //--------------------------------------------------------- ENDING_CONNECTIONS
    {
        target: stonepath
        onEnd:
        {
            wpn214.fade_target = stonepath.ammon
            wpn214.start();
        }
    }

    Connections
    {
        target: woodpath
        onEnd:
        {
            wpn214.fade_target = woodpath.jomon
            wpn214.start();
        }
    }

    Connections
    {
        target: wpn214
        onEnd:
        {
            reset();
            scenario.start();
        }
    }
}
