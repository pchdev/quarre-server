import QtQuick 2.9
import QtQuick.Controls 2.0
import QtQuick.Window 2.2
import WPN114 1.0 as WPN114

import "scenes"
import "views"
import "engine"
import "network"
import "control"

// TODO: volume and spatialization presets
// TODO: FLAC audio
// TODO: tempoclock
// TODO: MIDIFile reader

Rectangle
{
    id:         application
    visible:    true
    width:      640
    height:     480

    // ================================================================================== CORE

    NetworkManager   { id: net  }
    PresetsManager   { id: presets }
    Functions        { id: functions }
    Scenario         { id: main_scenario }
    MainView         { id: mainview }

    WPN114.RoomSetup //================================================================= ROOM_SETUP
    {
        id: roomsetup; // SCRIME: 3DDôme

        WPN114.SpeakerRing //---------------------------- UPPER_RING(4)
        {
            // radius: 1.565m
            // z: 0.423
            nspeakers: 4
            offset: Math.PI/4
            horizontalInfluence: 0.3
            verticalInfluence: 0.5
            elevation: 1
            radius: 0.33
        }

        WPN114.SpeakerRing //---------------------------- MIDDLE_RING(6)
        {
            // radius: 2.060m
            // z: 0.249
            nspeakers: 6
            offset: Math.PI/6
            horizontalInfluence: 0.4
            verticalInfluence: 0.5
            elevation: 0.5
            radius: 0.66
        }

        WPN114.SpeakerRing //---------------------------- LOWER_RING(8)
        {
            // radius: 2.829mm
            // z: -0.05
            nspeakers: 8
            offset: Math.PI/8
            horizontalInfluence: 0.707
            verticalInfluence: 0.5
            elevation: 0.0
            radius: 0.99
        }
    }

    WPN114.PinkAudio
    {
        nchannels: 18
        duration: 0.5
        stream: audiostream;
        path: "/utilities/tester"
    }

    WPN114.AudioStream //=============================================================== AUDIO
    {
        id:             audiostream

//        outDevice:      "Scarlett 18i20 USB"
        dBlevel:        0
        outDevice:      "Soundflower (64ch)"
        exposePath:     "/master"
        numOutputs:     46
        sampleRate:     44100
        blockSize:      512
        active:         false

        inserts:
        [
            WPN114.Downmix // ================================================ SUBWOOFER_DOWNMIX
            {
                // for subwoofers
                id: downmix

                numInputs: 20
                numOutputs: 20
                channels: [ 18, 19 ]
            },

//            WPN114.MasterLimiter //========================================= LIMITER
//            {
//                id: limiter
//                numInputs:  20
//                numOutputs: 20
//            },

            WPN114.PeakRMS // =============================================== VU_METER
            {
                id:      vu_master
                source:  audiostream
                active:  true

                numInputs:   20
                numOutputs:  20

                onRms:   mainview.vumeters.processRms  ( value )
                onPeak:  mainview.vumeters.processPeak ( value )

                refreshRate: 15 // Hz
            },

            WPN114.ChannelMapper //=========================================== OUT MAPPING
            {
                id: outmapper
                numInputs:  20
                numOutputs: 46

                map: [ 14, 15, 16, 17, 18, 19, 20, 21, // UFX-ADAT-1
                       22, 23, 24, 25, 26, 27, 28, 29, // UFX-ADAT-2
                       42, 43, 44, 45 ] // 800-ADAT-1
            }
        ]
    }
}
