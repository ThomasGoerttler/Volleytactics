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
    property int angel : (starty-endy) < 0 ? 360/(2*Math.PI)*Math.atan(dify/difx)-90 : 360/(2*Math.PI)*Math.atan(dify/difx)+90;


    x: startx
    y: starty
    width: 50;
    height: Math.sqrt(difx*difx+dify*dify);

    transform: Rotation { origin.x: 0; origin.y: 25; angle: angel}//(-1)*(angel-90)} // winkel richtig berechnen eig. Math.atan(dify/difx)


        Column {
             x: 0; y: 0
             spacing: 0

             Repeater { id: rep
                 model: Math.floor( Math.sqrt(difx*difx+dify*dify)/50)
                        Rectangle { width: 50; height: 50
                                    color: "lightgreen"

                                    Text { text: "\\/"
                                           font.pointSize: 10
                                           anchors.centerIn: parent } }
//                        rep.itemAt(5). color = "blue";

             }

         }

        //final position is a push button
        PushButton {
            id: goalarea
            x: startx-endx //stimmt nur für ausgewählte fälle
            y: starty-endy
            height: 200
            width : 200
            text : "o"
            visible: true
            opacity: 0.1

            onPressed: infolabel.text = "paaaaasst"
        }


     }

