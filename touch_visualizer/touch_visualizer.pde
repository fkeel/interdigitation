import processing.pdf.*; //for exporting visualizations
import java.io.BufferedWriter; //for logging lines
import java.io.FileWriter; //create files

String[] fileNames = loadFileNames(); //list of all names of data files (in the init_filenames tab)
Sensor[] textileSensors = new Sensor[fileNames.length]; //array of object for storing all the data


void setup() {

  //prepare the data
  for (int i = 0; i < fileNames.length; i++) { //loop through filename list and create object for each file
    textileSensors[i] = new Sensor(fileNames[i]);
  }

  // saveResiduals(); 
  // saveDeviations();




  /********* global graphics settings ************/
  int graphWidth = 1700;

  int graphHeight = 800;
 // size(1200, 800, PDF, "figure9.pdf"); // for visualizing on screen
    size(1750, 850); //for exporting to pdf
  strokeCap(ROUND); //this matters when you zoom in, not sure whats best
  background(255); //white background 
  translate(50, 20); //center stuff so it looks nice


  println("finished!");
  translate(0, 100);

  for (int i = 0; i < fileNames.length; i=i+3) {
    if (textileSensors[i].spikeWidthIs(100)) {             //filter according to spikeWidth
      if (textileSensors[i].spikeRatioIs(00)) { 
        if (textileSensors[i].pointSizeIs(1.25)) { 
             translate(-550,0);
          plotAllMethods(i+2);
       
        }
      }
    }
    
     if (textileSensors[i].spikeWidthIs(35)) {             //filter according to spikeWidth
      if (textileSensors[i].spikeRatioIs(100)) { 
        if (textileSensors[i].pointSizeIs(1.25)) { 
          translate(550,0);
          plotAllMethods(i+2);
           
        }
      }
    }
  }
  /*
  positions = textileSensors[9].returnPeaks(method[4], 0);
   plotResiduals(positions, 300, 1);
   
   translate(0,100);
   
   positions = textileSensors[11].returnPeaks(method[4], 0);
   plotResiduals(positions, 300, 1);
   
   translate(0,100);
   
   positions = textileSensors[13].returnPeaks(method[4], 0);
   plotResiduals(positions, 300, 1);
   
  /********* Draw Things ************/
  /*

   for (int i = 0; i < fileNames.length; i++) {      
   for (int m = 0; m < method.length; m++) {   //loop through all methods for low pressure
   }  
   for (int m = 0; m < method.length; m++) {  //loop a second time for high pressure
   positions = textileSensors[i].returnPeaks(method[m], 1);
   for (int z = 0; z < positions[2].length; z++) {
   }
   }
   }
   
   */
}


void drawThreeFingers(int a, int b, int c) {
  pushMatrix();
  plotAllMethods(a);
  translate(550, 0);
  plotAllMethods(b);
  translate(550, 0);
  plotAllMethods(c);
  popMatrix();
}

