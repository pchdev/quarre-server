import QtQuick 2.0
import WPN114 1.0 as WPN114
import "../.."
import ".."

Item
{
    property alias scenario: scenario
    property alias rooms: vare_rooms
    signal next()

    WPN114.TimeNode
    {
        id:             scenario
        source:         audio_stream
        exposePath:     "/woodpath/vare/scenario"

        duration: -1

        onStart:
        {
            vare_rooms.active = true;
            instruments.rooms.active = true;
            instruments.kaivo_1.active = true;
            instruments.kaivo_2.active = true;
            snowfall.play();

            client_manager.notifyScene("vare");
        }

        InteractionExecutor
        {
            id:         rainbells_ex
            target:     interaction_rainbells
            date:       sec( 5 )
            countdown:  sec( 15 )
            length:     sec( 60 )

            onStart:
            {
                instruments.kaivo_1.setPreset( instruments.rainbells );
                instruments.kaivo_2.setPreset( instruments.vare );
            }

            WPN114.TimeNode { date: sec( 41 ); onStart: hammer.play() }

            WPN114.Automation
            {
                target:     instruments.kaivo_1
                property:   "level"
                date:       sec( 15 )
                duration:   sec( 60 )

                from: 0; to: 1;
            }

            onEnd: instruments.kaivo_1.active = false
        }

        InteractionExecutor
        {
            id:     resonators_1_ex
            after:  rainbells_ex
            target: interaction_resonators_1

            countdown:  sec( 15 )
            length:     sec( 60 )

            onStart:
            {
                instruments.kaivo_2.noteOn( 0, 68, 127 );
                instruments.kaivo_2.noteOn( 0, 73, 127 );
            }
        }

        InteractionExecutor
        {
            id:         pads_ex_1
            after:      rainbells_ex
            target:     interaction_pads_1
            date:       min( 1.10 )
            countdown:  sec( 15 )
            length:     min( 2.20 )
        }

        InteractionExecutor
        {
            after:  rainbells_ex
            target: interaction_body_1

            date:       min( 1.10 )
            countdown:  sec( 15 )
            length:     sec( 60 )
        }

        InteractionExecutor
        {
            after:  resonators_1_ex
            target: interaction_granular_models

            date:       min( 1.10 )
            countdown:  sec( 15 )
            length:     sec( 60 )
        }
    }


    Item //-------------------------------------------------------------------- INTERACTIONS
    {
        id: interactions

        Interaction //--------------------------------------------- RAINBELLS
        {
            id:     interaction_rainbells

            title:  "Cloches, pré-rythmiques"
            path:   "/woodpath/vare/interactions/rainbells"
            module: "quarre/VareRainbells.qml"

            description: "Passez la main devant l'appareil pour ajouter et changer
 les notes des cloches, pivotez-le doucement dans n'importe quel axe de rotation"
            //afin de changer leurs propriétés."

            property var notes: [ ]

            mappings:
                [
                QuMapping // ---------------------------------------------- proximity mapping
                {
                    source: "/modules/bells/trigger"
                    expression: function(v) {

                        if ( interaction_rainbells.notes.length === 4 )
                        {
                            var note = interaction_rainbells.notes[ 0 ];
                            instruments.kaivo_1.noteOff(0, note, 100 )
                            interaction_rainbells.notes.splice(0, 1);
                        }

                        var rdm_note = 47 + Math.random()*40;
                        var rdm_p = Math.random()*15+2;

                        instruments.kaivo_1.noteOn(0, rdm_note, rdm_p);
                        interaction_rainbells.notes.push(rdm_note);
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
            path:   "/woodpath/vare/interactions/granular-1"
            module: "quarre/VareGranular.qml"

            description: "Manipulez les sliders afin d'altérer les propriétés d'excitation
 des résonateurs. Choisissez le son qui vous convient. Attention au temps !"

            mappings:
                [
                QuMapping {
                    source: "/modules/vare/granular/overlap"
                    expression: function(v) {
                        console.log("gran_density", v);
                        instruments.kaivo_2.set("gran_density", v)
                    }},

                QuMapping {
                    source: "/modules/vare/granular/pitch"
                    expression: function(v) { instruments.kaivo_2.set("gran_pitch", v) }},

                QuMapping {
                    source: "/modules/vare/granular/position"
                    expression: function(v) { instruments.kaivo_2.set("gran_pitch_env", v) }}
            ]
        }

        Interaction //--------------------------------------------- MARKHOR_RESONATORS
        {
            id:     interaction_resonators_1

            title:  "Résonances (essais)"
            path:   "/woodpath/vare/interactions/resonator-1"
            module: "quarre/VareResonator.qml"

            description: "Manipulez les sliders afin d'altérer la résonance
des percussions. Choisissez le son qui vous convient. Attention au temps !"

            mappings:
                [
                QuMapping {
                    source: "/modules/vare/resonator/brightness"
                    expression: function(v) {
                        console.log("res_brightness", v);
                        instruments.kaivo_2.set("res_brightness", v) }},

                QuMapping {
                    source: "/modules/vare/resonator/position"
                    expression: function(v) { instruments.kaivo_2.set("res_position", v) }},

                QuMapping {
                    source: "/modules/vare/resonator/pitch"
                    expression: function(v) { instruments.kaivo_2.set("res_pitch_p", v) }},

                QuMapping {
                    source: "/modules/vare/resonator/sustain"
                    expression: function(v) { instruments.kaivo_2.set("res_sustain", v) }}
            ]
        }

        Interaction //--------------------------------------------- MARKHOR_BODY
        {
            id:     interaction_body_1

            title:  "Corps de résonance (essais)"
            path:   "/woodpath/vare/interactions/body-1"
            module: "quarre/VarerBody.qml"

            description: "Manipulez les sliders afin d'altérer le corps de résonance
 des percussions. Choisissez le son qui vous convient. Attention au temps !"

            mappings:
                [
                QuMapping {
                    source: "/modules/vare/body/tone"
                    expression: function(v) { instruments.kaivo_2.set("body_tone", v) }},

                QuMapping {
                    source: "/modules/vare/body/pitch"
                    expression: function(v) { instruments.kaivo_2.set("body_pitch", v) }},

                QuMapping {
                    source: "/modules/vare/body/xy"
                    expression: function(v) {
                        instruments.kaivo_2.set("body_position_x", v[0]);
                        instruments.kaivo_2.set("body_position_y", v[1])}}
            ]
        }

        Interaction //--------------------------------------------- MARKHOR_PADS
        {
            id:     interaction_pads_1

            title:  "Temps et Contretemps (essais)"
            path:   "/woodpath/vare/interactions/pads-1"
            module: "quarre/VarePercs.qml"

            description: "Appuyez et maintenez l'un des pads (un seul à la fois)
 pour ajouter des compléments rythmiques."

            property var pads: [ 81, 82, 83, 85, 73, 77, 78, 79, 65, 67, 68, 72 ]

            mappings: QuMapping
            {
                source: "/modules/vare/pads/index"
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
            path:   "/woodpath/vare/interactions/granular-2"
            module: "quarre/VareGranular.qml"

            description: "Vous jouez maintenant tous ensemble, collaborez,
 laissez-vous des temps à chacun, et trouvez des rythmiques intéressantes!"

            mappings: interaction_granular_models.mappings
        }

        Interaction //--------------------------------------------- MARKHOR_RESONATORS_2
        {
            id:     interaction_resonators_2

            title:  "Résonances (tutti)"
            path:   "/woodpath/vare/interactions/resonator-2"
            module: "quarre/VareResonator.qml"

            description: interaction_granular_models_2.description
            mappings: interaction_resonators_1.mappings
        }

        Interaction //--------------------------------------------- MARKHOR_BODY_2
        {
            id:     interaction_body_2

            title:  "Corps de résonance (tutti)"
            path:   "/woodpath/vare/interactions/body-2"
            module: "quarre/VareBody.qml"

            description: interaction_granular_models_2.description
            mappings: interaction_body_1.mappings
        }

        Interaction //--------------------------------------------- MARKHOR_PADS_2
        {
            id:     interaction_pads_2

            title:  "Temps et Contretemps (tutti)"
            path:   "/woodpath/vare/interactions/pads-2"
            module: "quarre/VarePads.qml"

            description: interaction_granular_models_2.description
            mappings: interaction_pads_1.mappings
        }
    }

    WPN114.Rooms
    {
        id: vare_rooms
        active: false
        parentStream: audio_stream
        setup: rooms_setup

        WPN114.StereoSource //----------------------------------------- 1.SNOWFALL (1-2)
        {
            exposePath: "/woodpath/vare/audio/snowfall/source"

            WPN114.StreamSampler { id: snowfall; loop: true; xfade: 3000; attack: 2000
                exposePath: "/woodpath/vare/audio/snowfall"
                path: "audio/woodpath/vare/snowfall.wav"
                WPN114.Fork { target: effects.reverb; dBlevel: -3 }
            }
        }

        WPN114.StereoSource //----------------------------------------- 2.HAMMER (3-4)
        {
            exposePath: "/woodpath/vare/audio/hammer/source"

            WPN114.Sampler { id: hammer;
                exposePath: "/woodpath/vare/audio/hammer"
                path: "audio/woodpath/vare/hammer.wav"
                WPN114.Fork { target: effects.reverb; dBlevel: -0 }
            }
        }

        WPN114.StereoSource //----------------------------------------- 3.PARORAL (5-6)
        {
            exposePath: "/woodpath/vare/audio/paroral/source"

            WPN114.Sampler { id: paroral;
                exposePath: "/woodpath/vare/audio/paroral"
                path: "audio/stonepath/markhor/paroral.wav"
                WPN114.Fork { target: effects.reverb; dBlevel: -3 }
            }
        }
    }
}
