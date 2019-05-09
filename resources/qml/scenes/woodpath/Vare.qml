import QtQuick 2.0
import WPN114 1.0 as WPN114
import "../../engine"
import ".."

Scene
{
    id: root

    property alias interaction_rainbells: interaction_rainbells

    scenario: WPN114.TimeNode
    {
        parentNode:  parent.scenario
        source:      audiostream
        duration:    WPN114.TimeNode.Infinite

        onStart:
        {
            instruments.kaivo_1.active  = true;
            instruments.kaivo_1.dBlevel = -12
            instruments.k1_fork_921.dBlevel = -16;
            instruments.kaivo_2.dBlevel = -9
            instruments.k2_fork_921.dBlevel = -9

            instruments.kaivo_2.active  = true;
            instruments.rooms.active    = true;
            snowfall.play();
        }

        onEnd:
        {
            instruments.kaivo_1.allNotesOff();
            instruments.kaivo_2.allNotesOff();

            functions.setTimeout(function() {
                instruments.kaivo_2.active = false;
            }, 2000)
        }

        InteractionExecutor //===================================================== RAINBELLS
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

            onEnd:
            {
                // speed-up rhythm
                instruments.kaivo_2.noteOff ( 0, 63, 127 );
                instruments.kaivo_2.noteOn  ( 0, 73, 127 );
            }

            WPN114.Automation // --------------------------------------- rainbells_rhythmic_fade_in
            {
                target:     instruments.kaivo_1
                property:   "level"
                date:       sec( 15 )
                duration:   sec( 60 )

                from: 0; to: instruments.kaivo_1.level;

                WPN114.Automation //--------------------------------------- rhythmic_fade_in
                {
                    target:     instruments.kaivo_2
                    property:   "level"
                    date:       sec( 10 );
                    duration:   sec( 50 );

                    from: 0; to: instruments.kaivo_2.level;

                    onStart:
                    {
                        instruments.kaivo_2.noteOn( 0, 63, 127 );
                        instruments.kaivo_2.noteOn( 0, 68, 127 );
                    }
                }
            }
        }

        WPN114.Automation //======================================== RAINBELLS_FADE_OUT
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

        InteractionExecutor //======================================= FIRST_BATCH_INTERACTIONS
        {
            id:      resonators_1_ex
            after:   rainbells_ex
            target:  interaction_resonators_1

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
            from: -64; to: ambient.dBlevel;
            duration: sec( 45 )

            onStart: ambient.play();

            WPN114.Automation
            {
                target: ambient_verb
                property: "dBlevel"
                from: -64; to: ambient_verb.dBlevel
                duration: sec( 45 )
            }
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
            from: instruments.kaivo_1.level; to: 0;
            duration: sec( 40 )

            WPN114.Automation
            {
                target: instruments.kaivo_2
                property: "level"
                from: instruments.kaivo_2.level; to: 0;
                duration: sec( 40 )
            }

            WPN114.Automation
            {
                after:   parentNode
                target:  rooms
                property: "level"
                from: rooms.level; to: 0;

                duration: sec( 20 )
                onStart: next();

                onEnd: scenario.end();

                WPN114.Automation
                {
                    target: ambient_verb;
                    property: "dBlevel"
                    from: -2; to: -96;
                    duration: sec( 20 )
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
            module: "quarre/VareRainbells.qml"

            description: "Passez la main devant l'appareil pour ajouter et changer les notes des cloches, pivotez-le doucement dans n'importe quel axe de rotation"
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

                        // 0.186 to
                        var cc1 = Math.min(Math.abs(v[0]), 85)/85*0.2+0.186;
                        var cc2 = Math.min(Math.abs(v[1]), 90)/90;
                        var cc3 = (v[2]+180)/360;

                        instruments.kaivo_1.set("gran_rate", cc1 );
                        instruments.kaivo_1.set("gran_pitch", 0.833+cc1*0.5 );
                        instruments.kaivo_1.set("res_position", cc2);
                        instruments.kaivo_1.set("res_brightness", cc3);
                    }
                }
            ]
        }

        Interaction //--------------------------------------------- MARKHOR_GRANULAR
        {
            id:     interaction_granular_models

            title:  "Impulsions (essais)"
            module: "quarre/VareGranular.qml"

            description: "Manipulez les sliders afin d'altérer les propriétés d'excitation des résonateurs. Choisissez le son qui vous convient. Attention au temps !"

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
            module: "quarre/VareResonator.qml"

            description: "Manipulez les sliders afin d'altérer la résonance des percussions. Choisissez le son qui vous convient. Attention au temps !"

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
            module: "quarre/VareBody.qml"

            description: "Manipulez les sliders afin d'altérer le corps de résonance des percussions. Choisissez le son qui vous convient. Attention au temps !"

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
            module: "quarre/VarePercs.qml"

            description: "Appuyez et maintenez l'un des pads (un seul à la fois) pour ajouter des compléments rythmiques."

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
            module: "quarre/VareGranular.qml"

            description: "Vous jouez maintenant tous ensemble, collaborez, laissez-vous des temps à chacun, et trouvez des rythmiques intéressantes!"

            mappings: interaction_granular_models.mappings
        }

        Interaction //--------------------------------------------- MARKHOR_RESONATORS_2
        {
            id:     interaction_resonators_2
            title:  "Résonances (tutti)"
            module: "quarre/VareResonator.qml"

            description: interaction_granular_models_2.description
            mappings: interaction_resonators_1.mappings
        }

        Interaction //--------------------------------------------- MARKHOR_BODY_2
        {
            id:     interaction_body_2
            title:  "Corps de résonance (tutti)"
            module: "quarre/VareBody.qml"

            description: interaction_granular_models_2.description
            mappings: interaction_body_1.mappings
        }

        Interaction //--------------------------------------------- MARKHOR_PADS_2
        {
            id:     interaction_pads_2
            title:  "Temps et Contretemps (tutti)"
            module: "quarre/VarePercs.qml"

            description: interaction_granular_models_2.description
            mappings: interaction_pads_1.mappings
        }
    }


    WPN114.StereoSource //----------------------------------------- 1.SNOWFALL (1-2)
    {
        parentStream: rooms
        xspread: 0.25
        z: 0.7
        fixed: true

        exposePath: fmt("audio/snowfall/source")

        WPN114.StreamSampler { id: snowfall; dBlevel: 3
            loop: true; xfade: 3000; attack: 2000

            exposePath: fmt("audio/snowfall")
            path: "audio/woodpath/vare/snowfall.wav"
            WPN114.Fork { target: effects.reverb; dBlevel: -9 }
        }
    }

    WPN114.StereoSource //----------------------------------------- 3.PARORAL (5-6)
    {
        parentStream: rooms
        fixed: true
        xspread: 0.45
        z: 0.5

        exposePath: fmt("audio/ambient/source")

        WPN114.StreamSampler { id: ambient; dBlevel: -7
            exposePath: fmt("audio/ambient")
            path: "audio/woodpath/vare/vare-ambient.wav"
            WPN114.Fork { id: ambient_verb;
                target: effects.reverb; prefader: true; dBlevel: -2 }
        }
    }
}