void drawAllSensorsAllMethods(int graphWidth, int graphHeight) {
  //first row
  for (int i = 0; i < fileNames.length; i=i+3) {

    ///first column

    if (textileSensors[i].spikeWidthIs(95)) {             //filter according to spikeWidth
      if (textileSensors[i].spikeRatioIs(55)) { 
        if (textileSensors[i].pointSizeIs(1.25)) { 
          drawThreeFingers(i, i+1, i+2);
        }
      }

      //filter according to spikeWidth
      if (textileSensors[i].spikeRatioIs(70)) { 
        if (textileSensors[i].pointSizeIs(1.25)) { 
          pushMatrix();
          translate(0, graphHeight);
          drawThreeFingers(i, i+1, i+2);
          popMatrix();
        }
      }

      //filter according to spikeWidth
      if (textileSensors[i].spikeRatioIs(85)) { 
        if (textileSensors[i].pointSizeIs(1.25)) { 
          pushMatrix();
          translate(0, graphHeight*2);
          drawThreeFingers(i, i+1, i+2);
          popMatrix();
        }
      }

      //filter according to spikeWidth
      if (textileSensors[i].spikeRatioIs(100)) { 
        if (textileSensors[i].pointSizeIs(1.25)) { 
          pushMatrix();
          translate(0, graphHeight*3);
          drawThreeFingers(i, i+1, i+2);
          popMatrix();
        }
      }
    }

    ///second column

    if (textileSensors[i].spikeWidthIs(75)) {             //filter according to spikeWidth
      if (textileSensors[i].spikeRatioIs(55)) { 
        if (textileSensors[i].pointSizeIs(1.25)) { 
          pushMatrix();
          translate(graphWidth, 0);
          drawThreeFingers(i, i+1, i+2);
          popMatrix();
        }
      }

      //filter according to spikeWidth
      if (textileSensors[i].spikeRatioIs(70)) { 
        if (textileSensors[i].pointSizeIs(1.25)) { 
          pushMatrix();
          translate(graphWidth, graphHeight);
          drawThreeFingers(i, i+1, i+2);
          popMatrix();
        }
      }

      //filter according to spikeWidth
      if (textileSensors[i].spikeRatioIs(85)) { 
        if (textileSensors[i].pointSizeIs(1.25)) { 
          pushMatrix();
          translate(graphWidth, graphHeight*2);
          drawThreeFingers(i, i+1, i+2);
          popMatrix();
        }
      }

      //filter according to spikeWidth
      if (textileSensors[i].spikeRatioIs(100)) { 
        if (textileSensors[i].pointSizeIs(1.25)) { 
          pushMatrix();
          translate(graphWidth, graphHeight*3);
          drawThreeFingers(i, i+1, i+2);
          popMatrix();
        }
      }
    }

    ///third column

    if (textileSensors[i].spikeWidthIs(55)) {             //filter according to spikeWidth
      if (textileSensors[i].spikeRatioIs(55)) { 
        if (textileSensors[i].pointSizeIs(1.25)) {
          pushMatrix();
          translate(graphWidth*2, 0);
          drawThreeFingers(i, i+1, i+2);
          popMatrix();
        }
      }

      //filter according to spikeWidth
      if (textileSensors[i].spikeRatioIs(70)) { 
        if (textileSensors[i].pointSizeIs(1.25)) { 
          pushMatrix();
          translate(graphWidth*2, graphHeight);
          drawThreeFingers(i, i+1, i+2);
          popMatrix();
        }
      }

      //filter according to spikeWidth
      if (textileSensors[i].spikeRatioIs(85)) { 
        if (textileSensors[i].pointSizeIs(1.25)) { 
          pushMatrix();
          translate(graphWidth*2, graphHeight*2);
          drawThreeFingers(i, i+1, i+2);
          popMatrix();
        }
      }

      //filter according to spikeWidth
      if (textileSensors[i].spikeRatioIs(100)) { 
        if (textileSensors[i].pointSizeIs(1.25)) { 
          pushMatrix();
          translate(graphWidth*2, graphHeight*3);
          drawThreeFingers(i, i+1, i+2);
          popMatrix();
        }
      }
    }

    ///fourth column

    if (textileSensors[i].spikeWidthIs(35)) {             //filter according to spikeWidth
      if (textileSensors[i].spikeRatioIs(55)) { 
        if (textileSensors[i].pointSizeIs(1.25)) { 
          pushMatrix();
          translate(graphWidth*3, 0);
          drawThreeFingers(i, i+1, i+2);
          popMatrix();
        }
      }

      //filter according to spikeWidth
      if (textileSensors[i].spikeRatioIs(70)) { 
        if (textileSensors[i].pointSizeIs(1.25)) { 
          pushMatrix();
          translate(graphWidth*3, graphHeight);
          drawThreeFingers(i, i+1, i+2);
          popMatrix();
        }
      }

      //filter according to spikeWidth
      if (textileSensors[i].spikeRatioIs(85)) { 
        if (textileSensors[i].pointSizeIs(1.25)) { 
          pushMatrix();
          translate(graphWidth*3, graphHeight*2);
          drawThreeFingers(i, i+1, i+2);
          popMatrix();
        }
      }

      //filter according to spikeWidth
      if (textileSensors[i].spikeRatioIs(100)) { 
        if (textileSensors[i].pointSizeIs(1.25)) { 
          pushMatrix();
          translate(graphWidth*3, graphHeight*3);
          drawThreeFingers(i, i+1, i+2);
          popMatrix();
        }
      }
    }
  }
}