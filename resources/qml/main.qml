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

Rectangle
{
    id: application
    objectName: "quarre-root"

    visible: true
    width: 640
    height: 480

    PushApplicationControl { id: pushctl }

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
            mainview.tree.model = query_server.nodeTree()
    }

    ClientManager   { id: client_manager; maxClients: 4 }
    Functions       { id: functions }
    Scenario        { id: scenario }
    MainView        { id: mainview }

    WPN114.Node //----------------------------------------------------------------------- PRESETS
    {
        path: "/presets/save"
        type: WPN114.Type.String

        onValueReceived:
        {
            var nodes = query_server.collectNodes("dBlevel")
            nodes.forEach(function(node) {
                node.defaultValue = node.value;
            });

            query_server.savePreset(newValue, [ "dBlevel" ], [ "DEFAULT_VALUE" ])
        }
    }

    WPN114.Node
    {
        path: "/presets/load"
        type: WPN114.Type.String
        onValueReceived:
        {
            query_server.loadPreset(newValue);

            var nodes = query_server.collectNodes("dBlevel")
            nodes.forEach(function(node) {
                node.value = node.defaultValue;
            });
        }
    }

    WPN114.RoomSetup //---------------------------------------------------------------- ROOM_SETUP
    {
        id: rooms_setup;

        // octophonic ring setup for quarrè-angoulême
        WPN114.SpeakerRing { nspeakers: 8; offset: -Math.PI/8; influence: 0.707 }
    }

    WPN114.AudioStream //------------------------------------------------------------- AUDIO
    {
        id:             audio_stream

        outDevice:      "Scarlett 18i20 USB"
        exposePath:     "/master"
        numOutputs:     8
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

            refreshRate: 15 // Hz
        }
    }
}
