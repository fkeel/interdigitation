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
   
   --> plot all x for specific y (e.g. to show memory effects) 
   sensor.drawStripAtY(int pressure, int yPosition, int stripIndex, float yScale);
   
   pressure     --> 0 for Low, 1 for High
   yPosition    --> 0 to 11, units of 2 mm (or was it 2.5? ASK VICTOR!)
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

  size(1250, 950); // for visualizing on screen
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

  fill(120);
  translate( 0, 20);
  text("Non Interdigitized Sensor, Memory Effect", 750, -4); //name of graph
  // drawLegend(ratio); //alternatively drawAbsLegend(ratio) for normalized data

  pushMatrix();
  translate(0,200);
  //draw some graphs
  for (int i = 0; i < fileNames.length; i++) {            //loop through all the files and grab the data of the ones we want
    if (textileSensors[i].spikeWidthIs(35)) {             //filter according to spikeWidth
      if (textileSensors[i].spikeRatioIs(100)) {          //filter according to ratio
        if (textileSensors[i].pointSizeIs(3.75)) {        //filter according to point szie

          float[][] positions;
          positions = textileSensors[i].returnPeaks_COM(1);
          println(positions.length);
          println(positions[0].length);
          println(positions[1][68]);
          println(positions[1][69]);
          println(positions[1][70]);
          println(positions[1][71]);
          for (int z = 0; z < positions[0].length-1; z++) {
            println("Assigned: " + positions[0][z] + " Error: " + positions[1][z]);
            if (positions[0][z] < 68) {
              line(positions[0][z]*10, positions[1][z]*20, positions[0][z+1]*10, positions[1][z+1]*20);
              ellipse(positions[0][z]*10, 0, 2, 2);
            }
          }
        }
      }
    }
  }
  popMatrix();

  /*
  translate(400, 0);
   pushMatrix();
   //draw some graphs
   for (int i = 0; i < fileNames.length; i++) {            //loop through all the files and grab the data of the ones we want
   if (textileSensors[i].spikeWidthIs(100)) {             //filter according to spikeWidth
   if (textileSensors[i].spikeRatioIs(0)) {          //filter according to ratio
   if (textileSensors[i].pointSizeIs(2.5)) {        //filter according to point szie
   textileSensors[i].drawStripX(1, 20);
   for (int y = 0; y < 11; y++) {
   
   textileSensors[i].drawNaiveCentre(1, 20);
   stroke(23*y, 180, 255-(23*y));
   fill(23*y, 180, 255-(23*y));
   strokeWeight(1.5);
   textileSensors[i].drawCentreOfGravityPerTrial(1, y, 20);
   }
   }
   }
   }
   }
   popMatrix();
   
   
   
   translate(400, 0);
   
   pushMatrix();
   //draw some graphs
   for (int i = 0; i < fileNames.length; i++) {            //loop through all the files and grab the data of the ones we want
   if (textileSensors[i].spikeWidthIs(100)) {             //filter according to spikeWidth
   if (textileSensors[i].spikeRatioIs(0)) {          //filter according to ratio
   if (textileSensors[i].pointSizeIs(3.75)) {        //filter according to point szie
   
   textileSensors[i].drawStripX(1, 20);
   for (int y = 0; y < 11; y++) {
   
   fill(255, 255, 255);
   textileSensors[i].drawNaiveCentre(1, 20);
   fill(255, 0, 0);
   textileSensors[i].drawMicrochip(1, 20);
   fill(0, 255, 0);
   textileSensors[i].drawCubic(1, 20);
   fill(0, 0, 255);
   textileSensors[i].drawCentreOfGravity(1, 20);
   //  stroke(23*y, 180, 255-(23*y));
   // fill(23*y, 180, 255-(23*y));
   strokeWeight(1.5);
   // textileSensors[i].drawCentreOfGravityPerTrial(1, y, 4, 20);
   }
   }
   }
   }
   }
   popMatrix();
   
   translate(-800, 400);
   
   pushMatrix();
   //draw some graphs
   for (int i = 0; i < fileNames.length; i++) {            //loop through all the files and grab the data of the ones we want
   if (textileSensors[i].spikeWidthIs(95)) {             //filter according to spikeWidth
   if (textileSensors[i].spikeRatioIs(100)) {          //filter according to ratio
   if (textileSensors[i].pointSizeIs(1.25)) {        //filter according to point szie
   
   textileSensors[i].drawStripX(1, 20);
   for (int y = 0; y < 11; y++) {
   
   fill(255, 255, 255);
   textileSensors[i].drawNaiveCentre(1, 20);
   fill(255, 0, 0);
   textileSensors[i].drawMicrochip(1, 20);
   fill(0, 255, 0);
   textileSensors[i].drawCubic(1, 20);
   fill(0, 0, 255);
   textileSensors[i].drawCentreOfGravity(1, 20);
   //  stroke(23*y, 180, 255-(23*y));
   // fill(23*y, 180, 255-(23*y));
   strokeWeight(1.5);
   // textileSensors[i].drawCentreOfGravityPerTrial(1, y, 4, 20);
   }
   }
   }
   }
   }
   popMatrix();
   
   translate(400, 0);
   pushMatrix();
   //draw some graphs
   for (int i = 0; i < fileNames.length; i++) {            //loop through all the files and grab the data of the ones we want
   if (textileSensors[i].spikeWidthIs(95)) {             //filter according to spikeWidth
   if (textileSensors[i].spikeRatioIs(100)) {          //filter according to ratio
   if (textileSensors[i].pointSizeIs(2.5)) {        //filter according to point szie
   
   textileSensors[i].drawStripX(1, 20);
   for (int y = 0; y < 11; y++) {
   
   
   
   textileSensors[i].drawNaiveCentre(1, 20);
   stroke(23*y, 180, 255-(23*y));
   fill(23*y, 180, 255-(23*y));
   strokeWeight(1.5);
   textileSensors[i].drawCentreOfGravityPerTrial(1, y, 20);
   }
   }
   }
   }
   }
   popMatrix();
   
   
   
   translate(400, 0);
   
   pushMatrix();
   //draw some graphs
   for (int i = 0; i < fileNames.length; i++) {            //loop through all the files and grab the data of the ones we want
   if (textileSensors[i].spikeWidthIs(95)) {             //filter according to spikeWidth
   if (textileSensors[i].spikeRatioIs(100)) {          //filter according to ratio
   if (textileSensors[i].pointSizeIs(3.75)) {        //filter according to point szie
   
   textileSensors[i].drawStripX(1, 20);
   for (int y = 0; y < 11; y++) {
   
   
   
   fill(255, 255, 255);
   textileSensors[i].drawNaiveCentre(1, 20);
   fill(255, 0, 0);
   textileSensors[i].drawMicrochip(1, 20);
   fill(0, 255, 0);
   textileSensors[i].drawCubic(1, 20);
   fill(0, 0, 255);
   textileSensors[i].drawCentreOfGravity(1, 20);
   //  stroke(23*y, 180, 255-(23*y));
   // fill(23*y, 180, 255-(23*y));
   strokeWeight(1.5);
   // textileSensors[i].drawCentreOfGravityPerTrial(1, y, 4, 20);
   }
   }
   }
   }
   }
   popMatrix();
   */
}