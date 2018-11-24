import QtQuick 2.0
import WPN114 1.0 as WPN114
import "../../engine"
import ".."

Scene
{
    id: root
    endShutdown: false

    property alias wind: wind
    property alias interaction_strings: interaction_string_sweep
    property alias interaction_strings_timbre: interaction_strings_timbre

    scenario: WPN114.TimeNode
    {
        source:      audiostream
        parentNode:  parent.scenario
        duration:    WPN114.TimeNode.Infinite

        onStart:
        {
            wind.play()

            instruments.kaivo_1.active = true;
            instruments.kaivo_2.active = true;
            instruments.rooms.active = true;

            functions.setTimeout(function() {
                instruments.kaivo_2.setPreset( instruments.churchbells );
            }, 1000 )

            // we use a different reverb for this scene
            effects.reverb.active = false;
            effects.lavaur.active = true;

            instruments.k1_fork_921.active      = false
            instruments.k1_fork_lavaur.active   = true
            instruments.k2_fork_921.active      = false
            instruments.k2_fork_lavaur.active   = true

            instruments.kaivo_1.dBlevel = -4;
            instruments.k1_fork_lavaur.dBlevel = -18;

            instruments.kaivo_2.dBlevel = -20;
            instruments.k2_fork_lavaur.dBlevel  = -18
        }

        onEnd:
        {

        }

        WPN114.TimeNode { date: sec(6); onStart: footsteps.play() }
        WPN114.TimeNode { startExpression: ammon_score.index === 1; onStart: footsteps.stop(); }

        InteractionExecutor
        {
            target:         interaction_string_sweep
            endExpression:  ammon_score.index === 100
            onStart:        instruments.kaivo_1.setPreset( instruments.tguitar );

            date:       sec( 10 )
            countdown:  sec( 10 )
            length:     WPN114.TimeNode.Infinite
        }

        InteractionExecutor
        {
            target:         interaction_bells
            endExpression:  ammon_score.index === 100
            onStart:        ;

            date:       sec( 15 )
            countdown:  sec( 10 )
            length:     WPN114.TimeNode.Infinite
        }

        InteractionExecutor
        {
            target:             interaction_strings_timbre
            startExpression:    ammon_score.index === 7
            endExpression:      ammon_score.index === 100
            countdown:          sec( 10 )
            length:             WPN114.TimeNode.Infinite
        }

        WPN114.Automation //--------------------------------------------- HARMONICS_SAMPLE
        {
            startExpression:  ammon_score.index === 38;

            target: harmonics
            property: "level"
            duration: min( 1.30 )
            from: 0; to: 1;

            onStart: harmonics.play();
        }

        WPN114.Automation
        {
            startExpression: ammon_score.index === 84

            target: harmonics
            property: "level"
            duration: min( 1 )
            from: 1; to: 0;

            onEnd: harmonics.stop();
        }

        WPN114.Automation //--------------------------------------------- BROKEN_RADIO
        {
            startExpression: ammon_score.index === 84

            target: broken_radio
            property: "level"
            duration: sec( 30 )
            from: 0; to: 1;

            onStart: broken_radio.play();
        }

        WPN114.Automation
        {
            startExpression: ammon_score.index === 100

            id: broken_radio_fade_out
            target: broken_radio
            property: "level"
            duration: sec( 50 )
            from: 1; to: 0;

            onEnd: broken_radio.stop();
        }

        WPN114.Automation
        {
            after: broken_radio_fade_out
            target: rooms
            property: "dBlevel"
            from: rooms.dBlevel
            to: -6;

            duration: sec( 10 )
            onEnd:
            {
                // do not deactivate rooms, wind has to keep playing during wpn214
                instruments.kaivo_1.active = false;
                instruments.kaivo_2.active = false;
                instruments.rooms.active = false;

                instruments.k1_fork_921.active      = true
                instruments.k1_fork_lavaur.active   = false
                instruments.k2_fork_921.active      = true
                instruments.k2_fork_lavaur.active   = false

                ammon_score.index = 0;
                scenario.end();
            }
        }
    }

    Item
    {
        id: interactions

        AmmonScore { id: ammon_score }

        Interaction //--------------------------------------------- STRING_SWEEP
        {
            id:     interaction_string_sweep
            title:  "Cordes, déclenchement"
            module: "quarre/Strings.qml"
            description: "Frottez les cordes avec votre doigt au fur et à mesure de leur apparition"

            onInteractionBegin:
            {
                interaction_string_sweep.owners.forEach(function(owner) {
                    var value = ammon_score.score[0]["notes"].length;
                    owner.remote.sendMessage("/modules/strings/display", value, true)})
            }

            mappings: QuMapping
            {
                source: "/modules/strings/trigger"
                expression: function(v) {
                    functions.processScoreIncrement( ammon_score,
                                                    interaction_string_sweep,
                                                    interaction_string_sweep,
                                                    instruments.kaivo_1 );
                }
            }
        }

        Interaction //--------------------------------------------- STRINGS_TIMBRE
        {
            id:     interaction_strings_timbre
            title:  "Guitare primitive, timbre"
            module: "basics/XYZRotation.qml"
            description: "Faites pivoter l'appareil dans ses axes de rotation pour manipuler la brillance (axe Y) et la hauteur (axe X) de l'instrument"

            mappings: QuMapping
            {
                source: "/modules/xyzrotation/data"
                expression: function(v) {
                    instruments.kaivo_1.set("res_pitch", v[0]/90*0.00625 + 0.5);
                    instruments.kaivo_1.set("res_brightness", (v[1]+180)/360);
                    instruments.kaivo_1.set("res_position", (v[2]+180)/360);
                }
            }
        }

        Interaction //--------------------------------------------- BELLS
        {
            id:     interaction_bells
            title:  "Cloches, pré-rythmiques"
            module: "quarre/AmmonBells.qml"
            description: "Exécutez un geste de frappe verticale pour déclencher des sons de cloches"

            mappings:
                [
                QuMapping {
                    source: "/gestures/whip/trigger"
                    expression: function(v) {
                        var index       = Math.floor(Math.random()*40)+30;
                        var velocity    = Math.floor(Math.random()*40)+60;

                        instruments.kaivo_2.noteOn(0, index, velocity);
                        functions.setTimeout(function(v){
                            instruments.kaivo_2.noteOff(0, index, velocity);
                        }, 5000)}},

                QuMapping {
                    source: "/modules/xyzrotation/data"
                    expression: function(v) {
                        instruments.kaivo_2.set( "body_position_x", (v[0]+90)/180 );
                        instruments.kaivo_2.set( "res_brightness", (v[1]+180)/360 );
                        instruments.kaivo_2.set( "res_position", (v[2]+180)/360 );
                    }
                }
            ]
        }
    }

    WPN114.StereoSource //----------------------------------------- 1.FOOTSTEPS (1-2)
    {
        parentStream: rooms
        fixed: true
        xspread: 0.3
        diffuse: 0.1
        y: 0.1

        exposePath: fmt("audio/footsteps/source")

        WPN114.Sampler { id: footsteps; loop: true; xfade: 2000
            exposePath: fmt("audio/footsteps")
            path: "audio/stonepath/ammon/footsteps.wav" }
    }

    WPN114.StereoSource //----------------------------------------- 2.BROKEN-RADIO (3-4)
    {
        parentStream: rooms
        fixed: true
        xspread: 0.05
        y: 0.8

        exposePath: fmt("audio/broken-radio/source")

        WPN114.Sampler { id: broken_radio;
            exposePath: fmt("audio/broken-radio")
            path: "audio/stonepath/ammon/broken-radio.wav"

            WPN114.Fork { target: effects.lavaur; dBlevel: -6; prefader: false
                exposePath: fmt("audio/broken-radio/forks/lavaur") }
        }
    }

    WPN114.StereoSource //----------------------------------------- 3.HARMONICS (5-6)
    {
        parentStream: rooms
        fixed: true
        xspread: 0.3
        diffuse: 0.3
        y: 0.75
        z: 0.25

        exposePath: fmt("audio/harmonics/source")

        WPN114.StreamSampler { id: harmonics;
            exposePath: fmt("audio/harmonics")
            path: "audio/stonepath/ammon/harmonics.wav" }
    }

    WPN114.StereoSource //----------------------------------------- 4.WIND (7-8)
    {
        parentStream: rooms
        fixed: true
        xspread: 0.4
        diffuse: 0.3
        z: 0.35

        exposePath: fmt("audio/wind/source")

        WPN114.Sampler { id: wind; loop: true; dBlevel: -12; xfade: 2000
            exposePath: fmt("audio/wind")
            path: "audio/stonepath/ammon/wind.wav" }
    }
}

