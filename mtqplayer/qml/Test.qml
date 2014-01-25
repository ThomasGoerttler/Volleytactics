import QtQuick 2.0
import mtq.widgets 1.0


Rectangle {
     width: 400; height: 70; color: "black"
     transform: Rotation { origin.x: 25; origin.y: 25; angle: 45}

     Repeater {
       id:mmm
       model : 10
       Rectangle{
         clip: true
         width: 54
         height: 80
         color:"transparent"
         property int imageX: 0 //adding property here

         Image {
           id:imgx
           x: parent.imageX //setting property as the target
           source: "../images/volleyball.png"
         }
         onPropertyChange: {
           mmm.itemAt(1).imageX = 60 //the index defines which rectangle you change
         }
       }
     }
 }
