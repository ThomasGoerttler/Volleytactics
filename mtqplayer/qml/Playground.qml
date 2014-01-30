import QtQuick 2.0
import mtq.widgets 1.0

Rectangle {

    property int playFieldWidth : 1850;
    property int playFieldHeight : 1850;
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
    property int playernumber : 1 //number of active players in the training

    //erzeuge alle :( Pfeile mit visible auf false
    // Repeater könnte irgendwie auch klappen




    id: floor
    width: 4096
    height: 2400
    color: "#ff333333"


    Image {
        id : fieldimage
        source: "../images/playfield.png"
        height: floor.height
        width: 692*floor.height/565


        Label {
            id: infolabelbasic
            x: 600
            y: playFieldHeight/1.3
            text: ""
            transform: Rotation { origin.x: 0; origin.y: 25; angle: 270}
            Text {
                id : infolabel
                text: "o"
                font.family: "Helvetica"
                font.pointSize: 50
                color: "red"
            }
        }


        Label {
            id: countdownlabelbasic
            x: 150
            y: playFieldHeight/2
            text: ""
            transform: Rotation { origin.x: 0; origin.y: 25; angle: 270}
            Text {
                id : countdownlabel
                text: parent.text //"Hello World!"
                font.family: "Helvetica"
                font.pointSize: 50
                color: "red"
            }
        }


        //the first row of the opponents
        //player 3 has the ball and hits the ball to player 2 or 4
        //spielzug kann den countdown ersetzen
        //countdown von 3, dann spielt der zuspieler der gegner den ball, dann entscheidet sich der laufweg
        //und wird angezeigt

        Player {
            id: opponent4
            x: 400
            y: 300
            state: "opponent"
        }

        Player {
            id: opponent3
            x: 450
            y: 900
            state: "opponent"
        }



        Player {
            id: opponent2
            x: 400
            y: 1600
            state: "opponent"
        }



        Rectangle {
            id : playfield
            x: 1050//180/672*642
            y: 250
            color:  "transparent"
            height : playFieldHeight
            width: playFieldWidth

            Ball {

                id: ball
                x: 0-parent.x+opponent3.x
                y: 0-parent.y+ opponent3.y
                opacity: 0.9

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






PlayerMenu {
        id: playermenu
    x : 2200
    y : 600
}

RadioButton {
    id: buttonnumber
    x: 2300
    y: 1000
    width: 1200
    selectedItem: 0
    rotation: 270

    Component.onCompleted: {
        buttonnumber.addItem("1");
        buttonnumber.addItem("2");
        buttonnumber.addItem("3");
        buttonnumber.addItem("4");
        buttonnumber.addItem("5");
        buttonnumber.addItem("6");
    }

    onSelectedItemChanged: {
        floor.playernumber = selectedItem+1
}

}

Arrow {
    id: arrow1
    startx : initialPositions[0][0]
    starty : initialPositions[0][1]
    endx : turn42Positions[0][0]
    endy : turn42Positions[0][1]
    angel: 90 // should be calculated ...
    visible : false

}

Arrow {
    id: arrow2
    startx : initialPositions[1][0]
    starty : initialPositions[1][1]
    endx : turn42Positions[1][0]
    endy : turn42Positions[1][1]
    angel : 180
    visible : false

}

Arrow {
    id: arrow3
    startx : initialPositions[2][0]
    starty : initialPositions[2][1]
    endx : turn42Positions[2][0]
    endy : turn42Positions[2][1]
    angel : 180
    visible : false

}

Arrow {
    id: arrow4
    startx : initialPositions[3][0]
    starty : initialPositions[3][1]
    endx : turn42Positions[3][0]
    endy : turn42Positions[3][1]
    angel : 68.2-180
    visible : false

}

Arrow {
    id: arrow5
    startx : initialPositions[4][0]
    starty : initialPositions[4][1]
    endx : turn42Positions[4][0]
    endy : turn42Positions[4][1]
    angel : 26.5+90
    visible : false

}

Arrow {
    id: arrow6
    startx : initialPositions[5][0]
    starty : initialPositions[5][1]
    endx : turn42Positions[5][0]
    endy : turn42Positions[5][1]
    angel : 40-90
    visible : false

}




Timer {
    property int sec : 5
    id: countdown
    interval: speed*1000
    running: false
    repeat: false
    onTriggered: oneDown()

    function oneDown() {

        countdown.running = true
        if (countdown.sec == 5) {
            ball.goTo(opponent4.x-parent.x, opponent4.y-parent.y, speed*3000)
        }
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


Timer {
    property int countvar : 0
    id : counter
    interval : 10
    running : false
    repeat : false
    onTriggered: count()

    function count() {
        countvar += 10

    }

    function stop() {
        running = false
    }

    function reset() {
        countvar = 0
    }

}


PushButton {

    property variant allPlayers: [player1, player2, player3, player4, player5, player6]
    property variant turn42Arrows : [arrow1, arrow2, arrow3, arrow4, arrow5, arrow6]



    id: button
    x: playFieldWidth + 100
    y: 200
    width: 300
    height: 250
    text: "Evaluate"
    onPressed: evaluation() //onmtqContactMove for floor

    states : [State {name: "initial"},
        State {name : "turn42"}]


    signal evaluation() // all player rotates
    signal moveturn42() //bewege auf position von spielzug 42
    signal isReady()

    Component.onCompleted: {
        button.moveturn42.connect(turn1)
        //button.pressed.connect(send)
        button.isReady.connect(ready)
        button.evaluation.connect(evaluate)
    }


    function ready() {

        var z = 0
        for (var i=0; i<6; i++) {

        if (allPlayers[i].state == "user") {
            z++
        }
        }
        if (z == floor.playernumber) {
            countdown.start()} //akustischen countdown hinzufügen
    }

    function goToInitialPositions() {

        for (var i=0; i<6; i++) {
            allPlayers[i].goTo(initialPositions[i][0], initialPositions[i][1], 500)
            allPlayers[i].state = "auto"
            allPlayers[i].visible = true
            turn42Arrows[i].reset()
        }
        ball.moveTo(0, 0, 500)

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

        floor.speed = playermenu.speed



        counter.start()
        //dann bewegung ausführen
        ball.goTo(ballRouteToTurn42Positions[0][0], ballRouteToTurn42Positions[0][1], 5100*speed)
        //playsound http://www.soundsnap.com/node/69484

        for (var i=0; i<6; i++) {

        if (allPlayers[i].state == "auto") {
            allPlayers[i].goTo(turn42Positions[i][0], turn42Positions[i][1], 5000*speed)
        }
        else {
            //make footprints invisible
            allPlayers[i].visible = false

        }
        }
        //infolabel.text = speed


    }

    function evaluate() {
        //wird aufgerufen, wenn ball an zielposition ist
        infolabel.text = ""
        var z = 0
        for (var i=0; i<6; i++) {
            //infolabel.text += turn42Arrows[i].state
            if (turn42Arrows[i].state == 'arrived') {
                infolabel.text += "\n Jawoll " + (i+1) + turn42Arrows[i].state
                z++
            }
        }
        if (z==playernumber) {
            ball.goTo(ballRouteToTurn42Positions[1][0], ballRouteToTurn42Positions[1][1], speed*3000)
        }

    }


}
        }

    }

}
