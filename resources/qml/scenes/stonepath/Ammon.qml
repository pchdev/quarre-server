import QtQuick 2.0
import WPN114 1.0 as WPN114
import "../.."
import ".."

Item
{
    id: root
    property alias rooms: ammon_rooms
    property alias scenario: scenario
    signal end()

    WPN114.TimeNode
    {
        id: scenario
        source: audio_stream
        exposePath: "/stonepath/ammon/scenario"

        duration: -1

        onStart:
        {
            console.log("ammon start");
            ammon_rooms.active = true
            wind.play()       

            instruments.kaivo_1.active = true;
            instruments.kaivo_2.active = true;
//            instruments.absynth.active = true;
            instruments.rooms.active = true;

            // we use a different reverb for this scene
            effects.reverb.active = false;
            effects.lavaur.active = true;

            instruments.k1_fork_921.active      = false
            instruments.k1_fork_lavaur.active   = true
            instruments.k2_fork_921.active      = false
            instruments.k2_fork_lavaur.active   = true

            instruments.kaivo_1.dBlevel = -4;
            instruments.k1_fork_lavaur.dBlevel = -10;

            instruments.kaivo_2.dBlevel = -4;
            instruments.k2_fork_lavaur.dBlevel  = -9

            // the markhor intro bells should still be here
//            instruments.kaivo_1.allNotesOff();

            client_manager.notifyScene("ammon");
        }

        onEnd:
        {
            // do not deactivate rooms, wind has to keep playing during wpn214
            instruments.kaivo_1.active = false;
            instruments.kaivo_2.active = false;
            instruments.absynth.active = false;

            instruments.rooms.active = false;
        }

        WPN114.TimeNode { date: sec(6); onStart: footsteps.play() }

        InteractionExecutor
        {
            target:         interaction_string_sweep
            endExpression:  interaction_string_sweep.index === 100
            onStart:        instruments.kaivo_1.setPreset("temples");

            date:       sec( 10 )
            countdown:  sec( 10 )
            length:     sec( 360 )
        }

        InteractionExecutor
        {            
            target:         interaction_bells
            endExpression:  interaction_string_sweep.index === 100
            onStart:        instruments.kaivo_2.setPreset("church");

            date:       sec( 15 )
            countdown:  sec( 10 )
            length:     sec( 360 )
        }

//        InteractionExecutor
//        {
//            target: interaction_inharm_synth

//            startExpression: ( interaction_string_sweep.index === 38 );
//            endExpression: ( interaction_string_sweep.index === 100 );
//        }

        InteractionExecutor
        {
            target:             interaction_strings_timbre
            startExpression:    interaction_string_sweep.index === 7
            endExpression:      interaction_string_sweep.index === 100
            countdown:          sec( 10 )
            length:             sec( 360 )
        }

        WPN114.Automation //--------------------------------------------- HARMONICS_SAMPLE
        {
            startExpression: ( interaction_string_sweep.index === 38 );

            target: harmonics
            property: "level"
            duration: min(1.30)
            from: 0; to: 1;

            onStart: harmonics.play();
        }

        WPN114.Automation
        {
            startExpression: ( interaction_string_sweep.index === 84 )

            target: harmonics
            property: "level"
            duration: min(1)
            from: 1; to: 0;

            onEnd: harmonics.stop();
        }

        WPN114.Automation //--------------------------------------------- BROKEN_RADIO
        {
            startExpression: ( interaction_string_sweep.index === 88 )

            target: broken_radio
            property: "level"
            duration: sec(30)
            from: 0; to: 1;

            onStart: broken_radio.play();
        }

        WPN114.Automation
        {
            startExpression: ( interaction_string_sweep.index === 100 )

            target: broken_radio
            property: "level"
            duration: sec(50)
            from: 1; to: 0;

            onEnd: broken_radio.stop();
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
            path:   "/stonepath/ammon/interactions/strings"
            module: "quarre/Strings.qml"

            description: "Frottez les cordes avec votre doigt au fur
 et à mesure de leur apparition"

            property int index: 0

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

                    var idx = interaction_string_sweep.index
                    var chord = ammon_score.score[idx];
                    var next_chord = ammon_score.score[idx+1];

                    interaction_string_sweep.owners.forEach(function(owner) {
                        owner.remote.sendMessage("/modules/strings/display", 0, true)
                    });

                    for ( var i = 0; i < chord['notes'].length; ++i )
                    {
                        ( function(i) {

                            console.log(chord['notes'][i], chord['velocity'][i], chord['times'][i]);

                            functions.setTimeout( function() {
                                instruments.kaivo_1.noteOn(0, chord['notes'][i], chord['velocity'][i]); }, chord['times'][i]);

                            functions.setTimeout( function() {
                                instruments.kaivo_1.noteOff(0, chord['notes'][i], chord['velocity'][i]);
                            }, chord['duration']); })(i);
                    }

                    // display next chord
                    functions.setTimeout( function() {
                        interaction_string_sweep.owners.forEach(function(owner) {
                            var value = next_chord["notes"].length;
                            owner.remote.sendMessage("/modules/strings/display", value, true)})
                    }, chord["duration"])


                    interaction_string_sweep.index++;
                }
            }
        }

        Interaction //--------------------------------------------- INHARM_SYNTH
        {
            id:     interaction_inharm_synth

            title:  "Inharmonie"
            path:   "/stonepath/ammon/interactions/inharmonic"
            module: "quarre/JomonPalmZ.qml"

            description: "Approchez et maintenez la paume de votre main
 à quelques centimètres de l'écran pour produire une nappe inharmonique,
 retirez-la pour la faire disparaître. Préférez les notes longues."

            length: 300
            countdown: 10

            property int current_note: 0

            mappings: QuMapping
            {
                source: "/modules/jomon-palmz/cover"
                expression: function(v) {
                    if ( v )
                    {
                        var index       = Math.random()*40+40;
                        current_note    = index;

                        instruments.absynth.noteOn(0, index, 100);
                        instruments.absynth.noteOn(0, index+5, 100);
                    }
                    else
                    {
                        instruments.absynth.noteOff(0, current_note, 100);
                        instruments.absynth.noteOff(0, current_note+5, 100);
                    }
                }
            }
        }

        Interaction //--------------------------------------------- STRINGS_TIMBRE
        {
            id:     interaction_strings_timbre

            title:  "Guitare primitive, timbre"
            path:   "/stonepath/ammon/interactions/strings-timbre"
            module: "basics/XYZRotation.qml"

            description: "Faites pivoter l'appareil dans ses axes de rotation pour manipuler
 la brillance (axe Y) et la hauteur (axe X) de l'instrument déclenché par votre partenaire."

            mappings: QuMapping
            {
                source: "/modules/xyzrotation/data"
                expression: function(v) {
                    instruments.kaivo_1.set("res_pitch", 440+v[0]/90*10);
                    instruments.kaivo_1.set("res_brightness", (v[1]+180)/360);
                    instruments.kaivo_1.set("res_position", (v[2]+180)/360);
                }
            }
        }

        Interaction //--------------------------------------------- BELLS
        {
            id:     interaction_bells

            title:  "Cloches, pré-rythmiques"
            path:   "/stonepath/ammon/interactions/bells"
            module: "quarre/AmmonBells.qml"

            description: "Exécutez un geste de frappe verticale pour
 déclencher des sons de cloches"

            mappings:
            [
                QuMapping {
                    source: "/gestures/whip/trigger"
                    expression: function(v) {
                        var index       = Math.floor(Math.random()*40)+40;
                        var velocity    = Math.floor(Math.random()*40)+20;

                        instruments.kaivo_2.noteOn(0, index, velocity);
                        functions.setTimeout(function(v){
                            instruments.kaivo_2.noteOff(0, index, velocity);
                        }, 5000)}},

                QuMapping {
                    source: "/modules/xyzrotation/data"
                    expression: function(v) {
                        instruments.kaivo_2.set("res_brightness", (v[0]+90)/180);
                        instruments.kaivo_2.set("res_position", (v[2]+180)/360);
                        instruments.kaivo_2.set("res_sustain", (v[1]+180)/360*0.1);
                        instruments.kaivo_2.set("env1_attack", (v[1]+180)/360*0.5)}}
            ]
        }
    }

    WPN114.Rooms
    {
        id: ammon_rooms
        active: false
        parentStream: audio_stream
        setup: rooms_setup

        exposePath: "/stonepath/ammon/audio/rooms"

        WPN114.StereoSource //----------------------------------------- 1.FOOTSTEPS (1-2)
        {            
            fixed: true
            xspread: 0.3
            diffuse: 0.1
            y: 0.1

            exposePath: "/stonepath/ammon/audio/footsteps/source"

            WPN114.Sampler { id: footsteps;
                exposePath: "/stonepath/ammon/audio/footsteps"
                path: "audio/stonepath/ammon/footsteps.wav" }
        }

        WPN114.StereoSource //----------------------------------------- 2.BROKEN-RADIO (3-4)
        {
            fixed: true
            xspread: 0.05
            y: 0.8

            exposePath: "/stonepath/ammon/audio/broken-radio/source"

            WPN114.Sampler { id: broken_radio;
                exposePath: "/stonepath/ammon/audio/broken-radio"
                path: "audio/stonepath/ammon/broken-radio.wav"

                WPN114.Fork { target: effects.lavaur; dBlevel: -6
                    prefader: false
                    exposePath: "/instruments/kaivo-1/forks/lavaur" }
            }
        }

        WPN114.StereoSource //----------------------------------------- 3.HARMONICS (5-6)
        {
            fixed: true
            xspread: 0.3
            diffuse: 0.3
            y: 0.75

            exposePath: "/stonepath/ammon/audio/harmonics/source"

            WPN114.StreamSampler { id: harmonics;
                exposePath: "/stonepath/ammon/audio/harmonics"
                path: "audio/stonepath/ammon/harmonics.wav" }
        }

        WPN114.StereoSource //----------------------------------------- 4.WIND (7-8)
        {
            fixed: true
            xspread: 0.4
            diffuse: 0.3

            exposePath: "/stonepath/ammon/audio/wind/source"

            WPN114.Sampler { id: wind; loop: true; dBlevel: -12; xfade: 2000
                exposePath: "/stonepath/ammon/audio/wind"
                path: "audio/stonepath/ammon/wind.wav" }
        }
    }
}
