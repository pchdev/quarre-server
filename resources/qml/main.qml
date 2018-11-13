import QtQuick 2.9
import QtQuick.Controls 2.0
import QtQuick.Window 2.2
import WPN114 1.0 as WPN114

import "scenes"
import "views"
import "engine"
import "network"
import "control"

// TODO: Pink Noise setup testing module
// TODO: Mixing module for every scene (including forks)
// TODO: Spatialization for every scene
// TODO: volume and spatialization presets
// TODO: FLAC audio

Rectangle
{
    id:         application
    visible:    true
    width:      640
    height:     480

    // ================================================================================== CORE

    NetworkManager          { id: net  }
    PresetsManager          { id: presets }
    Functions               { id: functions }
    Scenario                { id: main_scenario }
    MainView                { id: mainview }

//    PushApplicationControl  { id: push }

    WPN114.RoomSetup //================================================================= ROOM_SETUP
    {
        id: roomsetup;
        // octophonic ring setup for quarrè-angoulême
        WPN114.SpeakerRing { nspeakers: 8; offset: -Math.PI/8; influence: 0.707 }
    }

    WPN114.AudioStream //=============================================================== AUDIO
    {
        id:             audiostream

        outDevice:      "Scarlett 18i20 USB"
        exposePath:     "/master"
        numOutputs:     8
        sampleRate:     44100
        blockSize:      512
        active:         false

        inserts: WPN114.PeakRMS
        {
            id:      vu_master
            source:  audiostream
            active:  true

            onRms:   mainview.vumeters.processRms  ( value )
            onPeak:  mainview.vumeters.processPeak ( value )

            refreshRate: 15 // Hz
        }
    }
}
