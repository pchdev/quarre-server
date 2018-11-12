import QtQuick 2.0
import WPN114 1.0 as WPN114
import "../.."
import ".."

Item
{
    id: root
    property alias scenario: scenario
    property alias rooms: vare_rooms
    signal next()

    WPN114.TimeNode
    {
        id:             scenario
        source:         audio_stream
        exposePath:     "/woodpath/vare/scenario"
        duration:       -1

        onStart:
        {
            vare_rooms.active           = true;
            instruments.kaivo_1.active  = true;
            instruments.kaivo_2.active  = true;
            instruments.rooms.active    = true;

            snowfall.play();

            vare_rooms.level = 1;

            client_manager.notifyScene("vare");
            if ( !timer.running ) timer.start();
        }

        onEnd:
        {
            snowfall.stop();
            ambient.stop();

            instruments.kaivo_1.allNotesOff();
            instruments.kaivo_2.allNotesOff();

            functions.setTimeout(function() {
                vare_rooms.active = false;
                instruments.kaivo_1.active = false;
                instruments.kaivo_2.active = false;
            }, 2000)
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
                instruments.kaivo_2.setPreset( instruments.varerhythm );
            }

            WPN114.Automation
            {
                target:     instruments.kaivo_1
                property:   "level"
                date:       sec( 15 )
                duration:   sec( 60 )

                from: 0; to: 1;
            }

            WPN114.Automation
            {
                target:     instruments.kaivo_2
                property:   "level"
                date:       sec( 25 );
                duration:   sec( 50 );

                from: 0; to: 1;

                onStart:
                {
                    instruments.kaivo_2.noteOn( 0, 63, 127 );
                    instruments.kaivo_2.noteOn( 0, 68, 127 );
                }
            }

            onEnd:
            {
                instruments.kaivo_2.noteOff ( 0, 63, 127 );
                instruments.kaivo_2.noteOn  ( 0, 73, 127 );
            }
        }

        WPN114.Automation
        {
            id: rainbells_fade_out
            after: rainbells_ex
            target: instruments.kaivo_1
            property: "level"
            duration: sec( 20 );

            from:  instruments.kaivo_1.level; to: 0;
            onEnd:
            {
                instruments.kaivo_1.allNotesOff();
                functions.setTimeout(function() {
                    instruments.kaivo_1.active = false;
                }, 5000 );
            }
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
                instruments.kaivo_2.noteOff ( 0, 68, 127 );
                instruments.kaivo_2.noteOn  ( 0, 78, 127 );
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

            onStart:
            {
                instruments.kaivo_2.noteOff ( 0, 73, 127 );
                instruments.kaivo_2.noteOn  ( 0, 83, 127 );
            }

            onEnd:
            {
                if ( interaction_pads_1.last_note )
                {
                    instruments.kaivo_2.noteOff( 0, interaction_pads_1.last_note, 127 )
                    interaction_pads_1.last_note = 0;
                }
            }
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
            id:      interaction_granular_models_ex
            after:   resonators_1_ex
            target:  interaction_granular_models

            date:       min( 1.10 )
            countdown:  sec( 15 )
            length:     sec( 60 )
        }

        // AND THEN SECOND BATCH OF INTERACTIONS ( TUTTI )

        WPN114.Automation
        {
            after: pads_ex_1
            target: ambient
            property: "dBlevel"
            from: -48; to: ambient.dBlevel;
            duration: sec( 45 )

            onStart: ambient.play();
        }

        InteractionExecutor
        {
            after: pads_ex_1
            target: interaction_resonators_2
            date: sec( 5 )
            countdown: sec( 10 )
            length: min( 3 )

            InteractionExecutor
            {
                target: interaction_granular_models_2
                countdown: sec( 10 )
                length: min( 3 )

                InteractionExecutor
                {
                    id: interaction_body_2_ex
                    target: interaction_body_2
                    countdown: sec( 10 )
                    length: min( 3 )
                }
            }
        }

        InteractionExecutor
        {
            id:         interaction_pads_2_ex
            after:      interaction_granular_models_ex
            target:     interaction_pads_2
            date:       sec( 15 )
            countdown:  sec( 10 )
            length:     min( 3.30 )
        }

        WPN114.Automation //---- ENDING FADE OUTS
        {
            after: interaction_body_2_ex

            target: instruments.kaivo_1
            property: "level"
            from: instruments.kaivo_1.level
            to: 0;

            duration: sec( 40 )

            WPN114.Automation
            {
                target: instruments.kaivo_2
                property: "level"
                from: instruments.kaivo_2.level
                to: 0;

                duration: sec( 40 )
            }

            WPN114.Automation
            {
                after:   parentNode
                target:  vare_rooms
                property: "level"
                from: vare_rooms.level
                to: 0;

                duration: sec( 20 )

                onStart: root.next();

                onEnd:
                {
                    snowfall.stop();
                    ambient.stop();

                    instruments.kaivo_2.allNotesOff();

                    functions.setTimeout(function(){
                        vare_rooms.active = false;
                        instruments.kaivo_2.active = false;
                    }, 1000 );
                }
            }
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

                        var rdm_note = 60 + Math.random()*20;
                        var rdm_p = 127;

                        instruments.kaivo_1.noteOn(0, rdm_note, rdm_p);
                        interaction_rainbells.notes.push(rdm_note);
                    }
                },

                QuMapping // ---------------------------------------------- rotation mapping
                {
                    source: "/modules/xyzrotation/data"
                    expression: function(v) {

                        var cc1 = Math.min(Math.abs(v[0]), 85)/85*127;
                        var cc2 = Math.min(Math.abs(v[1]), 90)/90*127;
                        var cc3 = (v[2]+180)/360*127;

                        instruments.kaivo_1.control(0, 1, cc1);
                        instruments.kaivo_1.control(0, 2, cc2);
                        instruments.kaivo_1.control(0, 3, cc3);
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
                    expression: function(v) { instruments.kaivo_2.set("gran_density", v) }},

                QuMapping {
                    source: "/modules/vare/granular/pitch"
                    expression: function(v) { instruments.kaivo_2.set("gran_pitch", v) }},

                QuMapping {
                    source: "/modules/vare/granular/pitch-env"
                    expression: function(v) { instruments.kaivo_2.set("gran_pitch_env", v) }},

                QuMapping {
                    source: "/modules/vare/granular/position"
                    expression: function(v) { instruments.kaivo_2.set(95, v) }},

                QuMapping {
                    source: "/modules/vare/granular/position-mod"
                    expression: function(v) { instruments.kaivo_2.set(106, v) }}
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
                    expression: function(v) { instruments.kaivo_2.set("res_brightness", v) }},

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
            module: "quarre/VareBody.qml"

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

            property var pads: [ 86, 87, 88, 89, 81, 82, 84, 85, 71, 73, 76, 80 ]

            property int last_note: 0

            mappings: QuMapping
            {
                source: "/modules/vare/pads/index"
                expression: function(v) {

                    var ln = interaction_pads_1.last_note;

                    if ( ln && !v )
                    {
                        instruments.kaivo_2.noteOff(0, ln, 127);
                        interaction_pads_1.last_note = 0;
                    }

                    else
                    {
                        var nn = interaction_pads_1.pads[v-1]
                        instruments.kaivo_2.noteOn(0, nn, 127);
                        interaction_pads_1.last_note = nn;
                    }
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
            module: "quarre/VarePercs.qml"

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

        exposePath: "/woodpath/vare/audio/rooms"

        WPN114.StereoSource //----------------------------------------- 1.SNOWFALL (1-2)
        {
            xspread: 0.25
            diffuse: 0.2
            fixed: true

            exposePath: "/woodpath/vare/audio/snowfall/source"

            WPN114.StreamSampler { id: snowfall; loop: true; xfade: 3000; attack: 2000
                dBlevel: 6
                exposePath: "/woodpath/vare/audio/snowfall"
                path: "audio/woodpath/vare/snowfall.wav"
                WPN114.Fork { target: effects.reverb; dBlevel: -9 }
            }
        }

        WPN114.StereoSource //----------------------------------------- 3.PARORAL (5-6)
        {
            fixed: true
            xspread: 0.45

            exposePath: "/woodpath/vare/audio/ambient/source"

            WPN114.StreamSampler { id: ambient;
                dBlevel: -7
                exposePath: "/woodpath/vare/audio/ambient"
                path: "audio/woodpath/vare/vare-ambient.wav"
                WPN114.Fork { target: effects.reverb; prefader: true; dBlevel: -2 }
            }
        }
    }
}
