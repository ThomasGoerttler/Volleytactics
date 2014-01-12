import QtQuick 2.0
import mtq.widgets 1.0

Rectangle
{
   id: floor
   width: 4096
   height: 2400
   color: "#ff333333"

   property bool alreadyStarted: false;

   function showSelectionButtons ()
   {
       starter.visible = false;
       floorMenu.color = "#ff333333";
       uebung.visible = true;
       pruefung.visible = true;
   //  startImprint.visible = true;

       // Eigentliches abfangen der MouseArea, geht allerding nicht, da man es nicht benutzen kann auf dem Floor.
   /*  uebung.x = xx- 450 ;
       uebung.y = yy - 300;

       pruefung.x = xx + 50;
       pruefung.y = yy  - 300 ;

       startImprint.x = xx - 100;
       startImprint.y = yy - 100; */
   }



   Rotation
   {
       id: buttonsRotation
       origin.x: 0;
       origin.y: 0;
       angle: -45
   }

   function openUebungQML()
   {
       redesign();

       playfield.visible = true;
       playfield.refresh();
   }

   function openPruefungQML()
   {
       redesign();

       playfieldExam.visible = true;
       playfieldExam.refresh();
   }

   function redesign()
   {
       // Vorbereitung für nacher
   //    startImprint.visible = false;
       uebung.x = playfield.playFieldY + 0.75 * playfield.playFieldWidth;
       uebung.y = 0.708 * playfield.playFieldHeight;
       uebung.transform =  buttonsRotation;

       pruefung.x = 1.209 * playfield.playFieldWidth;
       pruefung.y = 0.5625 * playfield.playFieldHeight;
   }

    Rectangle {
       id: floorMenu
       width: 4096
       height: 2400
       color: "#ff888888"
       PushButton
       {
           id: starter
           anchors.fill: parent
           onPressed:
           {
                if (!alreadyStarted)
                {
                    alreadyStarted = true;
                    showSelectionButtons();
                }
           }
       }


       PushButton
       {
           id: uebung
           x: 1500
           y: 1500
           visible: false
           width: 400
           height: 150
           text: "Übung"
           onPressed:
           {
               openUebungQML();
           }
       }

       PushButton
       {
           id: pruefung
           x: 2000
           y: 1500
           width: 400
           visible: false
           height: 150
           text: "Prüfung"
           onPressed:
           {
               openPruefungQML();
           }
       }

       Image
       {
           id: startImprint
           source: "../images/schuhabdruck.png"
           visible: false
           width:200;
           height: 200;
       }

       Playfield
       {
           id: playfield
           visible: false
       }

       PlayfieldExam
       {
           id: playfieldExam
           visible: false
       }
   }
}
