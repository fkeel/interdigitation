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


  /**********************Begin Instructions**************************************/

  /*********************/
  /**Quarying Methods **/
  /*********************/

  /*
 
   sensor.spikeWidthIs --> returns width of spike as int
   sensor.spikeRatioIs --> returns ratio (height) of spike as int
   sensor.pointSizeIs --> returns touch-point size as float
   
   */

  /**************************/
  /**Visualization Methods **/
  /**************************/

  /*
  --> plot all data 
   sensor.drawStrData(int pressure, int stripIndex, float yScale); 
   
   pressure     --> 0 for Low, 1 for High
   stripIndex   --> 0 - 7
   yScale       --> 1 == 1 pixel per sampled bit, 0.5 == 1 pixel per 2 sampled bits etc.
   
   --> plot average
   drawStripAverage(int pressure, int strip, float scale) 
   
   pressure     --> 0 for Low, 1 for High
   stripIndex   --> 0 - 7
   yScale       --> 1 == 1 pixel per sampled bit, 0.5 == 1 pixel per 2 sampled bits etc.
   
   --> plot Confidence Interval
   sensor.drawStripConfidence(int pressure, int stripIndex, float confidenceInterval, String type, float yScale) 
   
   pressure              --> 0 for Low, 1 for High
   stripIndex            --> 0 - 7
   yScale                --> 1 == 1 pixel per sampled bit, 0.5 == 1 pixel per 2 sampled bits etc.
   confidenceInterval    --> 1.645 ==> 90%, 1.98 ==> 95%
   type                  --> "BLOCKS", "CURVE"
   
   -- plot deltas between xPositions
   sensor.drawStripDelta(int pressure, int stripIndex, float yScale)
   
   drawStripAverage(int pressure, int strip, float scale) 
   pressure     --> 0 for Low, 1 for High
   stripIndex   --> 0 - 7
   yScale       --> 1 == 1 pixel per sampled bit, 0.5 == 1 pixel per 2 sampled bits etc.
   
   -->plot estimate of strip quality (buggy)
   
   Sensor.drawStripQuality(int pressure, int stripIndex, float yScale)
   pressure     --> 0 for Low, 1 for High
   stripIndex   --> 0 - 7
   yScale       --> 1 == 1 pixel per sampled bit, 0.5 == 1 pixel per 2 sampled bits etc.
   */



  /**********************End Instructions**************************/


  /********* global graphics settings ************/

  size(1150, 1050); // for visualizing on screen
  // size(1150, 1050, PDF, "EffectOfDigasdfasdfitWqweIdth6.pdf"); //for exporting to pdf
  // strokeCap(ROUND); //this matters when you zoom in, not sure whats best
  background(255); //white background 
  translate(50, 20); //center stuff so it looks nice
  float ratio = 0.2; //size of the graphs. 0.4 works nice for showing a single sensor/strip




  /********* Draw Things ************/

  //this needs some templates to easily recreate graphs used in paper/documentation
  // (currently have a google doc with some examples)

  //I draw stuff by looping through all my sensor objects. 
  //I filter by the criterea I am looking for and then only visualize for the subset I'm interested in.
  //right now I still do a bunch of things manually, not sure how much I'll update this, but open to requests
  
  //In general I try to keep all the formatting here, so stroke(), fill() strokeWeight() etc should be used on visualizations just as any other processing object

  //the below is messy, if I get around to it I'll organize this better

  fill(120);
  translate( 0, 20);
  text("Digit Width: 35%,  Touch Size: 375%", 750, -4); //name of graph
  drawLegend(ratio); //alternatively drawAbsLegend(ratio) for normalized data

  pushMatrix();
  //draw some graphs
  for (int i = 0; i < fileNames.length; i++) {            //loop through all the files and grab the data of the ones we want
    if (textileSensors[i].spikeWidthIs(35)) {             //filter according to spikeWidth
      if (textileSensors[i].spikeRatioIs(100)) {          //filter according to ratio
        if (textileSensors[i].pointSizeIs(3.75)) {        //filter according to point szie
          for (int x = 0; x < 7; x++) {
            if (x<6) {
              stroke(52*x, 180, 255-(52*x));
              fill(52*x, 180, 255-(52*x), 80);
              strokeWeight(1);
              textileSensors[i].drawStripConfidence(1, x, 1.98, "BLOCKS", ratio);


              //  noStroke();
              stroke(52*x, 180, 255-(52*x));
              strokeWeight(0.5);
              textileSensors[i].drawStripData(1, x, ratio);
              strokeWeight(2);
               fill(52*x, 180, 255-(52*x), 80);
              stroke(52*x, 180, 255-(52*x));
              textileSensors[i].drawStripDelta(1, x, ratio);
            }
          }
        }
      }
    }
  }
  popMatrix();

  translate(0, 1000*ratio+50);
  fill(120);
  text("Digit Width: 55%,  Touch Size: 375%", 750, -4); //name of graph
  drawLegend(ratio); //draw the legend (only correct units for measures, needs to be fixed to work with deltas


  pushMatrix();
  //draw some graphs
  for (int i = 0; i < fileNames.length; i++) {            //loop through all the files and grab the data of the ones we want
    if (textileSensors[i].spikeWidthIs(55)) {             //filter according to spikeWidth
      if (textileSensors[i].spikeRatioIs(100)) {          //filter according to ratio
        if (textileSensors[i].pointSizeIs(3.75)) {        //filter according to point szie
          for (int x = 0; x < 7; x++) {
            if (x<6) {
              stroke(52*x, 180, 255-(52*x));
              fill(52*x, 180, 255-(52*x), 80);
              strokeWeight(1);
              textileSensors[i].drawStripConfidence(1, x, 1.98, "BLOCKS", ratio);


              //  noStroke();
              stroke(52*x, 180, 255-(52*x));
              strokeWeight(0.5);
              textileSensors[i].drawStripData(1, x, ratio);
              strokeWeight(2);
              stroke(52*x, 180, 255-(52*x));
              textileSensors[i].drawStripAverage(1, x, ratio);
            }
          }
        }
      }
    }
  }
  popMatrix();

  translate( 0, 1000*ratio+50);
  fill(120);
  text("Digit Width: 75%,  Touch Size: 375%", 750, -4); //name of graph
  drawLegend(ratio); //draw the legend (only correct units for measures, needs to be fixed to work with deltas

  pushMatrix();
  //draw some graphs
  for (int i = 0; i < fileNames.length; i++) {            //loop through all the files and grab the data of the ones we want
    if (textileSensors[i].spikeWidthIs(75)) {             //filter according to spikeWidth
      if (textileSensors[i].spikeRatioIs(100)) {          //filter according to ratio
        if (textileSensors[i].pointSizeIs(3.75)) {        //filter according to point szie
          for (int x = 0; x < 7; x++) {
            if (x<6) {
              stroke(52*x, 180, 255-(52*x));
              fill(52*x, 180, 255-(52*x), 80);
              strokeWeight(1);
              textileSensors[i].drawStripConfidence(1, x, 1.98, "BLOCKS", ratio);


              //  noStroke();
              stroke(52*x, 180, 255-(52*x));
              strokeWeight(0.5);
              textileSensors[i].drawStripData(1, x, ratio);
              strokeWeight(2);
              stroke(52*x, 180, 255-(52*x));
              textileSensors[i].drawStripAverage(1, x, ratio);
            }
          }
        }
      }
    }
  }
  popMatrix();

  translate( 0, 1000*ratio+50);
  fill(120);
  text("Digit Width: 95%,  Touch Size: 375%", 750, -4); //name of graph
  drawLegend(ratio); //draw the legend (only correct units for measures, needs to be fixed to work with deltas
  pushMatrix();

  //draw some graphs
  for (int i = 0; i < fileNames.length; i++) {            //loop through all the files and grab the data of the ones we want
    if (textileSensors[i].spikeWidthIs(95)) {             //filter according to spikeWidth
      if (textileSensors[i].spikeRatioIs(100)) {          //filter according to ratio
        if (textileSensors[i].pointSizeIs(3.75)) {        //filter according to point szie
          for (int x = 0; x < 7; x++) {
            if (x<6) {
              stroke(52*x, 180, 255-(52*x));
              fill(52*x, 180, 255-(52*x), 80);
              strokeWeight(1);
              textileSensors[i].drawStripConfidence(1, x, 1.98, "BLOCKS", ratio);


              //  noStroke();
              stroke(52*x, 180, 255-(52*x));
              strokeWeight(0.5);
              textileSensors[i].drawStripData(1, x, ratio);
              strokeWeight(2);
              stroke(52*x, 180, 255-(52*x));
              textileSensors[i].drawStripAverage(1, x, ratio);
            }
          }
        }
      }
    }
  }
  popMatrix();
}