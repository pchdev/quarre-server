import QtQuick 2.0
import WPN114 1.0 as WPN114

Item
{
    WPN114.AudioStream
    {
        id:             audio_stream
        outDevice:      "Scarlett 2i2 USB"
        sampleRate:     44100
        blockSize:      512
    }
}
