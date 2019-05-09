import QtQuick 2.0

GestureViewer
{
    id: root;

    title:          "Agiter l'appareil"
    gestures:       [ "QtSensors.shake" ]

    description:    "Agiter fermement votre appareil de gauche à droite et inversement, de manière sèche et rapide"
    anchors.fill:   parent

    Connections
    {
        target: gesture_manager.backend
        onDetected:
        {
            server.get("/gestures/shake/trigger").value = 1;
            trigger_animation.running = true
        }
    }
}
