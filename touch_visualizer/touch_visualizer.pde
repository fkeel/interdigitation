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

  size(700, 1250); // for visualizing on screen
  //  size(1250, 950, PDF, "Algoriths_CLEAN.pdf"); //for exporting to pdf
  strokeCap(ROUND); //this matters when you zoom in, not sure whats best
  background(255); //white background 
  translate(50, 20); //center stuff so it looks nice


  println("finished!");
  float[][] positions = textileSensors[9].returnPeaks(method[4], 0); 
  
  plotResidualsSummary(positions, 1,2);
  
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