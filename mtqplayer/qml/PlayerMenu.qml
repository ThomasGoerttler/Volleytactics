import QtQuick 2.0
import mtq.widgets 1.0


// Menu when Player finished his Task
// Options: Again, Again with another speed, Test [not implemented so far]
// Always for only one Person
//
// change speed      |          |
//                   |   Again  |
// [_______o__]      |          |
//
//
//


Rectangle {
    id : frame
    width: 700
    height: 300


    property double speed : 1


    Text {
        x : 0
        y : 0
        text : "change speed"
        font.family: "Helvetica"
        font.pointSize: 45


    }

   Slider {
        id: sliderspeed
        x: 0
        y: 50
        width: 450
        height: 250
        value : 0.2
        //onmt: updateSpeed()


        Component.onCompleted: {
            sliderspeed.updateSpeed.connect(setSpeed)
        }


        signal updateSpeed() // set the speed

        function setSpeed() {
            speed = 1-sliderspeed.value+0.001

        }

    }


    PushButton {
            id : buttonagain
            x : 500
            y : 0
            height : 300
            width : 200
            text : "One \nmore \ntime"
           onPressed : {sliderspeed.setSpeed(), button.goToInitialPositions()}

    }
}
