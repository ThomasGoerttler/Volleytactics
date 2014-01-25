import QtQuick 2.0
import mtq.widgets 1.0

Rectangle {

    property int playFieldWidth : 2400;
    property int playFieldHeight : 2400;
    property variant initialPositions :
        [[0.6 * playFieldWidth, 0.2 *playFieldHeight],
        [0.05 * playFieldWidth, 0.2 *playFieldHeight],
        [0.05 * playFieldWidth, 0.5 *playFieldHeight],
        [0.05 * playFieldWidth, 0.8 *playFieldHeight],
        [0.6 * playFieldWidth, 0.8 *playFieldHeight],
        [0.6 * playFieldWidth, 0.5 *playFieldHeight]];

    //4-2, lange 6
    property variant turn42Positions :
        [[0.4 * playFieldWidth, 0.2 *playFieldHeight],
        [0.05 * playFieldWidth, 0.1 *playFieldHeight],
        [0.05 * playFieldWidth, 0.3 *playFieldHeight],
        [0.25 * playFieldWidth, 0.7 *playFieldHeight],
        [0.5 * playFieldWidth, 0.6 *playFieldHeight],
        [0.85 * playFieldWidth, 0.68 *playFieldHeight]];

    property variant ballRouteToTurn42Positions : [[0.85 * playFieldWidth, 0.68 *playFieldHeight],
    [0.05 * playFieldWidth, 0.1 *playFieldHeight]]


    property double speed : 0.5; // 1 ist originaltempo

    //erzeuge alle :( Pfeile mit visible auf false
    // Repeater könnte irgendwie auch klappen




    id: floor
    width: 4096
    height: 2400
    color: "#ff333333"


    Image {
        id : volleyballfield
        //source: "../images/Spielfeld5.jpg"

}

Player {

    id: player1
    x: initialPositions[0][0]
    y: initialPositions[0][1]
    visible: true
}

Player {

    id: player2
    x: initialPositions[1][0]
    y: initialPositions[1][1]
    visible: true
}

Player {

    id: player3
    x: initialPositions[2][0]
    y: initialPositions[2][1]
    visible: true
}

Player {

    id: player4
    x: initialPositions[3][0]
    y: initialPositions[3][1]
    visible: true
}

Player {

    id: player5
    x: initialPositions[4][0]
    y: initialPositions[4][1]
    visible: true
}

Player {

    id: player6
    x: initialPositions[5][0]
    y: initialPositions[5][1]
    visible: true
}


property variant allPlayers: [player1, player2, player3, player4, player5, player6]





Ball {

    id: ball
    x: 0
    y: 0

}

Slider {
    id: sliderspeed
    x: 600
    y: 50
    width: 500
    height: 250
    value : 0.2
    //onmt: updateSpeed() //onmtqContactMove for floor

    Component.onCompleted: {
        sliderspeed.updateSpeed.connect(setSpeed)
    }


    signal updateSpeed() // set the speed

    function setSpeed() {
        speed = sliderspeed.value+0.001

    }

}

Arrow {
    id: arrow1
    startx : initialPositions[0][0]
    starty : initialPositions[0][1]
    endx : turn42Positions[0][0]
    endy : turn42Positions[0][1]
    visible : false

}

Arrow {
    id: arrow2
    startx : initialPositions[1][0]
    starty : initialPositions[1][1]
    endx : turn42Positions[1][0]
    endy : turn42Positions[1][1]
    visible : false

}

Arrow {
    id: arrow3
    startx : initialPositions[2][0]
    starty : initialPositions[2][1]
    endx : turn42Positions[2][0]
    endy : turn42Positions[2][1]
    visible : false

}

Arrow {
    id: arrow4
    startx : initialPositions[3][0]
    starty : initialPositions[3][1]
    endx : turn42Positions[3][0]
    endy : turn42Positions[3][1]
    visible : false

}

Arrow {
    id: arrow5
    startx : initialPositions[4][0]
    starty : initialPositions[4][1]
    endx : turn42Positions[4][0]
    endy : turn42Positions[4][1]
    visible : false

}

Arrow {
    id: arrow6
    startx : initialPositions[5][0]
    starty : initialPositions[5][1]
    endx : turn42Positions[5][0]
    endy : turn42Positions[5][1]
    visible : false

}

property variant turn42Arrows : [arrow1, arrow2, arrow3, arrow4, arrow5, arrow6];

Label {
    id: infolabel
    x: 1100
    y: 1100
    text: ""
}


Label {
    id: countdownlabel
    x: 1000
    y: 1000
    text: ""
}


Timer {
    property int sec : 5
    id: countdown
    interval: 1000
    running: false
    repeat: false
    onTriggered: oneDown()

    function oneDown() {

        countdown.running = true
        if (countdown.sec == 3) {
            button.turn1Arrows()
        }

        if (countdown.sec == -1) {
                countdown.running = false
                countdown.sec = 5
                countdownlabel.text = ""
                button.turn1()
        }
        else
            countdownlabel.text = countdown.sec--
    }
     }





PushButton {
    id: button
    x: 50
    y: 50
    width: 300
    height: 250
    text: "Rorieren"
    onPressed: moveturn42() //onmtqContactMove for floor

    states : [State {name: "initial"},
        State {name : "turn42"}]


    signal rotation() // all player rotates
    signal moveturn42() //bewege auf position von spielzug 42
    signal isReady()

    Component.onCompleted: {
        //button.rotation.connect(rotate)
        button.moveturn42.connect(turn1)
        //button.pressed.connect(send)
        button.isReady.connect(ready)
    }


    function ready() {

        countdown.start()


    }

    function rotate() {



        sliderspeed.updateSpeed()


        for (var i=0; i<5; i++)
            allPlayers[i].goTo(allPlayers[i+1].x, allPlayers[i+1].y, 2000*speed)

        allPlayers[5].goTo(allPlayers[0].x, allPlayers[0].y, 2000*speed)

        //alle Elemente in der allPlayers um eine Position verschieben
        //oder einfach wieder auf initiale Position gehen und visible wechseln
        //alle wieder zurück stellen


        //ball.goTo(50, 50, 300)


        }
    function turn1Arrows() {
        //erst alle Pfeile anzeigen

        for (var i=0; i<6; i++) {

        if (allPlayers[i].state == "user") {

            turn42Arrows[i].visible = true
        }
        }

    }

    function turn1() {
        //4-2 system
        sliderspeed.updateSpeed()

        //dann bewegung ausführen
        ball.goTo(ballRouteToTurn42Positions[0][0], ballRouteToTurn42Positions[0][1], 5100*speed)

        for (var i=0; i<6; i++) {

        if (allPlayers[i].state == "auto") {
            allPlayers[i].goTo(turn42Positions[i][0], turn42Positions[i][1], 5000*speed)
        }
        }

    }


}



}
