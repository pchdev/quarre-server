import QtQuick 2.0
import WPN114 1.0 as WPN114
import "../.."
import ".."

Item
{
    id: root
    property alias rooms: jomon_rooms
    property alias scenario: scenario
    signal end();

    JomonScore { id: jomon_score }

    WPN114.TimeNode
    {
        id:             scenario
        source:         audio_stream
        exposePath:     "/woodpath/jomon/scenario"
        duration:       -1

        onStart:
        {
            jomon_rooms.active = true;
//            instruments.kaivo_1.active = true;
            instruments.rooms.active = true;
            instruments.kaivo_2.active = true;

            cicadas.play();
            client_manager.notifyScene("yūgure");
            if ( !timer.running ) timer.start();
        }

        // YUGURE ------------------------------------------------------------

//        InteractionExecutor
//        {
//            id:         arpeggiator_ex
//            target:     interaction_arpeggiator
//            date:       sec( 5 )
//            countdown:  sec( 15 )
//            length:     min( 5 )

//            onStart:
//            {
//                instruments.kaivo_1.setPreset( "yguitar" );
//                instruments.kaivo_2.setPreset( "rainbells" );
//                owl1.play()
//            }
//        }

//        InteractionExecutor
//        {
//            target:     interaction_arpeggiator_control
//            date:       sec( 10 )
//            countdown:  sec( 15 )
//            length:     min( 4.55 )

//            onStart:    owl2.play();
//        }

        InteractionExecutor
        {
            target:     interaction_rainbells
            date:       sec( 5 )
            countdown:  sec( 15 )
            length:     sec( 180 )

            onStart:
            {
                owl3.play();
                console.log("starting");
                instruments.kaivo_2.setPreset( instruments.rainbells );
            }

            onEnd:
            {
                owl3.stop();
                instruments.kaivo_2.allNotesOff();
            }
        }

//        InteractionExecutor
//        {
//            target:     interaction_synth_1
//            date:       sec( 30 )
//            countdown:  sec( 15 )
//            length:     min( 2 )

//            onStart:    owl4.play();

//            InteractionExecutor
//            {
//                target:     interaction_synth_2
//                after:      parentNode
//                date:       sec( 5 )
//                countdown:  sec( 10 )
//                length:     min( 2 )
//            }
//        }

        // AKATSUKI ------------------------------------------------------------

//        InteractionExecutor
//        {
//            id:         akatsuki
//            target:     interaction_strings_1
//            after:      arpeggiator_ex
//            date:       sec( 10 )
//            countdown:  sec( 15 )
//            length:     min( 5 )

//            onStart:
//            {
//                instruments.kaivo_1.setPreset("jguitar");
//                client_manager.notifyScene("akatasuki")
//            }

//            endExpression: jomon_score.index === 18;

//            InteractionExecutor
//            {
//                target:      interaction_strings_2
//                countdown:   sec( 10 )
//                length:      min( 5 )
//            }

//            InteractionExecutor
//            {
//                target:     interaction_rainbells
//                date:       sec( 10 )
//                countdown:  sec( 10 )
//                length:     min( 5 )
//            }

//            InteractionExecutor
//            {
//                startExpression: jomon_score.index === 8;
//                countdown:       sec( 5 )
//                length:          min( 3 )
//            }
//        }

//        // JOMON_SUGI ------------------------------------------------------------

//        WPN114.TimeNode
//        {
//            after: akatsuki
//            duration: min( 2.30 )

//            onStart:
//            {
//                client_manager.notifyScene("jomon.sugi")
//            }

//            InteractionExecutor
//            {
//                target:     interaction_mangler_1
//                date:       sec( 37 )
//                countdown:  sec( 15 )
//                length:     min( 1.20 )

//                InteractionExecutor
//                {
//                    target:     interaction_mangler_2
//                    countdown:  sec( 15 )
//                    length:     min( 1.20 )
//                }
//            }
//        }
    }

    Item //-------------------------------------------------------------------- INTERACTIONS
    {
        id: interactions

        Interaction
        {
            id:     interaction_arpeggiator
            path:   "/woodpath/jomon/interactions/arpeggiator"
            title:  "Arpèges, notes"
            module: "quarre/JomonArpeggiator.qml"

            description: ""
        }

        Interaction
        {
            id:    interaction_arpeggiator_control
            path:   "/woodpath/jomon/interactions/arpeggiator-control"
        }

        Interaction //-------------------------------------------------------------------------- RAINBELLS
        {
            id:     interaction_rainbells
            path:   "/woodpath/jomon/interactions/rainbells"

            title:  "Cloches de pluie (2)"
            module: "quarre/JomonPalm.qml"

            description: "Approchez et maintenez la paume de votre main à quelques
centimètres de l'écran de l'appareil pour produire du son"

            mappings:
            [
                QuMapping //--------------------------------------------------- NEAR_GESTURE
                {
                    source: "/modules/jomon/palm/near"
                    expression: function(v) {

                        if ( v )
                        {
                            var r1 = Math.floor(Math.random()*20)+55;
                            var r2 = r1+5;

                            instruments.kaivo_2.noteOn(0, r1, 100);
                            instruments.kaivo_2.noteOn(0, r2, 100);
                        }

                        else instruments.kaivo_2.allNotesOff();
                    }
                },

                QuMapping //--------------------------------------------------- ROTATION_MAPPINGS
                {
                    source: "/modules/xyzrotation/data"
                    expression: function(v) {

                        var norm_z = (v[2]+180)/360;

                        instruments.kaivo_2.set( "res_brightness", norm_z*0.5 );
                        instruments.kaivo_2.set( "res_position", norm_z );
                        instruments.kaivo_2.set( "gran_pitch_env", v[2]/360 + 0.5 );
                        instruments.kaivo_2.set( "gran_density", (v[0]+90)/90*0.34);

                        if ( v[1] < 0 )
                        {
                            // 0.09 to 0.19
                            instruments.kaivo_2.set( "gran_rate", v[1]/180*0.1+0.09);
                            instruments.kaivo_2.set( "gran_pitch", v[1]/360+0.5);
                        }
                        else
                        {
                            instruments.kaivo_2.set( "gran_rate", v[1]/180*0.45);
                            instruments.kaivo_2.set( "gran_pitch", 0.67 );
                        }
                    }
                }
            ]
        }

        Interaction //-------------------------------------------------------------- YUGURE_SYNTHS
        {
            id:         interaction_synth_1
            path:       "/woodpath/jomon/interactions/palmsynth-1"
            title:      "Accompagnements (1)"
            module:     "quarre/JomonPalm.qml"

            description: "Approchez et maintenez la paume de votre main à quelques centimètres
 de l'écran pour produire du son, retirez-la pour le faire disparaître."

            property bool sample: false

            mappings: QuMapping
            {
                source: "/modules/jpalm/near"
                expression: function(v) {

                    if      ( v  && interaction_synth_1.sample ) ysynths.play(0);
                    else if ( v && !interaction_synth_1.sample ) ysynths.play(1);
                    else
                    {
                        ysynths.stop(0);
                        ysynths.stop(1);
                        interaction_synth_1.sample = !interaction_synth_1.sample;
                    }
                }
            }
        }

        Interaction
        {
            id:         interaction_synth_2
            path:       "/woodpath/jomon/interactions/palmsynth-2"
            title:      "Accompagnements (1)"
            module:     "quarre/JomonPalmZ.qml"

            description: "Approchez et maintenez la paume de votre main à quelques centimètres
 de l'écran pour produire du son, retirez-la pour le faire disparaître."

            property bool sample: false

            mappings:
            [
                QuMapping
                {
                    source: "/modules/jpalm/near"
                    expression: function(v) {

                        if      ( v  && interaction_synth_2.sample ) ysynths_2.play(0);
                        else if ( v && !interaction_synth_2.sample ) ysynths_2.play(1);
                        else
                        {
                            ysynths_2.stop(0);
                            ysynths_2.stop(1);
                            interaction_synth_2.sample = !interaction_synth_2.sample;
                        }
                    }
                },

                QuMapping
                {
                    source: "/modules/zrotation/position2D"
                    expression: function(v) {
                        ysynths_2_source.position   = Qt.vector3d(v[0], v[1], 0.5);
                    }
                }

            ]
        }

        Interaction //-------------------------------------------------------------------------- JOMON_STR_1
        {
            id:     interaction_strings_1
            path:   "/woodpath/jomon/interactions/strings-1"
            title:  "Cordes, duo déclenchement (1)"
            module:  "quarre/Strings.qml"

            description: "Frottez les cordes avec votre doigt au fur et à mesure de leur apparition."

            onInteractionBegin:
            {
                interaction_strings_1.owners.forEach(function(owner) {
                    var value = jomon_score.score[0]["notes"].length;
                    owner.remote.sendMessage("/modules/strings/display", value, true)})
            }

            mappings: QuMapping
            {
                source: "/modules/strings/trigger"
                expression: function(v) {
                    functions.processScoreIncrement( jomon_score,
                                interaction_strings_1,
                                interaction_strings_2,
                                instruments.kaivo_1 );
                }
            }
        }

        Interaction //-------------------------------------------------------------------------- JOMON_STR_2
        {
            id:     interaction_strings_2
            path:   "/woodpath/jomon/interactions/strings-2"
            title:  "Cordes, duo déclenchement (2)"
            module: "quarre/Strings.qml"

            description: "Frottez les cordes avec votre doigt au fur et à mesure de leur apparition."

            onInteractionBegin:
            {
                interaction_strings_2.owners.forEach(function(owner) {
                    var value = jomon_score.score[0]["notes"].length;
                    owner.remote.sendMessage("/modules/strings/display", value, true)})
            }

            mappings: QuMapping
            {
                source: "/modules/strings/trigger"
                expression: function(v) {
                    functions.processScoreIncrement( jomon_score,
                                interaction_strings_2,
                                interaction_strings_1,
                                instruments.kaivo_1 );
                }
            }
        }

        Interaction //-------------------------------------------------------------------------- SYNTH_SPAT
        {
            id:     interaction_synth_spat
            path:   "/woodpath/jomon/interactions/synth-spat"
            title:  "Synthétiseurs, mise en espace"
            module: "basics/ZRotation.qml"

            description: "Orientez votre appareil horizontalement,
 a 360 degrés autour de vous pour déplacer le son des synthétiseurs dans l'espace."

            mappings: QuMapping
            {
                source: "/modules/xytouch/position2D"
                expression: function(v) {
                    jsynths_source.left.position  = Qt.vector3d(v[0], v[1], 0.5);
                    jsynths_source.right.position = Qt.vector3d(1-v[0], 1-v[1], 0.5);
                }
            }
        }

        Interaction //-------------------------------------------------------------------------- MANGLER_1
        {
            id:     interaction_mangler_1
            path:   "/woodpath/jomon/interactions/mangler-1"
            title:  "Destructurations (1)"
            module: "quarre/JomonMangler.qml"

            description: "Parasitez, détruisez le signal"

//            mappings:
//            [
//                QuMapping { source: "/modules/mangler/resampler"
//                    expression: function(v) { mangler.badResampler = v; }
//                },

//                QuMapping { source: "/modules/mangler/thermonuclear"
//                    expression: function(v) { mangler.thermonuclear = v; }
//                },

//                QuMapping { source: "/modules/mangler/bitdepth"
//                    expression: function(v) { mangler.bitdepth = v; }
//                }
//            ]
        }

        Interaction //-------------------------------------------------------------------------- MANGLER_2
        {
            id:     interaction_mangler_2
            path:   "/woodpath/jomon/interactions/mangler-2"
            title:  "Destructurations (2)"
            module: "quarre/JomonMangler2.qml"

            description: "Parasitez, détruisez le signal"

//            mappings:
//            [
//                QuMapping
//                {
//                    source: "/modules/mangler/love"
//                    expression: function(v) { mangler.love = v; }
//                },

//                QuMapping
//                {
//                    source: "/modules/mangler/jive"
//                    expression: function(v) { mangler.jive = v; }
//                },

//                QuMapping
//                {
//                    source: "/modules/mangler/attitude"
//                    expression: function(v) { mangler.attitude = v; }
//                }
//            ]
        }
    }

    WPN114.Rooms
    {
        id: jomon_rooms
        active: false
        parentStream: audio_stream
        setup: rooms_setup

        WPN114.StereoSource //----------------------------------------- 1.CICADAS (1-2)
        {
            xspread: 0.2
            diffuse: 0.8
            fixed:  true

            exposePath: "/woodpath/jomon/audio/cicadas/source"

            WPN114.StreamSampler { id: cicadas; loop: true; xfade: 2000; attack: 3000
                exposePath: "/woodpath/jomon/audio/cicadas"
                path: "audio/woodpath/jomon/cicadas.wav" }
        }

        WPN114.StereoSource //----------------------------------------- 2.DMSYNTH (3-4)
        {
            xspread: 0.3
            diffuse: 0.5
            y: 0.9
            fixed:  true

            exposePath: "/woodpath/jomon/audio/dmsynth/source"

            WPN114.Sampler { id: dmsynth;
                exposePath: "/woodpath/jomon/audio/dmsynth"
                path: "audio/woodpath/jomon/dmsynth.wav"

//                WPN114.Mangler { id: mangler }
            }
        }

        WPN114.StereoSource //----------------------------------------- 3.LEAVES (5-6)
        {
            yspread: 0.25
            diffuse: 0.8
            fixed: true

            exposePath: "/woodpath/jomon/audio/leaves/source"

            WPN114.StreamSampler { id: leaves; loop: true; xfade: 2000
                exposePath: "/woodpath/jomon/audio/leaves"
                path: "audio/woodpath/jomon/leaves.wav" }
        }

        WPN114.StereoSource //----------------------------------------- 4.FSYNTHS (7-8)
        {
            exposePath: "/woodpath/jomon/audio/fsynths/source"

            WPN114.StreamSampler { id: fsynths;
                exposePath: "/woodpath/jomon/audio/fsynths"
                path: "audio/woodpath/jomon/fsynths.wav" }
        }

        WPN114.StereoSource //----------------------------------------- 5.YSYNTHS (9-10)
        {
            xspread: 0.3
            diffuse: 0.3
            y: 0.1
            fixed:  true
            exposePath: "/woodpath/jomon/audio/ysynths-1/source"

            WPN114.MultiSampler { id: ysynths;
                exposePath: "/woodpath/jomon/audio/ysynths-1"
                path: "audio/woodpath/jomon/ysynths-1" }
        }

        WPN114.StereoSource //----------------------------------------- 5.YSYNTHS (9-10)
        {
            id: ysynths_2_source

            xspread: 0.3
            diffuse: 0.3
            y: 0.1
            fixed:  true
            exposePath: "/woodpath/jomon/audio/ysynths-2/source"

            WPN114.MultiSampler { id: ysynths_2;
                exposePath: "/woodpath/jomon/audio/ysynths-2"
                path: "audio/woodpath/jomon/ysynths-2" }
        }

        WPN114.StereoSource //----------------------------------------- 5.YSYNTHS (9-10)
        {
            id: jsynths_source
            xspread: 0.3
            diffuse: 0.3
            y: 0.1
            fixed:  true
            exposePath: "/woodpath/jomon/audio/jsynths/source"

            WPN114.MultiSampler { id: jsynths;
                exposePath: "/woodpath/jomon/audio/jsynths"
                path: "audio/woodpath/jomon/jsynths" }
        }

        WPN114.MonoSource //----------------------------------------- 6.OWL_1 (11-12)
        {
            position: Qt.vector3d(0.3, 0.4, 0.5)
            fixed:  true

            exposePath: "/woodpath/jomon/audio/owl1/source"

            WPN114.Sampler { id: owl1; loop: true; xfade: 2000
                exposePath: "/woodpath/jomon/audio/owl1"
                path: "audio/woodpath/jomon/owl1.wav" }
        }

        WPN114.MonoSource //----------------------------------------- 7.OWL_2 (13-14)
        {
            position: Qt.vector3d(0.15, 0.05, 0.5)
            fixed: true

            exposePath: "/woodpath/jomon/audio/owl2/source"

            WPN114.Sampler { id: owl2; loop: true; xfade: 2000
                exposePath: "/woodpath/jomon/audio/owl2"
                path: "audio/woodpath/jomon/owl2.wav" }
        }

        WPN114.MonoSource //----------------------------------------- 8.OWL_3 (15-16)
        {
            position: Qt.vector3d(0.95, 0.5, 0.5)
            fixed: true

            exposePath: "/woodpath/jomon/audio/owl3/source"

            WPN114.Sampler { id: owl3; loop: true; xfade: 2000
                exposePath: "/woodpath/jomon/audio/owl3"
                path: "audio/woodpath/jomon/owl3.wav" }
        }

        WPN114.MonoSource //----------------------------------------- 9.OWL_4 (17-18)
        {
            position: Qt.vector3d(0.05, 0.5, 0.5)
            fixed: true

            exposePath: "/woodpath/jomon/audio/owl4/source"

            WPN114.Sampler { id: owl4; loop: true; xfade: 2000
                exposePath: "/woodpath/jomon/audio/owl4"
                path: "audio/woodpath/jomon/owl4.wav" }
        }
    }
}
