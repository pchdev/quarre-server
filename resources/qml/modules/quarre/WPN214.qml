import QtQuick 2.0
import "items"

Rectangle
{
    anchors.fill: parent
    color: "transparent"

    property var texts: [
        "à la mémoire de Simone David...",
        "De grands remerciements à Nadine, Philippe, Vincent et Paule Cochard,",
        "à Jean-Michaël Celerier",
        "à François-Xavier Féron",
        "ainsi qu'à Thibaud Keller",
        "à toute l'équipe du SCRIME, de l'Arbre intégral et du CRNA pour leur soutien",
        "par ordre alphabétique :",
        "Julia Hanadi Al-Abed",
        "Ivan Angelus - BCDA",
        "Simon Archipoff",
        "Pascal Baltazar",
        "Julien Conan",
        "Laurent Davaille",
        "Myriam Desainte-Catherine",
        "Gaël Domenger",
        "Christian Faurens",
        "Donatien Garnier",
        "Antoine Hubineau",
        "Guzel Bretzel",
        "György et Isabelle Kurtag",
        "Arthur Liefhooghe",
        "Raphaël Marczak",
        "Eric Meaux",
        "Annick Mersier",
        "Edgar Nicouleau",
        "Pierre-Alain Pous",
        "Jean-Michel Rivet",
        "Antoine Villeret",
        "Nicolas Vuaille",
        "Merci pour votre participation...",
        "La suite prochainement sur https://www.facebook.com/wpn214",
        "et sur https://www.facebook.com/quarremusic",
    ]

    Text //------------------------------------------------ TUTORIAL_TEXT
    {
        id:             wpn_text
        text:           ""
        color:          "white"
        wrapMode:       Text.WordWrap

        width: parent*0.9
        y: parent.height * 0.4
        anchors.fill: parent

        horizontalAlignment:        Text.AlignHCenter
        verticalAlignment:          Text.AlignVCenter
        font.pointSize:             22 * root.fontRatio
        font.family:                font_lato_light.name
        antialiasing:               true
    }

    onEnabledChanged:
        if ( enabled ) fade_in.start();

    NumberAnimation
    {
        property int count: 0
        id: fade_in
        target: wpn_text
        property: "opacity"
        from: 0.0
        to: 1.0
        duration: 2000

        onStarted:
        {
            if ( count === texts.length )
            { pause(); return; }
            wpn_text.text = texts[count];
            count++;
        }

        onStopped:
            pause_animation.start();
    }

    PauseAnimation
    {
        id: pause_animation
        duration: 4000
        onStopped: fade_out.start()
    }

    NumberAnimation
    {
        id: fade_out
        target: wpn_text
        property: "opacity"
        from: 1.0
        to: 0.0
        duration: 2000

        onStopped: fade_in.start();
    }
}
