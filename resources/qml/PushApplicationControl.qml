import QtQuick 2.0
import WPN114 1.0 as WPN114
import WPNPush 1.0 as Push

WPN114.PushDevice
{
    id: push

    property var scenes: [ ]

    Component.onCompleted:
    {
        push.lcd_clear      ( );
        push.padgrid_clear  ( );
        push.lcd_display    ( 0, 31, "WPN214" )

        push.light_button( Push.CommandButtons.Play, Push.ButtonLightingMode.DIM )
        push.light_toggle( Push.ToggleRow.UPPER, 0, Push.ToggleLightingMode.RED_DIM );

        registerScene( scenario.introduction,   58, Push.PadColor.WHITE )
        registerScene( scenario.wpn214,         50, Push.PadColor.GREEN )

        registerScene( scenario.woodpath.maaaet,  56, Push.PadColor.GRASS_GREEN )
        registerScene( scenario.woodpath.carre,   48, Push.PadColor.DARKER_GRASS_GREEN )
        registerScene( scenario.woodpath.pando,   40, Push.PadColor.DARKEST_GRASS_GREEN )
        registerScene( scenario.woodpath.vare,    32, Push.PadColor.BLUE_GREEN )
        registerScene( scenario.woodpath.jomon,   24, Push.PadColor.GOLD )

        registerScene( scenario.stonepath.cendres,        57, Push.PadColor.DARKEST_RED)
        registerScene( scenario.stonepath.diaclases,      49, Push.PadColor.DARKER_RED )
        registerScene( scenario.stonepath.deidarabotchi,  41, Push.PadColor.DARKEST_PURPLISH_BLUE )
        registerScene( scenario.stonepath.markhor,        33, Push.PadColor.BLUE_STEEL )
        registerScene( scenario.stonepath.ammon,          25, Push.PadColor.GOLD )
    }

    onPlay:
    {
        scenario.start();
        push.light_button( Push.CommandButtons.Play, Push.ButtonLightingMode.FULL_BLINK_SLOW)
    }

    function registerScene( scene, index, color )
    {
        var component = Qt.createComponent("PushScene.qml")
        var pscene = component.createObject(push, { "pcolor": color, "scene": scene, "index": index })
        scenes.push( pscene );
    }

    function notifyNewConnection(index)
    {
        push.light_toggle( Push.ToggleRow.LOWER, index, Push.ToggleLightingMode.YELLOW_DIM )
    }

    function notifyDisconnection(index)
    {
        push.light_toggle( Push.ToggleRow.LOWER, index, Push.ToggleLightingMode.RED_DIM )
    }

    function notifySceneStart(scene)
    {
        scenes.forEach(function(pscene){
            if ( pscene.scene === scene )
                 pscene.notifyStart();
        });
    }

    function notifySceneEnd(scene)
    {
        scenes.forEach(function(pscene){
            if ( pscene.scene === scene )
                 pscene.notifyEnd();
        });
    }

    onPadOn:
    {
        scenes.forEach(function(pscene){
            if ( pscene.index === idx )
                 pscene.play();
        });
    }

    onUpToggle:
    {
        if ( idx === 0 && value )
        {
             push.light_toggle(Push.ToggleRow.UPPER, 0, Push.ToggleLightingMode.GREEN_DIM )
            audio_stream.active = true;
        }
    }

    Connections //---------------------------------------------------------- SCENARIO_CONNECTIONS
    {
        target: scenario.stonepath.cendres
        onNext:
        {
            notifySceneEnd    ( scenario.stonepath.cendres )
            notifySceneStart  ( scenario.stonepath.diaclases )
        }
    }

    Connections
    {
        target: scenario.stonepath.diaclases
        onNext:
        {
            notifySceneEnd    ( scenario.stonepath.diaclases )
            notifySceneStart  ( scenario.stonepath.deidarabotchi )
        }
    }

    Connections
    {
        target: scenario.stonepath.deidarabotchi
        onEnd:
        {
            notifySceneEnd    ( scenario.stonepath.deidarabotchi )
            notifySceneStart  ( scenario.stonepath.markhor )
        }
    }

    Connections
    {
        target: scenario.stonepath.markhor
        onEnd:
        {
            notifySceneEnd    ( scenario.stonepath.markhor )
            notifySceneStart  ( scenario.stonepath.ammon )
        }
    }

    Connections
    {
        target: scenario.stonepath.ammon
        onEnd:
        {
            notifySceneEnd    ( scenario.stonepath.ammon )
            notifySceneStart  ( scenario.wpn214 )
        }
    }

    Connections // MAAAET TO CARRE
    {
        target: scenario.woodpath.maaaet
        onNext:
        {
            notifySceneEnd    ( scenario.woodpath.maaaet )
            notifySceneStart  ( scenario.woodpath.carre )
        }
    }

    Connections // CARRE TO PANDO
    {
        target: scenario.woodpath.carre
        onNext:
        {
            notifySceneEnd    ( scenario.woodpath.carre )
            notifySceneStart  ( scenario.woodpath.pando )
        }
    }

    Connections // PANDO TO VARE
    {
        target: scenario.woodpath.pando
        onEnd:
        {
            notifySceneEnd    ( scenario.woodpath.pando)
            notifySceneStart  ( scenario.woodpath.vare )
        }
    }

    Connections // VARE TO JOMON
    {
        target: scenario.woodpath.vare
        onNext:
        {
            notifySceneEnd    ( scenario.woodpath.vare )
            notifySceneStart  ( scenario.woodpath.jomon )
        }
    }

    Connections // JOMON TO WOODPATH END
    {
        target: scenario.woodpath.jomon
        onEnd:
        {
            notifySceneEnd    ( scenario.woodpath.jomon )
            notifySceneStart  ( scenario.wpn214 )
        }
    }

}
