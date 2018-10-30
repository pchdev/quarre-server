import QtQuick 2.0
import ".."
import "../.."

Item
{
    Item //------------------------------------------------------------------------------ INTERACTIONS
    {
        id: interactions

        Interaction //------------------------------------------------- NIWOOD-LOW
        {
            // low smallbells
            title: "Cloches primitives, déclenchement (1)"
        }

        Interaction //------------------------------------------------- NIWOOD-HI
        {
            // hi-smallbells
            title: "Cloches primitives, déclenchement (2)"
        }

        Interaction //------------------------------------------------- NIWOOD-TIMBRE
        {
            // niwood timbre (brightness 0-0.5, position, body pitch)
            title: "Cloches primitives, timbre (1)"
        }

        Interaction //------------------------------------------------- INSECTS
        {
            // add and erase insects
            title: "Insectes, déclenchemen"
        }

    }

}
