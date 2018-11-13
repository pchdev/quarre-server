import QtQuick 2.0
import WPN114 1.0 as WPN114
import ".."
import "../engine"

Scene
{
    id: root

    scenario: WPN114.TimeNode
    {
        source:     audiostream
        duration:   min( 4.42 )

        onStart:
        {
            digibirds.play      ( );
            swarms.play         ( );
            dragon_hi.play      ( );
            dragon_lo.play      ( );
            walking_1.play      ( );
            walking_2.play      ( );
            synth.play          ( );
            spring.play         ( );
            river.play          ( );
            verb.play           ( );

            rooms.dBlevel = -3
            net.clients.notifyStart( );
        }

        // Starting next scene at 3:00 (after the xroads interaction)
        WPN114.TimeNode { date: min( 3 ); onStart: root.next() }

        InteractionExecutor //======================================= TUTORIAL
        {
            id:         tutorial_event
            target:     interactions.tutorial

            date:       sec( 1 )
            countdown:  sec( 48 )
            length:     sec( 50 )
        }

        InteractionExecutor //======================================= XROADS
        {
            id:         crossroads_event
            target:     interactions.xroads

            date:       min( 1.45 )
            length:     sec( 30 )
            countdown:  sec( 30 )
        }
    }

    WPN114.StereoSource //=========================================== DIGIBIRDS
    {
        parentStream: rooms
        xspread: 0.35
        diffuse: 0.49
        fixed: true

        exposePath: fmt( "audio/digibirds/source" )

        WPN114.StreamSampler { id: digibirds;
            exposePath: fmt("audio/digibirds");
            path: "audio/introduction/digibirds.wav" }
    }

    WPN114.StereoSource //=========================================== SWARMS
    {
        parentStream: rooms
        xspread: 0.27
        diffuse: 0.17
        fixed: true
        y: 0.9

        exposePath: fmt("audio/swarms/source")

        WPN114.StreamSampler { id: swarms;
            exposePath: fmt("audio/swarms");
            path: "audio/introduction/swarms.wav" }
    }

    WPN114.StereoSource //=========================================== DRAGON_HI
    {
        parentStream: rooms
        xspread: 0.28
        fixed: true
        y: 0.65

        exposePath: fmt("audio/dragon-hi/source")

        WPN114.StreamSampler { id: dragon_hi; dBlevel: 3.00
            exposePath: fmt("audio/dragon-hi");
            path: "audio/introduction/dragon-hi.wav" }
    }

    WPN114.StereoSource //=========================================== DRAGON_LO
    {
        parentStream: rooms
        xspread: 0.28
        fixed: true
        y: 0.25

        exposePath: fmt("audio/dragon-lo/source")

        WPN114.StreamSampler { id: dragon_lo; dBlevel: 6.00
            exposePath: fmt("audio/dragon-lo")
            path: "audio/introduction/dragon-lo.wav" }
    }

    WPN114.StereoSource //=========================================== WALKING_1
    {
        parentStream: rooms
        xspread: 0.2
        fixed: true

        exposePath: fmt("audio/walking-1/source")

        WPN114.StreamSampler { id: walking_1;
            exposePath: fmt("audio/walking-1");
            path: "audio/introduction/walking-1.wav" }
    }

    WPN114.StereoSource //=========================================== WALKING_2
    {
        parentStream: rooms
        xspread: 0.15
        fixed: true
        y: 0.43

        exposePath: fmt("audio/walking-2/source")

        WPN114.StreamSampler { id: walking_2;
            exposePath: fmt( "audio/walking-2")
            path: "audio/introduction/walking-2.wav" }
    }

    WPN114.StereoSource //=========================================== SYNTH
    {
        parentStream: rooms
        xspread: 0.25
        fixed: true
        y: 0.85

        exposePath: fmt("audio/synth/source")

        WPN114.StreamSampler { id: synth; dBlevel: 6.00
            exposePath: fmt("audio/synth");
            path: "audio/introduction/synth.wav" }
    }

    WPN114.StereoSource //=========================================== SPRING
    {
        parentStream: rooms
        yspread: 0.25
        diffuse: 0.7
        bias: 0.85
        fixed: true

        exposePath: fmt("audio/spring/source")

        WPN114.StreamSampler { id: spring;
            exposePath: fmt("audio/spring");
            path: "audio/introduction/spring.wav" }
    }

    WPN114.StereoSource //=========================================== RIVER
    {
        parentStream: rooms
        yspread: 0.25
        diffuse: 0.55
        fixed: true

        exposePath: fmt("audio/river/source")

        WPN114.StreamSampler { id: river;
            exposePath: fmt("audio/river");
            path: "audio/introduction/river.wav" }
    }

    WPN114.StereoSource //=========================================== VERB
    {
        parentStream: rooms
        xspread: 0.25
        diffuse: 0.6
        fixed: true

        exposePath: fmt("audio/verb/source")

        WPN114.StreamSampler { id: verb;
            exposePath: fmt("audio/verb");
            path: "audio/introduction/verb.wav" }
    }
}
