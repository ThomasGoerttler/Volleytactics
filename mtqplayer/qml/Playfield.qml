import QtQuick 2.0
import mtq.widgets 1.0

Rectangle
{
    id: floor
    width: 4096; height: 2400
    color: "#ff333333"

    property int recognized;
    property int finished;
    property int touchLeft;
    property int touchRight;
    property int count;

    function recognize()
    {
           recognized+=1;
    }

    function goalAchieved()
    {
        finished+=1;
        if (recognized == 0)
            generalLabel.text = "You've gone right."
         else
            generalLabel.text = "You've gone wrong."

        if (touchLeft != 0)
            sensorLeft.color = "#FF8C00"

        if (touchRight != 0)
            sensorRight.color = "#FF8C00"
    }

    function show()
    {
        goalImprint.visible = true;
        arrow.visible = true;
        direction.visible = true;
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
        }
    }


    Rectangle
    {
        id: playfield
        x: 200; y: 200
        width: 900; height: 900
        color: "#ff000000"
        border.color: "#ffffffff"; border.width: 8

        Rectangle
        {
            id: sensorLeft
            x: 430; y: 590
            width: 240; height: 40
            color: "#ff000000"
            transform: Rotation { origin.x: 200; origin.y: 200; angle: 40}
            MouseArea
            {
                anchors.fill: parent
                onClicked:
                {
                    if(finished == 0)
                    {
                        recognize();
                        touchLeft +=1;
                    }
                }
            }
        }

        Rectangle
        {
            id: sensorRight
            x: 480; y: 530
            width: 240; height: 40
            color: "#ff000000"
            transform: Rotation { origin.x: 200; origin.y: 200; angle: 40}
            MouseArea
            {
                anchors.fill: parent
                onClicked:
                {
                    if(finished == 0)
                    {
                        recognize();
                        touchRight +=1;
                    }
                }
            }
        }

        Image
        {
            id: arrow
            source: "../images/arrow.png"
            x: 390; y: 480
            width:80; height: 300
            visible: false
            transform: Rotation { origin.x: 200; origin.y: 200; angle: 130}
        }

        Image
        {
            id: startImprint
            source: "../images/schuhabdruck.png"
            x: 580; y: 170
            width:75; height: 80
            transform: Rotation { origin.x: 140; origin.y: 190; angle: -90}
         }

        Image
        {
            id: goalImprint
            source: "../images/schuhabdruck.png"
            x: 880; y: 480
            width:75; height: 80
            visible: false
            transform: Rotation { origin.x: 140; origin.y: 190; angle: -60}
            MouseArea
            {
                anchors.fill: parent
                onClicked:
                {
                    if(finished == 0)
                        goalAchieved();
                }
            }
        }

        Image
        {
            id: direction
            source: "../images/arrow.png"
            x: 120; y: 180
            width: 30; height: 35
            visible: false
            transform: Rotation { origin.x: 140; origin.y: 190; angle: 130}
        }

        Timer
        {
            id: startTimer
            interval: 1000; running: true; repeat: false
            onTriggered:
            {
                generalLabel.text = "Übung: Start in"
                setCount();
            }
        }

        Timer
        {
            id: countTimer
            interval: 1200; running: true; repeat: true
            onTriggered:
                timing();
        }

        Timer
        {
            id: showTimer
            interval: 8000; running: true; repeat: false
            onTriggered:
            {
                generalLabel.text = "";
                show();
                goalTimer.start();
                animationTimer.start();
            }
        }

        Timer
        {
            id: animationTimer
            interval:15; running: false; repeat: true
            onTriggered:
            {
                if ((ball.x) < 1000)
                {
                    ball.x = ball.x + 5;
                    ball.y = ball.y + 3;
                }
                else
                {
                    animationTimer.stop();
                    if (finished != 0)
                        backAnimationTimer.start();
                }
            }
        }

        Timer
        {
            id: backAnimationTimer
            interval:20; running: false; repeat: true
            onTriggered:
            {
                if ((ball.x) > 300)
                {
                    ball.x = ball.x - 5;
                    ball.y = ball.y - 3;
                }
                else
                    backAnimationTimer.stop();
            }
        }

        Timer
        {
            id: goalTimer
            interval: 3000; running: false; repeat: false
            onTriggered:
            {
                if (finished == 0)
                    generalLabel.text = "You were too slow.";
            }
        }

        Label
        {
            id: generalLabel
            x: 200; y: 500
            width: 650; height: 160
            text: ""
            transform: Rotation { origin.x: 200; origin.y: 100; angle: -90}
        }

        Label
        {
            id: numberLabel
            x: 250; y: 500
            width: 650; height: 160
            text: ""
            transform: Rotation { origin.x: 200; origin.y: 100; angle: -90}
        }

        Rectangle
        {
            id: line
            x: 300; y: 0
            width: 10; height: 900
            color: "#ff000000"
            border.color: "#ffffffff"
            border.width: 8
        }
    }

    Image
    {
        id: ball
        source: "../images/volleyball.png"
        x: 50; y: 250
        width: 70; height: 70
    }
}
