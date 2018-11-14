import QtQuick 2.0
import WPN114 1.0 as WPN114
import "../../engine"
import ".."

Scene
{
    id: root
    property alias cicadas: cicadas

    endShutdown: false
    JomonScore { id: jomon_score }

    scenario: WPN114.TimeNode
    {
        source:       audiostream
        parentNode:   parent.scenario
        duration:     WPN114.TimeNode.Infinite

        onStart:
        {
            instruments.rooms.active         = true;
            instruments.kaivo_1.active       = true;
            instruments.kaivo_1.dBlevel      = -3;
            instruments.k1_fork_921.dBlevel  = -5;
            instruments.k1_fork_amp.active   = true;
            instruments.k1_fork_amp.dBlevel  = -9;

            effects.amplitube.active = true;
            instruments.kaivo_2.active  = false;
            cicadas.play();
        }

        onEnd:
        {
            instruments.kaivo_1.active       = false
            instruments.k1_fork_amp.active   = false
            effects.amplitube.active         = false
        }

        // ======================================================================= DAWN

        InteractionExecutor
        {
            id:         akatsuki
            target:     interaction_strings_1
            date:       sec( 10 )
            countdown:  sec( 10 )
            length:     min( 5 )

            onStart:
            {
                instruments.kaivo_1.setPreset( instruments.jguitar );

                functions.setTimeout(function() {
                    instruments.kaivo_1.set( "env1_attack", 0.25 )
                }, 3000 );
            }

            endExpression: jomon_score.index === 18;

            InteractionExecutor
            {
                target:      interaction_strings_2
                countdown:   sec( 10 )
                length:      min( 5 )
            }

            WPN114.TimeNode
            {
                startExpression: jomon_score.index === 9;
                onStart:
                {
                    leaves.play();
                    instruments.kaivo_1.set("env1_attack", 0.5);
                }
            }

            WPN114.TimeNode
            {
                startExpression: jomon_score.index === 14;
                onStart: instruments.kaivo_1.set( "env1_attack", 0.25 );
            }
        }

        WPN114.Automation
        {
            after: akatsuki
            target: instruments.kaivo_1
            property: "level"
            duration: sec( 10 )
            from: instruments.kaivo_1.level
            to: 0;

            onEnd:
            {
                jsynths_1.stop();
                jsynths_2.stop();
            }
        }

        // =================================================================== FINAL

        WPN114.TimeNode
        {
            id: jomon_scenario
            after: akatsuki
            date: sec( 5 )
            duration: min( 2.30 )

            onStart:
            {
                dmsynth.play();
                fsynths.play();

                instruments.kaivo_1.active = false;
                instruments.kaivo_2.active = false;
            }

            WPN114.Automation
            {
                target: mangler
                property: "wet"
                duration: sec( 5 )
                from: 0; to: 0.75;

                WPN114.Automation
                {
                    target: mangler
                    property: "dry"
                    duration: sec( 37 )
                    from: mangler.dry; to: 0.65;
                }
            }

            InteractionExecutor
            {
                id:         mangler_ex
                target:     interaction_mangler_1
                date:       sec( 37 )
                countdown:  sec( 15 )
                length:     min( 1.20 )

                InteractionExecutor
                {
                    target:     interaction_mangler_2
                    countdown:  sec( 15 )
                    length:     min( 1.20 )

                    InteractionExecutor
                    {
                        target:     interaction_mangler_3
                        countdown:  sec( 15 )
                        length:     min( 1.20 )

                        InteractionExecutor
                        {
                            target:     interaction_mangler_4
                            countdown:  sec( 15 )
                            length:     min( 1.20 )
                        }
                    }
                }
            }
        }

        WPN114.Automation
        {
            after: mangler_ex
            target: leaves
            property: "level"
            from: leaves.level; to: 0

            duration: sec( 20 )

            onEnd: leaves.stop()
        }

        WPN114.Automation // FADE_OUT: keep cicadas active
        {
            after:      jomon_scenario
            target:     rooms
            property:   "level"

            from: rooms.level; to: 0.25
            duration: sec( 30 )

            onEnd: scenario.end()
        }
    }

    Item //-------------------------------------------------------------------- INTERACTIONS
    {
        id: interactions

        Interaction //-------------------------------------------------------------------------- RAINBELLS
        {
            id:     interaction_rainbells
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

        Interaction //-------------------------------------------------------------------------- JOMON_STR_1
        {
            id:     interaction_strings_1
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

                    var ndur = jomon_score.score[jomon_score.index]['duration'];

                    functions.processScoreIncrement( jomon_score,
                                                    interaction_strings_1,
                                                    interaction_strings_2,
                                                    instruments.kaivo_1, ndur/2 );

                    if ( jomon_score.index > 8 )
                    {
                        jsynths_2.play();
                        if ( jsynths_1.active ) jsynths_1.stop();
                    }
                }
            }
        }

        Interaction //-------------------------------------------------------------------------- JOMON_STR_2
        {
            id:     interaction_strings_2
            title:  "Cordes, duo déclenchement (2)"
            module: "quarre/Strings.qml"

            description: "Frottez les cordes avec votre doigt au fur et à mesure de leur apparition."

            mappings: QuMapping
            {
                source: "/modules/strings/trigger"
                expression: function(v) {

                    var ndur = jomon_score.score[jomon_score.index]['duration'];

                    functions.processScoreIncrement( jomon_score,
                                                    interaction_strings_2,
                                                    interaction_strings_1,
                                                    instruments.kaivo_1, ndur/2 );

                    if ( jomon_score.index > 8 )
                    {
                        jsynths_1.play();
                        if ( jsynths_1.active ) jsynths_2.stop();
                    }
                }
            }
        }

        Interaction //-------------------------------------------------------------------------- MANGLER_1
        {
            id:     interaction_mangler_1
            title:  "Destructurations (1)"
            module: "quarre/JomonMangler.qml"

            description: "Parasitez, détruisez le signal"

            // DRIVE: 0 - 1
            // CRUSH: 0 - 0.85
            // DWSP:  0 - 0.8

            mappings:
                [
                QuMapping { source: "/modules/mangler/drive"
                    expression: function(v) { mangler.set("Drive", v) }
                },

                QuMapping { source: "/modules/mangler/crush"
                    expression: function(v) { mangler.set("Crush", v) }
                },

                QuMapping { source: "/modules/mangler/resampler"
                    expression: function(v) { mangler.set("Downsamp", v) }
                }
            ]
        }

        Interaction //-------------------------------------------------------------------------- MANGLER_2
        {
            id:     interaction_mangler_2
            title:  "Destructurations (2)"
            module: "quarre/JomonMangler2.qml"

            description: "Parasitez, détruisez le signal"

            // FILTER: 0 - 1
            // RESFILTER: 0 - 1
            // FILTER-TYPE : 0 OR 1 (bool)

            mappings:
                [
                QuMapping
                {
                    source: "/modules/mangler/filter/freq"
                    expression: function(v) {
                        mangler.set("Lowpass Freq", v);
                        mangler.set("Hipass Freq", v);
                    }
                },

                QuMapping
                {
                    source: "/modules/mangler/filter/res"
                    expression: function(v) {
                        mangler.set("Lowpass Res", v);
                        mangler.set("Hipass Res", v);
                    }
                },

                QuMapping
                {
                    source: "/modules/mangler/filter/type"
                    expression: function(v) { mangler.set("Filter Type", v) }
                }
            ]
        }
        Interaction //-------------------------------------------------------------------------- MANGLER_2
        {
            id:     interaction_mangler_3
            title:  "Destructurations (3)"
            module: "quarre/JomonMangler3.qml"

            description: "Parasitez, détruisez le signal"

            // LFO-RATE: 0 - 1
            // LFO-WAVEFORM: 0 - 1
            // LFO-DRIVE: 0 - 1

            mappings:
                [
                QuMapping
                {
                    source: "/modules/mangler/lfo/rate"
                    expression: function(v) { mangler.set("LFO Free Rate", v) }
                },

                QuMapping
                {
                    source: "/modules/mangler/lfo/waveform"
                    expression: function(v) { mangler.set("LFO Waveform", v) }
                },

                QuMapping
                {
                    source: "/modules/mangler/lfo/drive"
                    expression: function(v) { mangler.set("Drive Mod Depth", v) }
                }
            ]
        }

        Interaction //-------------------------------------------------------------------------- MANGLER_2
        {
            id:     interaction_mangler_4
            title:  "Destructurations (4)"
            module: "quarre/JomonMangler4.qml"

            description: "Parasitez, détruisez le signal"

            // LFO-CRUSH : 0 - 1
            // LFO-DWSP: 0 - 1
            // LFO-FREQ: 0 - 1
            // LFO-RES: 0 - 1

            mappings:
                [
                QuMapping
                {
                    source: "/modules/mangler/lfo/crush"
                    expression: function(v) { mangler.set("Crush Mod Depth", v) }
                },

                QuMapping
                {
                    source: "/modules/mangler/lfo/resampler"
                    expression: function(v) { mangler.set("Downsamp Mod Depth", v) }
                },

                QuMapping
                {
                    source: "/modules/mangler/lfo/freq"
                    expression: function(v) { mangler.set("Filter Freq Mod Depth", v) }
                },

                QuMapping
                {
                    source: "/modules/mangler/lfo/res"
                    expression: function(v) { mangler.set("Filter Res Mod Depth", v) }
                }
            ]
        }
    }


    WPN114.StereoSource //----------------------------------------- 1.CICADAS (1-2)
    {
        parentStream: rooms
        xspread: 0.2
        diffuse: 0.8
        fixed:  true

        exposePath: fmt("audio/cicadas/source")

        WPN114.StreamSampler { id: cicadas;
            loop: true; xfade: 2000; attack: 3000
            exposePath: fmt("audio/cicadas")
            path: "audio/woodpath/jomon/cicadas.wav" }
    }

    WPN114.StereoSource //----------------------------------------- 2.DMSYNTH (3-4)
    {
        parentStream: rooms
        xspread: 0.3
        diffuse: 0.5
        y: 0.9
        fixed:  true

        exposePath: fmt("audio/dmsynth/source")

        WPN114.Sampler { id: dmsynth; dBlevel: -6
            attack: 1500
            exposePath: fmt("audio/dmsynth")
            path: "audio/woodpath/jomon/dmsynth.wav"

            WPN114.AudioPlugin
            {
                id: mangler
                property real dry: 0.6
                property real wet: 0.0

                onDryChanged: mangler.set("Dry", mangler.dry);
                onWetChanged: mangler.set("Wet", mangler.wet);

                exposePath: fmt("audio/krush")
                path: "/Library/Audio/Plug-Ins/VST/Krush.vst"
            }
        }
    }

    WPN114.StereoSource //----------------------------------------- 3.LEAVES (5-6)
    {
        parentStream: rooms
        yspread: 0.25
        diffuse: 0.2
        fixed: true

        exposePath: fmt("audio/leaves/source")

        WPN114.StreamSampler { id: leaves; dBlevel: -6
            loop: true; xfade: 2000;
            exposePath: fmt("audio/leaves")
            path: "audio/woodpath/jomon/leaves.wav"
            WPN114.Fork { target: effects.reverb; dBlevel: -9 }
        }
    }

    WPN114.StereoSource //----------------------------------------- 4.FSYNTHS (7-8)
    {
        parentStream: rooms
        xspread: 0.35
        diffuse: 0.2

        exposePath: fmt("audio/fsynths/source")

        WPN114.StreamSampler { id: fsynths; dBlevel: 0
            attack: 2000
            exposePath: fmt("audio/fsynths")
            path: "audio/woodpath/jomon/fsynths.wav" }
    }

    WPN114.StereoSource //----------------------------------------- 5.YSYNTHS (9-10)
    {
        id: jsynths_source
        parentStream: rooms

        xspread: 0.3
        diffuse: 0.3
        y: 0.1
        fixed:  true
        exposePath: fmt("audio/jsynths/source")

        WPN114.Sampler { id: jsynths_1; loop: true; xfade: 2000; release: 1000
            exposePath: fmt("audio/jsynths-1")
            path: "audio/woodpath/jomon/jsynths/jsynths-1.wav" }

        WPN114.Sampler { id: jsynths_2; loop: true; xfade: 2000; release: 1000
            exposePath: fmt("audio/jsynths-2")
            path: "audio/woodpath/jomon/jsynths/jsynths-2.wav" }
    }
}
