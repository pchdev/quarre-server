import QtQuick 2.0
import WPN114 1.0 as WPN114
import "../../engine"
import ".."

Scene
{    
    id: root

    scenario: WPN114.TimeNode
    {
        source: audiostream
        parentNode: parent.scenario
        duration: WPN114.TimeNode.Infinite

        onStart:
        {
            instruments.kaivo_1.dBlevel = -24
            instruments.k1_fork_921.dBlevel = -6;
            instruments.kaivo_2.dBlevel = -6
            instruments.k2_fork_921.dBlevel = -6;

            instruments.kaivo_1.active  = true;
            instruments.kaivo_2.active  = true;
            instruments.rooms.active    = true;

            soundscape.play();
        }

        InteractionExecutor //----------------------------------------------------- BELLS
        {
            id:         bells_executor
            target:     interaction_clock_bells
            date:       sec( 5 )
            length:     sec( 52 )
            countdown:  sec( 8 )

            onStart:
            {
                instruments.kaivo_1.setPreset( instruments.autochurch );
                instruments.kaivo_2.setPreset( instruments.markhor );

                functions.setTimeout(function() {
                    instruments.kaivo_1.allNotesOff();
                }, 1000)
            }

            onEnd:
            {
                instruments.kaivo_1.allNotesOff();

                functions.setTimeout(function(){
                    instruments.kaivo_1.active = false;
                }, 2000);
            }

            WPN114.TimeNode
            {
                date: sec( 8.2 )
                onStart: bell_hit.play();
            }

            WPN114.Automation
            {
                date: sec( 15 )
                target: instruments.kaivo_1
                property: "dBlevel"
                duration: sec( 22 )
                from: instruments.kaivo_1.dBlevel; to: -6;
            }

            WPN114.Automation
            {
                date: sec( 15 )
                target: instruments.kaivo_2
                property: "dBlevel"
                duration: sec( 45 )
                from: -48; to: instruments.kaivo_2.dBlevel;

                onStart:
                {
                    instruments.kaivo_2.noteOn(0, 65, 127)
                    instruments.kaivo_2.noteOn(0, 70, 127)
                }
            }
        }

        InteractionExecutor //---------------------------------------------------- MARKHOR_DANCE
        {
            id:         granular_models_1_executor
            after:      bells_executor
            target:     interaction_granular_models
            countdown:  sec( 15 )
            length:     sec( 60 )

            onStart:
            {
                ambient_light.play();

                instruments.kaivo_2.noteOff(0, 65, 127);
                instruments.kaivo_2.noteOn(0, 75, 127);
//                instruments.kaivo_2.noteOn(0, 80, 127);
            }
        }

        // DOOMSDAYS
        WPN114.TimeNode { after: bells_executor; date: sec( 20 ); onStart: doomsday.playRandom();  }
        WPN114.TimeNode { after: bells_executor; date: min( 1.35 ); onStart: doomsday.playRandom(); }
        WPN114.TimeNode { after: bells_executor; date: min( 3.05 ); onStart: doomsday.playRandom(); }

        WPN114.Automation
        {
            target:     ambient_light
            after:      bells_executor;
            property:   "dBlevel"
            duration:   sec( 30 )

            from: -96; to: 0;
        }

        InteractionExecutor
        {
            id:         resonator_executor
            after:      bells_executor
            target:     interaction_resonators_1
            date:       min( 1.08 )
            countdown:  sec( 15 )
            length:     sec( 60 )
        }

        InteractionExecutor
        {
            id:         body_executor
            after:      granular_models_1_executor
            target:     interaction_body_1
            date:       min( 1.08 )
            countdown:  sec( 15 )
            length:     sec( 60 )
        }

        InteractionExecutor
        {
            id:         pads_executor;
            after:      bells_executor;
            target:     interaction_pads_1
            date:       sec( 20 )
            countdown:  sec( 15 )
            length:     sec( 175 )

            onStart:  instruments.kaivo_2.noteOn(0, 80, 127);

            onEnd:
            {
                for ( var i = 0; i < interaction_pads_1.pads.length; ++i )
                    instruments.kaivo_2.noteOff(0, interaction_pads_1.pads[i], 127);
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

            WPN114.TimeNode { date: sec( 40 ); onStart: doomsday.playRandom();  }
            WPN114.TimeNode { date: min( 1.30 ); onStart: doomsday.playRandom();  }
            WPN114.TimeNode { date: min( 2.45 ); onStart: doomsday.playRandom();  }

            InteractionExecutor //---------------------------- BODY
            {
                target:     interaction_body_2
                countdown:  sec( 10 )
                length:     sec( 180 )

                InteractionExecutor //---------------------------- GRANULAR
                {
                    id:         granular_models_2_executor
                    target:     interaction_granular_models_2
                    countdown:  sec( 10 )
                    length:     sec( 180 )
                }
            }
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
            after:      granular_models_2_executor
            target:     soundscape
            property:   "level"
            duration:   min( 1 )

            from: soundscape.level; to: 0;

            WPN114.Automation //---------------------------- KAIVO_FADE_OUT
            {
                target:     instruments.kaivo_2
                property:   "dBlevel"
                duration:   sec( 50 );

                from: instruments.kaivo_2.level; to: -48;

                WPN114.Automation
                {
                    target:     instruments.k2_fork_921
                    property:   "dBlevel"
                    duration:   sec( 50 );

                    from: instruments.k2_fork_921.dBlevel; to: -48;
                }

                WPN114.Automation //---------------------------- AMBIENT_LIGHT_FADE_OUT
                {
                    after:      granular_models_2_executor
                    target:     ambient_light
                    property:   "level"
                    duration:   sec( 45 )

                    from: ambient_light.level; to: 0;
                }
            }

            onEnd:
            {
                instruments.kaivo_2.allNotesOff()
                scenario.end();
            }
        }
    }

    Item //-------------------------------------------------------------------- INTERACTIONS
    {
        id: interactions

        Interaction //--------------------------------------------- CLOCK_BELLS
        {
            id:     interaction_clock_bells

            title:  "Cloches, pré-rythmiques"
            module: "quarre/VareRainbells.qml"

            description: "Passez la main devant l'appareil pour ajouter et changer les notes des cloches, pivotez-le doucement dans n'importe quel axe de rotation"
            //afin de changer leurs propriétés."

            property int last_note: 0

            mappings:
                [
                QuMapping // ---------------------------------------------- proximity mapping
                {
                    source: "/modules/bells/trigger"
                    expression: function(v) {
                        var rdm_note = 45 + Math.random()*30;

                        if ( interaction_clock_bells.last_note )
                            instruments.kaivo_1.noteOff(0, interaction_clock_bells.last_note, 127 );

                        instruments.kaivo_1.noteOn  ( 0, rdm_note, 127 );

                        interaction_clock_bells.last_note = rdm_note;
                    }
                },

                QuMapping // ---------------------------------------------- rotation mapping
                {
                    source: "/modules/xyzrotation/data"
                    expression: function(v) {

                        var x = (v[0]+90)/180;
                        var y = (v[1]+180)/360;

                        instruments.kaivo_1.set(" body_pitch", x );
                        instruments.kaivo_1.set( "body_position_x", x );
                        instruments.kaivo_1.set( "res_brightness", y );
                        instruments.kaivo_1.set( "body_position_y", y );

                        instruments.kaivo_1.set("body_tone", (v[2]+180)/360)
                    }
                }
            ]
        }

        Interaction //--------------------------------------------- MARKHOR_GRANULAR
        {
            id:     interaction_granular_models
            title:  "Impulsions (essais)"
            module: "quarre/MarkhorGranular.qml"

            description: "Manipulez les sliders afin d'altérer les propriétés d'excitation
 des résonateurs. Choisissez le son qui vous convient. Attention au temps !"

            mappings:
                [
                QuMapping {
                    source: "/modules/markhor/granular/overlap"
                    expression: function(v) { instruments.kaivo_2.set("gran_density", v)}},

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
            module: "quarre/MarkhorResonator.qml"

            description: "Manipulez les sliders afin d'altérer la résonance
des percussions. Choisissez le son qui vous convient. Attention au temps !"

            mappings:
                [
                QuMapping {
                    source: "/modules/markhor/resonator/brightness"
                    expression: function(v) { instruments.kaivo_2.set("res_brightness", v) }},

                QuMapping {
                    source: "/modules/markhor/resonator/position"
                    expression: function(v) { instruments.kaivo_2.set("res_position", v) }},

                QuMapping {
                    source: "/modules/markhor/resonator/pitch"
                    expression: function(v) { instruments.kaivo_2.set("res_pitch_p", v) }},

                QuMapping {
                    source: "/modules/markhor/resonator/sustain"
                    expression: function(v) { instruments.kaivo_2.set("res_sustain", v*0.5) }}
            ]
        }

        Interaction //--------------------------------------------- MARKHOR_BODY
        {
            id:     interaction_body_1
            title:  "Corps de résonance (essais)"
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
            module: "quarre/MarkhorGranular.qml"

            description: "Vous jouez maintenant tous ensemble, collaborez,
 laissez-vous des temps à chacun, et trouvez des rythmiques intéressantes!"

            mappings: interaction_granular_models.mappings
        }

        Interaction //--------------------------------------------- MARKHOR_RESONATORS_2
        {
            id:     interaction_resonators_2

            title:  "Résonances (tutti)"
            module: "quarre/MarkhorResonator.qml"

            description: interaction_granular_models_2.description
            mappings: interaction_resonators_1.mappings
        }

        Interaction //--------------------------------------------- MARKHOR_BODY_2
        {
            id:     interaction_body_2

            title:  "Corps de résonance (tutti)"
            module: "quarre/MarkhorBody.qml"

            description: interaction_granular_models_2.description
            mappings: interaction_body_1.mappings
        }

        Interaction //--------------------------------------------- MARKHOR_PADS_2
        {
            id:     interaction_pads_2

            title:  "Temps et Contretemps (tutti)"
            module: "quarre/MarkhorPads.qml"

            description: interaction_granular_models_2.description
            mappings: interaction_pads_1.mappings
        }
    }

    WPN114.StereoSource //----------------------------------------- 1.DOOMSDAY (1-2)
    {
        parentStream: rooms
        fixed: true
        xspread: 0.35
        diffuse: 0.20
        y: 0.15

        exposePath: fmt("audio/doomsday/source")

        WPN114.MultiSampler { id: doomsday;
            exposePath: fmt("audio/doomsday")
            path: "audio/stonepath/markhor/doomsday" }
    }

    WPN114.StereoSource //----------------------------------------- 2.AMBIENT-LIGHT (3-4)
    {
        parentStream: rooms
        fixed: true
        xspread: 0.15
        diffuse: 0.3
        y: 0.85

        exposePath: fmt("audio/ambient-light/source")

        WPN114.Sampler { id: ambient_light; loop: true
            exposePath: fmt("audio/ambient-light")
            path: "audio/stonepath/markhor/ambient-light.wav" }
    }

    WPN114.StereoSource //----------------------------------------- 3.PARORAL (5-6)
    {
        parentStream: rooms
        fixed: true
        xspread: 0.35
        diffuse: 0.65
        y: 0.7

        exposePath: fmt("audio/paroral/source")

        WPN114.Sampler { id: paroral;
            exposePath: fmt("audio/paroral")
            path: "audio/stonepath/markhor/paroral.wav" }
    }

    WPN114.StereoSource //----------------------------------------- 4.SOUNDSCAPE (7-8)
    {
        parentStream: rooms
        fixed: true
        xspread: 0.25
        diffuse: 1.0
        y: 0.4

        exposePath: fmt("audio/soundscape/source")

        WPN114.Sampler { id: soundscape; loop: true; xfade: 2000
            exposePath: fmt("audio/soundscape")
            path: "audio/stonepath/markhor/soundscape.wav" }
    }

    WPN114.StereoSource //----------------------------------------- 5.BELL_HIT (9-10)
    {
        parentStream: rooms
        fixed: true
        xspread: 0.05
        diffuse: 0.2
        y: 0.55

        exposePath: fmt("audio/bell-hit/source")

        WPN114.Sampler { id: bell_hit;
            exposePath: fmt("audio/bell-hit")
            path: "audio/stonepath/markhor/bell-hit.wav" }
    }
}
