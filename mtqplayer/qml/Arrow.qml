import QtQuick 2.0
import mtq.widgets 1.0



Rectangle
{
    //wird angezeigt, sobald start und endpunkt bekannt sind
    //richtungsvektor, winkel
    //Alternative: pfeil setzt sich zusammen aus vielen kleinen pfeilen
    //          Pfeil:    \/
    //                    \/
    //besteht aus vielen kleinen elementen. wenn das ende erreicht wurde ändert sich der state
    //es muss mindestens jedes dritte pfeilsegment berührt werden




    property int playFieldWidth : 2400;
    property int playFieldHeight : 2400;
    property variant allSegments : [];
    property int startx : 0;
    property int starty : 0;
    property int endx : 0;
    property int  endy : 0;
    //property int len : Math.sqrt(Math.pow(startx-endx), 2) - (Math.pow(starty-endy), 2))));
    property int difx : Math.abs(startx-endx);
    property int dify : Math.abs(starty-endy);
    property double angel : 90//(starty-endy) < 0 ? 360/(2*Math.PI)*Math.atan(dify/difx)-90 : 360/(2*Math.PI)*Math.atan(difx/dify);
    property int thickness : 120

    id :arrow

    x: startx //-thickness
    y: starty //-thickness
    width: 3*thickness;
    height: Math.sqrt(difx*difx+dify*dify);
    color: "transparent"
    opacity: 0.8
    state : "waiting"

    states: [State { name: "waiting"},
        State { name: "waiting"}]

    transform: Rotation { origin.x: 0; origin.y: thickness/2; angle: angel}//(-1)*(angel-90)} // winkel richtig berechnen eig. Math.atan(dify/difx)

//Mehrere Spalten

    // Spalte für den richtigen Weg
        Column {
             x: thickness; y: 0
             spacing: 0

             Repeater { id: rep
                 model: Math.floor( Math.sqrt(difx*difx+dify*dify)/thickness)
                        Rectangle { width:thickness ; height: thickness
                                    color: "lightgreen"
                                    opacity: 1

                                    Text { text: "\\/"
                                           font.pointSize: 20
                                           anchors.centerIn: parent } }
//                        rep.itemAt(5). color = "blue";

             }

         }

        // Spalte für Abweichung links
        Column {
             x: 0; y: 0
             spacing: 0

             Repeater { id: repleft
                 model: Math.floor( Math.sqrt(difx*difx+dify*dify)/thickness)
                        Rectangle { //replace with PushButton
                            width:thickness
                            height: thickness
                            color: "yellow"
                            opacity: 0.1
             }

         }
        }
        // Spalte für Abweichung rechts
        Column {
             x: 2*thickness; y: 0
             spacing: 0

             Repeater { id: repright
                 model: Math.floor( Math.sqrt(difx*difx+dify*dify)/thickness)
                        Rectangle { //replace with PushButton
                            width:thickness
                            height: thickness
                            color: "yellow"
                            opacity: 0.1
             }

         }
        }

        //final position is a push button
        PushButton {
            id: goalarea
            x: thickness
            y: parent.height
            height: 200
            width : thickness //
            text : ""
            visible: true
            opacity: 0.5

            onPressed: {state="arrived", infolabel.text = "paaaaasst" }//player status auf reached setzen
        }


     }

