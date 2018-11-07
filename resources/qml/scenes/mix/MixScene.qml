import QtQuick 2.0
import WPN114 1.0 as WPN114
import "../.."
import ".."

Item
{
    id: root

    WPN114.TimeNode
    {
        id: mix_scenario
        exposePath: "/mix/scenario"
        source: audio_stream
        duration: -1

        onEnd:
        {
            query_server.savePreset("quarre-angouleme.json",
                [ "dBlevel", "position", "diffuse" ]);
        }

        InteractionExecutor
        {
            target: introduction_mix_interaction
            exposePath: "/mix/introduction"

            onStart:  introduction.rooms.active = true;
            onEnd:    introduction.rooms.active = false;
        }

        InteractionExecutor
        {
            target: maaaet_mix_interaction
            exposePath: "/mix/woodpath/maaaet"

            onStart:  woodpath.maaaet.rooms.active = true;
            onEnd:    woodpath.maaaet.rooms.active = false;
        }

        InteractionExecutor
        {
            target:     carre_mix_interaction
            exposePath: "/mix/woodpath/carre"

            onStart:  woodpath.carre.rooms.active = true;
            onEnd:    woodpath.carre.rooms.active = false;
        }

        InteractionExecutor
        {
            target:     pando_mix_interaction
            exposePath: "/mix/woodpath/pando"

            onStart:  woodpath.pando.rooms.active = true;
            onEnd:    woodpath.pando.rooms.active = false;
        }

        InteractionExecutor
        {
            target:     vare_mix_interaction
            exposePath: "/mix/woodpath/vare"

            onStart:  woodpath.vare.rooms.active = true;
            onEnd:    woodpath.vare.rooms.active = false;
        }
    }

    MixInteraction
    {
        id:      introduction_mix_interaction
        title:   "Introduction scene mix"

        target:  "/introduction/audio"
        path:    "/mix/interactions/introduction"
        module:  "quarre/mix/IntroductionMixview.qml"
    }

    MixInteraction
    {
        id:       cendres_mix_interaction
        title:   "Cendres scene mix"

        target:   "/stonepath/cendres/audio"
        path:     "/mix/interactions/stonepath/cendres"
        module:   "quarre/mix/CendresMixview.qml"
    }

    MixInteraction
    {
        id:      diaclases_mix_interaction
        target:  "/stonepath/diaclases/audio"
        path:    "/mix/interactions/stonepath/diaclases"
    }

    MixInteraction
    {
        id:      deidarabotchi_mix_interaction
        target:  "/stonepath/deidarabotchi/audio"
        path:    "/mix/interactions/stonepath/deidarabotchi"
    }

    MixInteraction
    {
        id:      markhor_mix_interaction
        target:  "/stonepath/markhor/audio"
        path:    "/mix/interactions/stonepath/markhor"
    }

    MixInteraction
    {
        id:      ammon_mix_interaction
        target:  "/stonepath/ammon/audio"
        path:    "/mix/interactions/stonepath/ammon"
    }

    MixInteraction
    {
        id:      maaaet_mix_interaction
        target:  "/woodpath/maaaet/audio"
        path:    "/mix/interactions/woodpath/maaaet"
    }

    MixInteraction
    {
        id:      carre_mix_interaction
        target:  "/woodpath/carre/audio"
        path:    "/mix/interactions/woodpath/carre"
    }

    MixInteraction
    {
        id:      pando_mix_interaction
        target:  "/woodpath/pando/audio"
        path:    "/mix/interactions/woodpath/pando"
    }

    MixInteraction
    {
        id:      vare_mix_interaction
        target:  "/woodpath/vare/audio"
        path:    "/mix/interactions/woodpath/vare"
    }

    MixInteraction
    {
        id:      jomon_mix_interaction
        target:  "/woodpath/jomon/audio"
        path:    "/mix/interactions/woodpath/jomon"
    }
}
