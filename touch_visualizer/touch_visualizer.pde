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





  /********* global graphics settings ************/

  size(700, 1250); // for visualizing on screen
  //  size(1250, 950, PDF, "Algoriths_CLEAN.pdf"); //for exporting to pdf
  strokeCap(ROUND); //this matters when you zoom in, not sure whats best
  background(255); //white background 
  translate(50, 20); //center stuff so it looks nice




  /********* Draw Things ************/

  //this needs some templates to easily recreate graphs used in paper/documentation
  // (currently have a google doc with some examples)

  //I draw stuff by looping through all my sensor objects. 
  //I filter by the criterea I am looking for and then only visualize for the subset I'm interested in.
  //right now I still do a bunch of things manually, not sure how much I'll update this, but open to requests

  //In general I try to keep all the formatting here, so stroke(), fill() strokeWeight() etc should be used on visualizations just as any other processing object

  //the below is messy, if I get around to it I'll organize this better

  /***Example Template***/

  // vizTestTemplate(ratio);

  /***Memory Effects***/
    println("Width, Length, TouchSize, Algorithm, Error");
    float[][] positions; 
    float mean;
    for (int i = 0; i < fileNames.length; i++) {            //loop through all the files and grab the data of the ones we want
  
    print(textileSensors[i].spikeWidth);
    print(", ");
    print(textileSensors[i].spikeRatio);
    print(", ");
    print(textileSensors[i].pointSize);
    print(", 0");
    print(", NAIVE");
   
    positions = textileSensors[i].returnPeaks("NAIVE", 0);
    mean = meanAbs(positions[2]);
    print(", ");
    println(mean);
    }

 //     if (textileSensors[i].pointSizeIs(1.25)) {             
    //    
       
        /*

  fill(120);
  translate( 0, 20);
  //name of graph
  // drawLegend(ratio); //alternatively drawAbsLegend(ratio) for normalized data

  pushMatrix();
  translate(0, 120);
  fill(0, 200);
  //  text("Digit Height: 55%, 70%, 85%, 100%, Digit Width 35%", 0, -70);

  //draw some graphs
  pushMatrix();
  stroke(100, 0, 0, 120);
  firstRow("CUBIC");
  popMatrix();

  translate(0, 230);

  pushMatrix();
  stroke(0, 0, 100, 120);
  firstRow("MICROCHIP");
  popMatrix();
  
  translate(0, 230);
  
  pushMatrix();
  stroke(0, 100, 0, 120);
  firstRow("COM");
  popMatrix();
  */
}