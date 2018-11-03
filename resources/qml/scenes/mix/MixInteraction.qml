import QtQuick 2.0
import "../.."

Interaction
{
    property string scene;
    property string target;

    countdown:   5
    length:     -1

    onInteractionBegin:
    {
        owners.forEach(function(owner) {
            owner.remote.listenAll(target);
            owner.remote.mapAll(query_server, target);
        })
    }

    onInteractionEnd:
    {
        owners.forEach(function(owner) {
            owner.remote.ignoreAll(target);
            owner.remote.unmap(query_server, target, target);
        });
    }
}
