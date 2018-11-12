import QtQuick 2.0
import "../engine"

Item
{
    id: root

    property int xroads_result: 0

    property Interaction tutorial: Interaction // =============================== INTRODUCTION_TUTORIAL
    {
        title: "Didacticiel"
        module: "quarre/Tutorial.qml"
        broadcast: true
        description: "Présentation du fonctionnement global de l'application"
    }

    property Interaction xroads: Interaction // =============================== INTRODUCTION_XROADS
    {
        title: "Croisée des chemins"
        module: "quarre/Vote.qml"
        broadcast: true
        description: "Sélectionnez l'un des symboles présentés ci-dessous. Ce choix influencera le déroulement du scénario."

        onInteractionBegin:
        {
            owners.forEach(function(owner) {
                if ( owner.connected )
                     owner.remote.listen("/modules/crossroads/selection");
            });
        }

        onInteractionEnd:
        {
            // parse selection for each connected client
            var res_zero = 0, res_one = 0, res_two = 0, total = 0;

            owners.forEach(function(owner) {
                if ( owner.connected )
                {
                    var res = owner.remote.value("/modules/crossroads/selection");
                    if ( res === 0 ) res_zero++;
                    else if ( res === 1 ) res_one++;
                    else if ( res === 2 ) res_two++;
                    owner.remote.ignore("/modules/crossroads/selection");
                }
            });

            if ( res_one > res_zero && res_one > res_two ) total = 0;
            else if ( res_two > res_zero && res_two > res_one ) total = 1;
            else total = Math.floor(Math.random()*2);

            root.xroads_result = total;
        }
    }
}
