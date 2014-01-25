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



    id: ball
    source: "../images/volleyball.png"
    width: 0.078 * playFieldWidth
    height: 0.078 * playFieldHeight
    visible: true


    SequentialAnimation on x {
                id: animationx
                // Animations on properties start running by default
                running: false
                NumberAnimation { from: ball.x; to: targetx; duration: animation_duration; easing.type: Easing.InOutQuad }
            }

    SequentialAnimation on y {
                id: animationy
                // Animations on properties start running by default
                running: false
                NumberAnimation { from: ball.y; to: targety; duration: animation_duration; easing.type: Easing.InOutQuad }
            }



    Label {
        id: info
        x: 100
        y: 100
        text: ""

    }

    function moveTo(x, y) {

        ball.x = x
        ball.y = y

    }

    function goTo(x, y, duration) {
        // player moves to x,y. duration in ms
        targetx = x
        targety = y

        animation_duration = duration
        animationx.running = true
        animationy.running = true
        rotationAngel = Math.tan((y-ball.y)/(x-ball.x)) //vom prinzip her
        ball.state = "rotated"
    }

}


