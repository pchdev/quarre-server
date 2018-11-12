import QtQuick 2.0
import WPN114 1.0 as WPN114
import WPNPush 1.0 as Push

WPN114.PushDevice
{
    id: push

    property var scenes: [ ]
    property var currentScene

    Component.onCompleted:
    {
        push.lcdClearAll   ( )
        push.padGridClear  ( )
//        push.lcdDisplay    ( 0, 31, "WPN214" )

        push.lightButton( Push.CommandButtons.Play, Push.ButtonLightingMode.Dim)
        push.lightToggle( Push.ToggleRow.UPPER, 0, Push.ToggleLightingMode.RedDim );

        registerScene( scenario.introduction,   58, Push.PadColor.White )
        registerScene( scenario.wpn214,         50, Push.PadColor.Green)

        registerScene( scenario.woodpath.maaaet,  56, Push.PadColor.GrassGreen )
        registerScene( scenario.woodpath.carre,   48, Push.PadColor.DarkerGrassGreen)
        registerScene( scenario.woodpath.pando,   40, Push.PadColor.DarkestGrassGreen )
        registerScene( scenario.woodpath.vare,    32, Push.PadColor.BlueGreen)
        registerScene( scenario.woodpath.jomon,   24, Push.PadColor.Gold )

        registerScene( scenario.stonepath.cendres,        57, Push.PadColor.DarkestRed)
        registerScene( scenario.stonepath.diaclases,      49, Push.PadColor.DarkerRed )
        registerScene( scenario.stonepath.deidarabotchi,  41, Push.PadColor.DarkestPurplishBlue )
        registerScene( scenario.stonepath.markhor,        33, Push.PadColor.BlueSteel )
        registerScene( scenario.stonepath.ammon,          25, Push.PadColor.Gold )
    }

    Component.onDestruction:
    {
        push.lcdClearAll  ( )
        push.padGridClear ( )
    }

    onPlay:
    {
        scenario.start();
        push.lightButton( Push.CommandButtons.Play, Push.ButtonLightingMode.FullBlinkSlow)
    }

    function registerScene( scene, index, color )
    {
        var component = Qt.createComponent("PushScene.qml")
        var pscene = component.createObject(push, { "pcolor": color, "scene": scene, "index": index })
        scenes.push( pscene );
    }

    function notifyNewConnection(index)
    {
        push.lightToggle( Push.ToggleRow.Lower, index, Push.ToggleLightingMode.YellowDim )
    }

    function notifyDisconnection(index)
    {
        push.lightToggle( Push.ToggleRow.Lower, index, Push.ToggleLightingMode.RedDim )
    }

    function notifySceneStart(scene)
    {
        currentScene = scene;
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

    onCurrentSceneChanged:
    {

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
             push.lightToggle(Push.ToggleRow.Upper, 0, Push.ToggleLightingMode.GreenDim )
            audio_stream.active = true;
        }
    }

    onKnob:
    {

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
