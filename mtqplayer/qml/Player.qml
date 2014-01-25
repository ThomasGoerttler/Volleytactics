import QtQuick 2.0
import mtq.widgets 1.0







Image
{

    property int playFieldWidth : 2400;
    property int playFieldHeight : 2400;
    property int targetx: 0;
    property int targety: 0;
    property int animation_duration: 2000;
    property int rotationAngel: 0

    id: player
    source: "../images/player.png"
    width: 0.045 * playFieldWidth
    height: 0.05 * playFieldHeight
    visible: true
    state : "auto"

    states: [State {
                 name: "rotation"
                 PropertyChanges { target: player; rotation: rotationAngel }

             },
        State { name: "user"
                PropertyChanges { target: player; source:  "../images/schuhabdruck.png"}
        },
        State { name: "auto"
                PropertyChanges { target: player; source:  "../images/player.png"}
        },
        State { name: "crossover" //um einen smoothen übergang zu erzeugen
                PropertyChanges { target: player; opacity:  0.5}
        }
    ]

             transitions: Transition {
                 RotationAnimation { duration: 100; direction: RotationAnimation.Counterclockwise }
             }


    SequentialAnimation on x {
                id: animationx
                // Animations on properties start running by default
                running: false
                NumberAnimation { from: player.x; to: targetx; duration: animation_duration; easing.type: Easing.InOutQuad }
            }

    SequentialAnimation on y {
                id: animationy
                // Animations on properties start running by default
                running: false
                NumberAnimation { from: player.y; to: targety; duration: animation_duration; easing.type: Easing.InOutQuad }
            }

    MouseArea {
            anchors.fill: parent
            onClicked:  { changeState() } //onmtqcontact für multitoe
            onDoubleClicked: {button.ready()} //TODO: improve events!!!
        }

    Label {
        id: info
        x: 900
        y: 100
        text: ""

    }

    function moveTo(x, y) {

        player.x = x
        player.y = y

    }

    function goTo(x, y, duration) {
        // player moves to x,y. duration in ms
        targetx = x
        targety = y
        //player.state = "rotation"
        animation_duration = duration
        animationx.running = true
        animationy.running = true
        rotationAngel = Math.tan((y-player.y)/(x-player.x)) //vom prinzip her

    }

    function changeState() {
        if (player.state == "auto")
            player.state = "user" //player.visible = false
        else
            player.state = "auto"
    }

    }




