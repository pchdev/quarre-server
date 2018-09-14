import QtQuick 2.0
import "items"

Rectangle
{
    anchors.fill: parent
    color: "transparent"

    property var intervals: [
        3000,
        5000,
        8000,
        8000,
        8000,
        8000,
        8000,
        8000,
        8000,
        8000,
        8000,
        8000,
        8000,
    ]

    property var texts: [
        "Bienvenue",
        "Cette première interaction vise à vous présenter le fonctionnement de l'installation",
        "La partie haute de l'affichage (en vert) vous informe de la prochaine interaction qui vous sera addressée",
        "Elle comporte un compte-à-rebours ainsi qu'un titre et une description de la prochaine interaction",
        "Vous n'avez donc pour le moment rien à faire, sinon attendre, écouter, et anticiper la prochaine interaction",
        "La partie basse de l'affichage contiendra les modules avec lesquels vous pourrez interagir",
        "Pour le moment, elle est grisée : vous ne pouvez pas encore manipuler les modules d'interaction",
        "Lorsque l'interaction devient active, l'affichage du haut devient rouge",
        "Un nouveau compte-à-rebours s'affiche, c'est le temps estimé qu'il vous reste avant la fin de l'interaction",
        "Vous pouvez maintenant manipuler le slider ci-dessous, qui est ici sans effet",
        "Vous aurez des interactions tactiles, comme celle-ci, mais aussi des interactions gestuelles",
        "Vous devrez tourner, pivoter votre appareil, ou bien exécuter certains gestes",
        "Bon jeu, et bonne écoute"
    ]

    Text //------------------------------------------------ TUTORIAL_TEXT
    {
        id:         tutorial_text
        y:          parent.height * 0.025
        text:       ""
        color:      "lime"
        height:     parent.height*0.4
        width:      parent.width * 0.9
        wrapMode:   Text.WordWrap

        horizontalAlignment:        Text.AlignHCenter
        verticalAlignment:          Text.AlignVCenter
        anchors.horizontalCenter:   parent.horizontalCenter
        font.pointSize:             22 * root.fontRatio
        font.family:                font_lato_light.name
        antialiasing:               true
    }

    QuarreSlider
    {
        name: "didacticiel"
        y: parent.height * 0.7
    }

    onEnabledChanged: timer.start();

    Timer
    {
        id: timer
        property int count: 0
        interval: 3000
        repeat: true
        triggeredOnStart: true

        onTriggered:
        {
            if ( count > 12 ) timer.stop();
            interval = intervals[count];
            tutorial_text.text = texts[count];

            if ( count === 7 ) tutorial_text.color = "red";
            count++;
        }
    }
}
