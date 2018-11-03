import QtQuick 2.0
import WPN114 1.0 as WPN114
import "../.."
import ".."

Item
{    
    id: root

    property alias rooms: markhor_rooms
    property alias scenario: scenario
    signal end()

    WPN114.TimeNode
    {
        id: scenario
        source: audio_stream
        exposePath: "/stonepath/markhor/scenario"

        duration: -1

        onStart:
        {
            instruments.kaivo_1.active  = true;
            instruments.kaivo_2.active  = true;
            instruments.rooms.active    = true;
            instruments.absynth.active  = false;
            effects.amplitube.active    = false;

            soundscape.play();
            markhor_rooms.active = true;

            client_manager.notifyScene("markhor");
            if ( !timer.running ) timer.start();
        }

        InteractionExecutor //----------------------------------------------------- BELLS
        {
            id:         bells_executor
            target:     interaction_clock_bells
            date:       sec( 5 )
            length:     sec( 45 )
            countdown:  sec( 15 )

            onStart:
            {
                instruments.kaivo_1.setPreset(instruments.autochurch);
                instruments.kaivo_2.setPreset(instruments.markhor);
            }

            onEnd: instruments.kaivo_1.active = false;

            WPN114.TimeNode
            {
                date: sec( 8 )
                onStart: bell_hit.play();
            }

            WPN114.Automation
            {
                date: sec( 15 )
                target: instruments.kaivo_1
                property: "dBlevel"
                duration: sec(45)
                from: -96; to: -4;
            }
        }

        InteractionExecutor //---------------------------------------------------- MARKHOR_DANCE
        {
            after:      bells_executor
            target:     interaction_granular_models
            countdown:  sec( 15 )
            length:     sec( 60 )

            onStart:
            {
                ambient_light.play();

                instruments.kaivo_2.noteOn(0, 70, 127);
                instruments.kaivo_2.noteOn(0, 75, 127);
                instruments.kaivo_2.noteOn(0, 80, 127);
            }

            // DOOMSDAYS
            WPN114.TimeNode { date: sec( 20 ); onStart: doomsday.playRandom();  }
            WPN114.TimeNode { date: min( 1.35 ); onStart: doomsday.playRandom(); }
            WPN114.TimeNode { date: min( 3.05 ); onStart: doomsday.playRandom(); }

            WPN114.Automation
            {
                target: ambient_light
                property: "dBlevel"
                duration: sec(30)
                from: -96; to: 0;
            }

            InteractionExecutor
            {
                target:     interaction_resonators_1
                date:       min( 1.08 )
                countdown:  sec( 15 )
                length:     sec( 60 )

                InteractionExecutor
                {
                    id:         body_executor
                    target:     interaction_body_1
                    date:       min( 1.08 )
                    countdown:  sec( 15 )
                    length:     sec( 60 )
                }
            }

            InteractionExecutor
            {
                target:     interaction_pads_1
                date:       sec( 20 )
                countdown:  sec( 15 )
                length:     sec( 175 )

            }
        }

        InteractionExecutor //--------------------------------------------------------- TUTTI
        {
            after:      body_executor
            target:     interaction_resonators_2
            date:       sec( 10 )
            countdown:  sec( 10 )
            length:     sec( 180 )

            onStart: doomsday.playRandom();

            WPN114.TimeNode { date: sec(40); onStart: doomsday.playRandom();  }
            WPN114.TimeNode { date: min(1.30); onStart: doomsday.playRandom();  }
            WPN114.TimeNode { date: min(2.45); onStart: doomsday.playRandom();  }
        }

        InteractionExecutor //---------------------------- BODY
        {
            after:      body_executor
            target:     interaction_body_2

            date:       sec( 10 )
            countdown:  sec( 10 )
            length:     sec( 180 )

        }

        InteractionExecutor //---------------------------- GRANULAR
        {
            id:         granular_models_2_executor
            after:      body_executor
            target:     interaction_granular_models_2

            date:       sec( 10 )
            countdown:  sec( 10 )
            length:     sec( 180 )
        }

        InteractionExecutor //---------------------------- PADS
        {
            after:      body_executor
            target:     interaction_pads_2

            date:       sec( 10 )
            countdown:  sec( 10 )
            length:     sec( 230 )
        }

        WPN114.Automation //---------------------------- SOUNDSCAPE_FADE_OUT
        {
            after: granular_models_2_executor
            target: soundscape
            property: "level"
            duration: min(1)
            from: 1; to: 0;

            onEnd: scenario.end()
        }

        WPN114.Automation //---------------------------- KAIVO_FADE_OUT
        {
            after: granular_models_2_executor
            target: instruments.kaivo_2
            property: "level"
            duration: sec(45);
            from: 1; to: 0;

            WPN114.Automation
            {
                target: instruments.k1_fork_921
                property: "dBlevel"
                duration: sec(45);
                from: 1; to: 0;
            }
        }

        WPN114.Automation //---------------------------- AMBIENT_LIGHT_FADE_OUT
        {
            after: granular_models_2_executor
            target: ambient_light
            property: "level"
            duration: sec(45)
            from: 1; to: 0;
        }

        onEnd:
        {
            markhor_rooms.active = false;
            instruments.kaivo_2.allNotesOff();
            root.end()
        }
    }

    Item //-------------------------------------------------------------------- INTERACTIONS
    {
        id: interactions

        Interaction //--------------------------------------------- CLOCK_BELLS
        {
            id:     interaction_clock_bells

            title:  "Cloches, pré-rythmiques"
            path:   "/stonepath/markhor/interactions/clock-bells"
            module: "quarre/VareRainbells.qml"

            description: "Passez la main devant l'appareil pour ajouter et changer les notes des cloches, pivotez-le doucement dans n'importe quel axe de rotation"
            //afin de changer leurs propriétés."

            mappings:
            [
                QuMapping // ---------------------------------------------- proximity mapping
                {
                    source: "/modules/bells/trigger"
                    expression: function(v) {
                        var rdm_note = 35 + Math.random()*40;
                        var rdm_p = Math.random()*15+2;

                        instruments.kaivo_1.noteOn(0, rdm_note, rdm_p);
                        instruments.kaivo_1.noteOff(0, rdm_note, rdm_p);
                    }
                },

                QuMapping // ---------------------------------------------- rotation mapping
                {
                    source: "/modules/xyzrotation/data"
                    expression: function(v) {

                        instruments.kaivo_1.set("res_brightness", v[0]+90/180);
                        instruments.kaivo_1.set("res_position", (v[2]+180)/360);
                        instruments.kaivo_1.set("res_sustain", (v[1]+180)/360*0.1);
                        instruments.kaivo_1.set("env1_attack", (v[1]+180)/360*0.5);
                    }
                }
            ]
        }

        Interaction //--------------------------------------------- MARKHOR_GRANULAR
        {
            id:     interaction_granular_models

            title:  "Impulsions (essais)"
            path:   "/stonepath/markhor/interactions/granular-1"
            module: "quarre/MarkhorGranular.qml"

            description: "Manipulez les sliders afin d'altérer les propriétés d'excitation
 des résonateurs. Choisissez le son qui vous convient. Attention au temps !"

            mappings:
            [
                QuMapping {
                    source: "/modules/markhor/granular/overlap"
                    expression: function(v) {
                        console.log("gran_density", v);
                        instruments.kaivo_2.set("gran_density", v)
                    }},

                QuMapping {
                    source: "/modules/markhor/granular/pitch"
                    expression: function(v) { instruments.kaivo_2.set("gran_pitch", v) }},

                QuMapping {
                    source: "/modules/markhor/granular/pitch_env"
                    expression: function(v) { instruments.kaivo_2.set("gran_pitch_env", v) }}
            ]
        }

        Interaction //--------------------------------------------- MARKHOR_RESONATORS
        {
            id:     interaction_resonators_1

            title:  "Résonances (essais)"
            path:   "/stonepath/markhor/interactions/resonator-1"
            module: "quarre/MarkhorResonator.qml"

            description: "Manipulez les sliders afin d'altérer la résonance
des percussions. Choisissez le son qui vous convient. Attention au temps !"

            mappings:
            [
                QuMapping {
                    source: "/modules/markhor/resonator/brightness"
                    expression: function(v) {
                        console.log("res_brightness", v);
                        instruments.kaivo_2.set("res_brightness", v) }},

                QuMapping {
                    source: "/modules/markhor/resonator/position"
                    expression: function(v) { instruments.kaivo_2.set("res_position", v) }},

                QuMapping {
                    source: "/modules/markhor/resonator/pitch"
                    expression: function(v) { instruments.kaivo_2.set("res_pitch_p", v) }},

                QuMapping {
                    source: "/modules/markhor/resonator/sustain"
                    expression: function(v) { instruments.kaivo_2.set("res_sustain", v) }}
            ]
        }

        Interaction //--------------------------------------------- MARKHOR_BODY
        {
            id:     interaction_body_1

            title:  "Corps de résonance (essais)"
            path:   "/stonepath/markhor/interactions/body-1"
            module: "quarre/MarkhorBody.qml"

            description: "Manipulez les sliders afin d'altérer le corps de résonance
 des percussions. Choisissez le son qui vous convient. Attention au temps !"

            mappings:
                [
                QuMapping {
                    source: "/modules/markhor/body/tone"
                    expression: function(v) { instruments.kaivo_2.set("body_tone", v) }},

                QuMapping {
                    source: "/modules/markhor/body/pitch"
                    expression: function(v) { instruments.kaivo_2.set("body_pitch", v) }},

                QuMapping {
                    source: "/modules/markhor/body/xy"
                    expression: function(v) {
                        instruments.kaivo_2.set("body_position_x", v[0]);
                        instruments.kaivo_2.set("body_position_y", v[1])}}
            ]
        }

        Interaction //--------------------------------------------- MARKHOR_PADS
        {
            id:     interaction_pads_1

            title:  "Temps et Contretemps (essais)"
            path:   "/stonepath/markhor/interactions/pads-1"
            module: "quarre/MarkhorPads.qml"

            description: "Appuyez et maintenez l'un des pads (un seul à la fois)
 pour ajouter des compléments rythmiques."

            property var pads: [ 81, 82, 83, 85, 73, 77, 78, 79, 65, 67, 68, 72 ]

            mappings: QuMapping
            {
                source: "/modules/markhor/pads/index"
                expression: function(v) {
                    if ( v === 0 )
                        for ( var i = 0; i < interaction_pads_1.pads.length; ++i )
                            instruments.kaivo_2.noteOff(0, interaction_pads_1.pads[i], 127);

                    else instruments.kaivo_2.noteOn(0, interaction_pads_1.pads[v-1], 127);
                }
            }
        }

        Interaction //--------------------------------------------- MARKHOR_GRANULAR_2
        {
            id:     interaction_granular_models_2

            title:  "Impulsions (tutti)"
            path:   "/stonepath/markhor/interactions/granular-2"
            module: "quarre/MarkhorGranular.qml"

            description: "Vous jouez maintenant tous ensemble, collaborez,
 laissez-vous des temps à chacun, et trouvez des rythmiques intéressantes!"

            mappings: interaction_granular_models.mappings
        }

        Interaction //--------------------------------------------- MARKHOR_RESONATORS_2
        {
            id:     interaction_resonators_2

            title:  "Résonances (tutti)"
            path:   "/stonepath/markhor/interactions/resonator-2"
            module: "quarre/MarkhorResonator.qml"

            description: interaction_granular_models_2.description
            mappings: interaction_resonators_1.mappings
        }

        Interaction //--------------------------------------------- MARKHOR_BODY_2
        {
            id:     interaction_body_2

            title:  "Corps de résonance (tutti)"
            path:   "/stonepath/markhor/interactions/body-2"
            module: "quarre/MarkhorBody.qml"

            description: interaction_granular_models_2.description
            mappings: interaction_body_1.mappings
        }

        Interaction //--------------------------------------------- MARKHOR_PADS_2
        {
            id:     interaction_pads_2

            title:  "Temps et Contretemps (tutti)"
            path:   "/stonepath/markhor/interactions/pads-2"
            module: "quarre/MarkhorPads.qml"

            description: interaction_granular_models_2.description
            mappings: interaction_pads_1.mappings
        }
    }

    WPN114.Rooms
    {
        id: markhor_rooms
        active: false
        parentStream: audio_stream
        setup: rooms_setup

        exposePath: "/stonepath/markhor/audio/rooms"

        WPN114.StereoSource //----------------------------------------- 1.DOOMSDAY (1-2)
        {
            fixed: true
            xspread: 0.25
            diffuse: 0.55

            exposePath: "/stonepath/markhor/audio/doomsday/source"

            WPN114.MultiSampler { id: doomsday;
                exposePath: "/stonepath/markhor/audio/doomsday"
                path: "audio/stonepath/markhor/doomsday" }
        }

        WPN114.StereoSource //----------------------------------------- 2.AMBIENT-LIGHT (3-4)
        {
            fixed: true
            xspread: 0.15
            diffuse: 0.3
            y: 0.85

            exposePath: "/stonepath/markhor/audio/ambient-light/source"

            WPN114.Sampler { id: ambient_light; loop: true
                exposePath: "/stonepath/markhor/audio/ambient-light"
                path: "audio/stonepath/markhor/ambient-light.wav" }
        }

        WPN114.StereoSource //----------------------------------------- 3.PARORAL (5-6)
        {
            fixed: true
            xspread: 0.35
            diffuse: 0.65
            y: 0.7

            exposePath: "/stonepath/markhor/audio/paroral/source"

            WPN114.Sampler { id: paroral;
                exposePath: "/stonepath/markhor/audio/paroral"
                path: "audio/stonepath/markhor/paroral.wav" }
        }

        WPN114.StereoSource //----------------------------------------- 4.SOUNDSCAPE (7-8)
        {
            fixed: true
            xspread: 0.25
            diffuse: 1.0
            y: 0.4

            exposePath: "/stonepath/markhor/audio/soundscape/source"

            WPN114.Sampler { id: soundscape; loop: true; xfade: 2000
                exposePath: "/stonepath/markhor/audio/soundscape"
                path: "audio/stonepath/markhor/soundscape.wav" }
        }

        WPN114.StereoSource //----------------------------------------- 5.BELL_HIT (9-10)
        {
            fixed: true
            xspread: 0.05
            diffuse: 0.2
            y: 0.55

            exposePath: "/stonepath/markhor/audio/bell-hit/source"

            WPN114.Sampler { id: bell_hit;
                exposePath: "/stonepath/markhor/audio/bell-hit"
                path: "audio/stonepath/markhor/bell-hit.wav" }
        }
    }

}
