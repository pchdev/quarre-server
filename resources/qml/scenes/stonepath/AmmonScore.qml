import QtQuick 2.0
import WPN114 1.0 as WPN114

Item
{
    property var score: [

        { notes: [55, 57], velocity: [40, 40], times: [0.0, 25], duration: 3000 },
        { notes: [58], velocity: [40], times: [0.0], duration: 1000 },
        { notes: [54, 57], velocity: [40, 40], times: [0.0, 25], duration: 3000 },

        { notes: [59], velocity: [40], times: [0.0], duration: 1000 },

        { notes: [55, 57], velocity: [40, 40], times: [0.0, 25], duration: 3000 },
        { notes: [58], velocity: [40], times: [0.0], duration: 1000 },
        { notes: [54, 57], velocity: [40, 40], times: [0.0, 25], duration: 3000 },

        { notes: [59], velocity: [40], times: [0.0], duration: 1000 },
        { notes: [60], velocity: [40], times: [0.0], duration: 1000 },
        { notes: [59], velocity: [40], times: [0.0], duration: 1000 },

        { notes: [55, 57], velocity: [40, 40], times: [0.0, 25], duration: 3000 },
        { notes: [59], velocity: [40], times: [0.0], duration: 1000 },
        { notes: [60], velocity: [40], times: [0.0], duration: 1000 },
        { notes: [61], velocity: [40], times: [0.0], duration: 1000 },
        { notes: [63], velocity: [40], times: [0.0], duration: 1000 },
        { notes: [61], velocity: [40], times: [0.0], duration: 1000 },
        { notes: [57, 61], velocity: [40, 40], times: [0.0, 25], duration: 3000 },

        { notes: [55, 57], velocity: [40, 40], times: [0.0, 25], duration: 3000 },
        { notes: [59], velocity: [40], times: [0.0], duration: 1000 },
        { notes: [60], velocity: [40], times: [0.0], duration: 1000 },
        { notes: [61], velocity: [40], times: [0.0], duration: 1000 },
        { notes: [63], velocity: [40], times: [0.0], duration: 1000 },
        { notes: [61], velocity: [40], times: [0.0], duration: 1000 },
        { notes: [57, 61], velocity: [40, 40], times: [0.0, 25], duration: 3000 },

        { notes: [55, 57], velocity: [40, 40], times: [0.0, 25], duration: 3000 },
        { notes: [59], velocity: [40], times: [0.0], duration: 1000 },
        { notes: [60], velocity: [40], times: [0.0], duration: 1000 },
        { notes: [61], velocity: [40], times: [0.0], duration: 1000 },
        { notes: [62], velocity: [40], times: [0.0], duration: 1000 },
        { notes: [61], velocity: [40], times: [0.0], duration: 1000 },
        { notes: [57, 61], velocity: [40, 40], times: [0.0, 25], duration: 3000 },

        { notes: [55, 57], velocity: [40, 40], times: [0.0, 25], duration: 3000 },
        { notes: [59], velocity: [40], times: [0.0], duration: 1000 },
        { notes: [60], velocity: [40], times: [0.0], duration: 1000 },
        { notes: [61], velocity: [40], times: [0.0], duration: 1000 },
        { notes: [63], velocity: [40], times: [0.0], duration: 1000 },
        { notes: [62], velocity: [40], times: [0.0], duration: 1000 },
        { notes: [57, 61], velocity: [40, 40], times: [0.0, 25], duration: 3000 },

        // variation 2

        { notes: [50, 55, 57], velocity: [40, 40, 40], times: [0.0, 25, 40], duration: 3000 },
        { notes: [58], velocity: [40], times: [0.0], duration: 1000 },
        { notes: [50, 54, 57], velocity: [40, 40, 40], times: [0.0, 25, 40], duration: 3000 },

        { notes: [59], velocity: [40], times: [0.0], duration: 1000 },

        { notes: [50, 55, 57], velocity: [40, 40, 40], times: [0.0, 25, 40], duration: 3000 },
        { notes: [58], velocity: [40], times: [0.0], duration: 1000 },
        { notes: [50, 54, 57], velocity: [40, 40, 40], times: [0.0, 25, 40], duration: 3000 },

        { notes: [58], velocity: [40], times: [0.0], duration: 1000 },
        { notes: [60], velocity: [40], times: [0.0], duration: 1000 },
        { notes: [59], velocity: [40], times: [0.0], duration: 1000 },

        { notes: [50, 55, 57], velocity: [40, 40, 40], times: [0.0, 25, 40], duration: 3000 },
        { notes: [58], velocity: [40], times: [0.0], duration: 1000 },
        { notes: [60], velocity: [40], times: [0.0], duration: 1000 },
        { notes: [61], velocity: [40], times: [0.0], duration: 1000 },
        { notes: [63], velocity: [40], times: [0.0], duration: 1000 },
        { notes: [61], velocity: [40], times: [0.0], duration: 1000 },
        { notes: [54, 57, 61], velocity: [40, 40, 40], times: [0.0, 25, 40], duration: 3000 },

        { notes: [50, 55, 57], velocity: [40, 40, 40], times: [0.0, 25, 40], duration: 3000 },
        { notes: [58], velocity: [40], times: [0.0], duration: 1000 },
        { notes: [60], velocity: [40], times: [0.0], duration: 1000 },
        { notes: [61], velocity: [40], times: [0.0], duration: 1000 },
        { notes: [63], velocity: [40], times: [0.0], duration: 1000 },
        { notes: [61], velocity: [40], times: [0.0], duration: 1000 },
        { notes: [54, 57, 61], velocity: [40, 40, 40], times: [0.0, 25, 40], duration: 3000 },

        { notes: [50, 55, 57], velocity: [40, 40, 40], times: [0.0, 25, 40], duration: 3000 },
        { notes: [58], velocity: [40], times: [0.0], duration: 1000 },
        { notes: [60], velocity: [40], times: [0.0], duration: 1000 },
        { notes: [61], velocity: [40], times: [0.0], duration: 1000 },
        { notes: [62], velocity: [40], times: [0.0], duration: 1000 },
        { notes: [61], velocity: [40], times: [0.0], duration: 1000 },
        { notes: [54, 57, 61], velocity: [40, 40, 40], times: [0.0, 25, 40], duration: 3000 },

        { notes: [50, 55, 57], velocity: [40, 40, 40], times: [0.0, 25, 40], duration: 3000 },
        { notes: [58], velocity: [40], times: [0.0], duration: 1000 },
        { notes: [60], velocity: [40], times: [0.0], duration: 1000 },
        { notes: [61], velocity: [40], times: [0.0], duration: 1000 },
        { notes: [63], velocity: [40], times: [0.0], duration: 1000 },
        { notes: [62], velocity: [40], times: [0.0], duration: 1000 },
        { notes: [54, 57, 61], velocity: [40, 40, 40], times: [0.0, 25, 40], duration: 3000 },

        // final variation
        { notes: [53, 55, 57], velocity: [100, 100, 100], times: [0.0, 25, 40], duration: 3000 },
        { notes: [51], velocity: [20], times: [0.0], duration: 1000 },
        { notes: [52, 54, 57], velocity: [100, 100, 100], times: [0.0, 25, 40], duration: 3000 },
        { notes: [50], velocity: [20], times: [0.0], duration: 1000 },

        { notes: [53, 55, 57], velocity: [80, 80, 80], times: [0.0, 25, 40], duration: 3000 },
        { notes: [51], velocity: [15], times: [0.0], duration: 1000 },
        { notes: [52, 54, 57], velocity: [80, 80, 80], times: [0.0, 25, 40], duration: 3000 },
        { notes: [54, 57], velocity: [15, 15], times: [0.0, 25], duration: 3000 },

        { notes: [53, 55, 57], velocity: [20, 20, 20], times: [0.0, 25, 40], duration: 3000 },
        { notes: [51], velocity: [10], times: [0.0], duration: 1000 },
        { notes: [52, 54, 57], velocity: [20, 20, 20], times: [0.0, 25, 40], duration: 3000 },
        { notes: [50], velocity: [10], times: [0.0], duration: 1000 },

        { notes: [53, 55, 57], velocity: [10, 10, 10], times: [0.0, 25, 40], duration: 3000 },
        { notes: [51], velocity: [5], times: [0.0], duration: 1000 },
        { notes: [52, 54, 57], velocity: [10, 10, 10], times: [0.0, 25, 40], duration: 3000 },
        { notes: [54, 57], velocity: [5, 5], times: [0.0, 25], duration: 3000 },

        { notes: [51, 55], velocity: [2, 2], times: [0.0, 25], duration: 3000 },
        { notes: [51, 55], velocity: [2, 2], times: [0.0, 25], duration: 3000 },
        { notes: [51, 55], velocity: [2, 2], times: [0.0, 25], duration: 3000 },
        { notes: [51, 55], velocity: [2, 2], times: [0.0, 25], duration: 3000 },
        { notes: [51, 55], velocity: [2, 2], times: [0.0, 25], duration: 3000 },
        { notes: [51, 55], velocity: [2, 2], times: [0.0, 25], duration: 3000 },
        { notes: [51, 55], velocity: [2, 2], times: [0.0, 25], duration: 3000 },
        { notes: [51, 55], velocity: [2, 2], times: [0.0, 25], duration: 3000 }

    ];

}
