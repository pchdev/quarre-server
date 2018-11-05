import QtQuick 2.9
import QtQuick.Controls 2.0
import QtQuick.Window 2.2
import WPN114 1.0 as WPN114

import "scenes"
import "views"

// TODO: Pink Noise setup testing module
// TODO: Mixing module for every scene (including forks)
// TODO: Spatialization for every scene
// TODO: volume and spatialization presets
// TODO: FLAC audio

// WRITING: väre rhythmic arrangement
// WRITING: jomon sugi
// WRITING: carre soundscape

Rectangle
{
    id: application
    objectName: "quarre-root"

    visible: true
    width: 640
    height: 480

    WPN114.FolderNode //------------------------------------------------------------- NETSERVER
    {
        device: module_server
        recursive: true
        folderPath: "/Users/pchd/Repositories/quarre-server/resources/qml/modules"
        path: "/modules"
        filters: ["*.qml"]
    }

    WPN114.OSCQueryServer
    {
        id: module_server
        name: "quarre-modules"
        tcpPort: 8576
        udpPort: 4132
    }

    WPN114.OSCQueryServer
    {
        id: query_server
        singleDevice: true
        name: "quarre-server"
        tcpPort: 5678
        udpPort: 1234       

        Component.onCompleted:
        {
            mainview.tree.model = query_server.nodeTree()
//            query_server.loadPreset("quarre-angouleme.json");
        }
    }

    ClientManager   { id: client_manager; maxClients: 4 }
    Functions       { id: functions }
    Scenario        { id: scenario }
    MainView        { id: mainview }

    // AUDIO LEVEL/VERB/SPACE PRESETS -------------------------------------

    WPN114.Node
    {
        path: "/global/audio/presets/save"
        type: WPN114.Type.String

//        onValueReceived: query_server.savePreset(newValue)
    }

    WPN114.Node
    {
        path: "/global/audio/presets/load"
        type: WPN114.Type.String

//        onValueReceived: query_server.loadPreset(newValue)
    }

    WPN114.RoomSetup
    {
        id: rooms_setup;

        // stereo tests
//        WPN114.SpeakerPair { xspread: 0.25; y: 0.5; influence: 0.5 }

        // octophonic ring setup for quarrè-angoulême
        WPN114.SpeakerRing { nspeakers: 8; offset: Math.PI/8; influence: 0.55 }

        // scrime 3dôme
//        WPN114.SpeakerRing { nspeakers: 4; offset: Math.PI/8; influence: 0.5; elevation: 0.99 }
//        WPN114.SpeakerRing { nspeakers: 6; offset: Math.PI/8; influence: 0.5; elevation: 0.66 }
//        WPN114.SpeakerRing { nspeakers: 8; offset: Math.PI/8; influence: 0.5; elevation: 0.33 }
    }

    WPN114.AudioStream //------------------------------------------------------------- AUDIO
    {
        id:             audio_stream

        outDevice:      "Scarlett 18i20 USB"
        numOutputs:     8

//        outDevice:      "Soundflower (64ch)"
//        numOutputs:     8

        sampleRate:     44100
        blockSize:      512
        active:         false

        inserts: WPN114.PeakRMS
        {
            id:      vu_master
            source:  audio_stream
            active:  true

            onRms:   mainview.vumeters.processRms  ( value )
            onPeak:  mainview.vumeters.processPeak ( value )

            refreshRate: 15//Hz
        }

        Component.onCompleted: scenario.initialize();

        onActiveChanged:
        {
            // this should be implicit
            if ( active ) start();
            else stop();
        }

        WPN114.Node on dBlevel { path: "/global/audio/master/dBlevel" }
        WPN114.Node on active { path: "/global/audio/master/active" }
        WPN114.Node on mute { path: "/global/audio/master/muted" }
    }
}
