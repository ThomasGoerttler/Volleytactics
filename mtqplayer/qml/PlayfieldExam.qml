import QtQuick 2.0
import mtq.widgets 1.0

Rectangle
{
    id: floor
    width: 4096; height: 2400
    color: "#ff333333"

    property int recognized;
    property int touchLeft;
    property int touchRight;
    property int count;
    property int playFieldWidth : 2400;
    property int playFieldHeight : 2400
    property int playFieldY : 700;
    property bool finished: false

    function recognize()
    {
           recognized+=1;
    }

    function goalAchieved()
    {
        if (recognized == 0)
            resultLabel.text = "Du hast alles richtig gemacht."
        else
            resultLabel.text = "Du hast etwas falsch gemacht."
        if (touchLeft != 0)
            leftMistake.visible = true;
        if (touchRight != 0)
            rightMistake.visible = true;
        finished = true;
        back.visible = true;
    }

    function show()
    {
        ball.visible = true;
        player2.visible = true;
        player3.visible = true;
        player4.visible = true;
        player5.visible = true;
        player6.visible = true;
    }

    function setCount()
    {
        count = 5;
    }

    function timing()
    {
        if (count == 0)
        {
            numberLabel.text = "";
            countTimer.stop();
        }
        else
        {
            numberLabel.text = count;
            count = count - 1;
            if (count == 3)
                show();
        }
    }

    function refresh()
    {
        ball.visible = false;
        player2.visible = false;
        player3.visible = false;
        player4.visible = false;
        player5.visible = false;
        player6.visible = false;
        goalImprint.visible = false;
        arrow.visible = false;
        direction.visible = false;
        back.visible = false;

        ball.x = playFieldY -(0.166 * playFieldWidth ); ball.y= 0.5 * playFieldHeight;
        player2. x= 0.6 * playFieldWidth; player2.y= 0.1 * playFieldHeight;
        player3.x= 0.08 * playFieldWidth; player3.y= 0.1 * playFieldHeight;
        player4.x= 0.08 * playFieldWidth; player4.y= 0.5 * playFieldHeight;
        player5.x= 0.08 * playFieldWidth; player5.y= 0.8 * playFieldHeight;
        player6.x= 0.6 * playFieldWidth; player6.y= 0.8 * playFieldHeight;

        finished = false;
        resultLabel.text = "";

        recognized = 0;
        touchLeft = 0;
        touchRight = 0;

        leftMistake.visible = false;
        rightMistake.visible = false;
    }


    Rectangle
    {
        id: playfield
        x: playFieldY
        y:0
        width: playFieldWidth
        height: playFieldHeight
        color: "#ff888888"
        border.color: "#ffffffff"
        border.width: 3

        PushButton
        {
            id: sensorLeft
            x: 0.478 * playFieldWidth
            y: 0.655 * playFieldHeight
            width: 0.266 * playFieldWidth
            height: 0.044 * playFieldHeight
            transform: Rotation
            {
                origin.x: 0.22 * playFieldWidth
                origin.y: 0.22 * playFieldHeight
                angle: 40
            }
            onPressed:
            {
                if(finished == false)
                {
                    recognize();
                    touchLeft +=1;
                }
            }
        }

        Rectangle
        {
            id: leftMistake
            x: 0.478 * playFieldWidth
            y: 0.655 * playFieldHeight
            width: 0.266 * playFieldWidth
            height: 0.044 * playFieldHeight
            color: "#ffff8C00"
            visible: false
            transform: Rotation
            {
                origin.x: 0.22 * playFieldWidth;
                origin.y: 0.22 * playFieldHeight;
                angle: 40
            }
        }

        PushButton
        {
            id: sensorRight
            x: 0.533 * playFieldWidth
            y: 0.589 * playFieldHeight
            width: 0.266 * playFieldWidth
            height: 0.044 * playFieldHeight
            transform: Rotation
            {
                origin.x: 0.22 * playFieldWidth;
                origin.y: 0.22 * playFieldHeight;
                angle: 40
            }
            onPressed:
            {
               if(finished == false)
               {
                   recognize();
                   touchRight +=1;
               }
            }
        }

        Rectangle
        {
            id: rightMistake
            x: 0.533 * playFieldWidth;
            y: 0.589 * playFieldHeight
            width: 0.266 * playFieldWidth;
            height: 0.044 * playFieldHeight
            color: "#ffff8C00"
            visible: false
            transform: Rotation
            {
                origin.x: 0.22 * playFieldWidth;
                origin.y: 0.22 * playFieldHeight;
                angle: 40
            }
        }



        PushButton
        {
            id: startImprint
            Image {
                anchors.fill: parent
                source: "../images/schuhabdruck.png"
            }
            x: 0.64 * playFieldWidth;
            y: 0.19 * playFieldHeight
            width:0.083 * playFieldWidth;
            height: 0.088 * playFieldHeight
            transform: Rotation
            {
                origin.x: 0.155 * playFieldWidth;
                origin.y: 0.211 * playFieldHeight;
                angle: -90
            }
           onPressed:
           {
                checkImprint.visible = true;
                checkTimer.start();
                startTimer.start();
                showTimer.start();
                countTimer.start();
           }

         }

        Image
        {
            id: checkImprint
            source: "../images/schuhabdruck_check.png"
            x: 0.64 * playFieldWidth;
            y: 0.19 * playFieldHeight
            width:0.083 * playFieldWidth;
            height: 0.088 * playFieldHeight
            visible: false
            transform: Rotation
            {
                origin.x: 0.155 * playFieldWidth;
                origin.y: 0.211 * playFieldHeight;
                angle: -90
            }
        }

        PushButton
        {
            id: goalImprint
      /*      Image {
                anchors.fill: parent
                source: "../images/schuhabdruck.png"
            } */
            x: 0.978 * playFieldWidth;
            y: 0.53 * playFieldHeight
            width:0.083 * playFieldWidth;
            height: 0.088 * playFieldHeight
            visible: true

            transform: Rotation
            {
                origin.x: 0.155 * playFieldWidth;
                origin.y: 0.211 * playFieldHeight;
                angle: -60
            }
            onPressed:
            {
                if(finished == false)
                    goalAchieved();
            }
        }

        Image
        {
            id: arrow
            source: "../images/arrow.png"
            x: 0.43 * playFieldWidth;
            y: 0.53 * playFieldHeight
            width:0.089 * playFieldWidth;
            height: 0.33 * playFieldHeight
            visible: false
            transform: Rotation
            {
                origin.x: 0.22 * playFieldWidth;
                origin.y: 0.22 * playFieldHeight;
                angle: 130
            }
        }


        Image
        {
            id: direction
            source: "../images/arrow.png"
            x: 0.13 * playFieldWidth;
            y: 0.2 * playFieldHeight
            width: 0.033 * playFieldWidth;
            height: 0.038 * playFieldHeight
            visible: false
            transform: Rotation
            {
                origin.x: 0.156 * playFieldWidth
                origin.y: 0.211 * playFieldHeight
                angle: 130}
        }

        Image
        {
            id: player2
            source: "../images/player.png"
            x: 0.6 * playFieldWidth
            y: 0.1 * playFieldHeight
            width: 0.045 * playFieldWidth
            height: 0.05 * playFieldHeight
            visible: false
        }

        Image
        {
            id: player3
            source: "../images/player.png"
            x: 0.08 * playFieldWidth
            y: 0.1 * playFieldHeight
            width: 0.045 * playFieldWidth
            height: 0.05 * playFieldHeight
            visible: false
        }

        Image
        {
            id: player4
            source: "../images/player.png"
            x: 0.08 * playFieldWidth
            y: 0.5 * playFieldHeight
            width: 0.045 * playFieldWidth
            height: 0.05 * playFieldHeight
            transform: Rotation
            {
                origin.x: 0.03 * playFieldWidth
                origin.y: 0.03 * playFieldHeight
                angle: 90
            }
            visible: false
        }

        Image
        {
            id: player5
            source: "../images/player.png"
            x: 0.08 * playFieldWidth
            y: 0.8 * playFieldHeight
            width: 0.045 * playFieldWidth
            height: 0.05 * playFieldHeight
            transform: Rotation
            {
                origin.x: 0.01 * playFieldWidth
                origin.y: 0.06 * playFieldHeight
                angle: 90
            }
            visible: false
        }

        Image
        {
            id: player6
            source: "../images/player.png"
            x: 0.6 * playFieldWidth
            y: 0.8 * playFieldHeight
            width: 0.045 * playFieldWidth
            height: 0.05 * playFieldHeight
            transform: Rotation
            {
                origin.x: 0.005 * playFieldWidth
                origin.y: 0.06 * playFieldHeight
                angle: 45
            }
            visible: false
        }

        Timer
        {
            id: startTimer
            interval: 1000;
            running: false;
            repeat: false
            onTriggered:
            {
                generalLabel.text = "Prüfung: Start in"
                setCount();
            }
        }

        Timer
        {
            id: countTimer
            interval: 1100;
            running: false;
            repeat: true
            onTriggered:
                timing();
        }

        Timer
        {
            id: showTimer
            interval: 8000;
            running: false;
            repeat: false
            onTriggered:
            {
                generalLabel.text = "";
                goalTimer.start();
                animationTimer.start();
            }
        }

        Timer
        {
            id: animationTimer
            interval:15;
            running: false;
            repeat: true
            onTriggered:
            {
                if ((player2.x) >  0.3 * playFieldWidth)
                    player2.x = player2.x - 0.00555 * playFieldWidth;

                if ((player3.x) > 0.05 * playFieldWidth)
                     player3.x = player3.x - 0.00555 * playFieldWidth;

                if ((player4.y) > 0.2 * playFieldHeight)
                {
                     player4.y = player4.y - 0.00555 * playFieldHeight;
                     player4.x = player4.x - 0.0009 * playFieldWidth;
                }

                if ((player5.y) > 0.6 * playFieldHeight)
                {
                     player5.y = player5.y - 0.00555 * playFieldHeight;
                     player5.x = player5.x + 0.004 * playFieldWidth;
                }

                if ((player6.y) > 0.6 * playFieldHeight)
                {
                     player6.y = player6.y - 0.00555 * playFieldHeight;
                     player6.x = player6.x - 0.004 * playFieldWidth;
                }

                if ((ball.y) > 0.1 * playFieldHeight)
                    ball.y = ball.y - 0.0055 * playFieldHeight;
                else
                {
                    secondAnimationTimer.start();
                    animationTimer.stop();
                }
            }
        }

        Timer
        {
            id: secondAnimationTimer
            interval:15;
            running: false;
            repeat: true
            onTriggered:
            {
                if ((ball.x) < playFieldY + 0.888 * playFieldWidth)
                {
                    ball.x = ball.x + 0.00555 * playFieldWidth;
                    ball.y = ball.y + 0.00333 * playFieldHeight;
                }
                else
                {
                    secondAnimationTimer.stop();
                    if (finished == true)
                        backAnimationTimer.start();
                }
            }
        }

        Timer
        {
            id: backAnimationTimer
            interval:20;
            running: false;
            repeat: true
            onTriggered:
            {
                if ((ball.x) > playFieldY + 0.2 * playFieldWidth)
                {
                    ball.x = ball.x - 0.00555 * playFieldWidth;
                    ball.y = ball.y - 0.004 * playFieldHeight;
                }
                else
                    backAnimationTimer.stop();
            }
        }

        Timer
        {
            id: goalTimer
            interval: 4100;
            running: false;
            repeat: false
            onTriggered:
            {
                if (finished == false)
                {
                    resultLabel.text = "Du warst zu langsam.";
                    finished = true;
                    back.visible = true;
                }
            }
        }

        Timer
        {
            id: checkTimer
            interval: 100;
            running: false;
            repeat: false
            onTriggered:
            {
                checkImprint.visible = false;
            }
        }

        Label
        {
            id: generalLabel
            x: 0.22 * playFieldWidth;
            y: 0.556 * playFieldHeight
            width: 0.72 * playFieldWidth;
            height: 0.177 * playFieldHeight
            text: ""
            transform: Rotation
            {
                origin.x: 0.22 * playFieldWidth;
                origin.y: 0.11 * playFieldHeight;
                angle: -90
            }
        }

        Label
        {
            id: resultLabel
            x: 0.48 * playFieldWidth;
            y: 0.736 * playFieldHeight
            width: 0.72 * playFieldWidth;
            height: 0.177 * playFieldHeight
            text: ""
            transform: Rotation
            {
                origin.x: 0.22 * playFieldWidth
                origin.y: 0.11 * playFieldHeight
                angle: -45
            }
        }

        Label
        {
            id: numberLabel
            x: 0.277 * playFieldWidth
            y: 0.556 * playFieldHeight
            width: 0.72 * playFieldWidth
            height: 0.177 * playFieldHeight
            text: ""
            transform: Rotation
            {
                origin.x: 0.22 * playFieldWidth
                origin.y: 0.11 * playFieldHeight
                angle: -90
            }
        }

        Rectangle
        {
            id: line
            x: 0.33 * playFieldWidth
            y: 0
            width: 0.011 * playFieldWidth
            height: playFieldHeight
            color: "#ffffffff"
            border.color: "#ffffffff"
            border.width: 4
        }
    }

    Image
    {
        id: ball
        source: "../images/volleyball.png"
        x: playFieldY -(0.166 * playFieldWidth)
        y: 0.5 * playFieldHeight
        width: 0.078 * playFieldWidth
        height: 0.078 * playFieldHeight
        visible: false
    }


    Rectangle
    {
        id: back
        color: "#ff000000"
        x: playFieldY + 0.875 * playFieldWidth;
        y: 0.625 * playFieldHeight;
        width: 265;
        height: 180
        visible: true
        PushButton
        {
            id: backB;
            x: 10; y :10
            text: "weiter"
            onPressed:
            {
                floor.visible = false;
            }
        }
    }

}
