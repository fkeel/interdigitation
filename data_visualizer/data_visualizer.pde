import processing.pdf.*; //for exporting visualizations
import java.io.BufferedWriter; //for logging lines
import java.io.FileWriter; //create files

String[] fileNames = loadFileNames(); //list of all names of data files (in the init_filenames tab)
Sensor[] textileSensors = new Sensor[fileNames.length]; //array of object for storing all the data


void setup() {

  for (int i = 0; i < fileNames.length; i++) { //loop through filename list and create object for each file
    textileSensors[i] = new Sensor(fileNames[i]);
  }


  //methods for checking sensor properties available
  //sensor.spikeWidthIs --> returns width of spike as int
  //sensor.spikeRatioIs --> returns ratio (height) of spike as int
  //sensor.pointSizeIs --> returns touch-point size as float
  //high & low pressure need to be specified by parameters

  //visualization methods available
  //sensor.drawData --> plot all data
  //sensor.drawMean --> plot average
  //sensor.drawConfidence --> plot 95% confidence interval
  //sensor.drawChange --> plot absolute difference difference between measures for consecutive touch positions
  //sensor.drawBaseline --> plot plot


  // general graphics settings
   size(1150, 1000); // for visualizing on screen
  //  size(1150, 1000, PDF, "DeltasComparison_NoInterdig.pdf"); //for exporting to pdf
  //   strokeCap(SQUARE); //this matters when you zoom in, not sure whats best
  background(255); //white background 
  translate(50, 50); //center stuff so it looks nice


  //legend
  fill(120);
  text("Non-Interdigitized Sensor, Strips #1 - 5, High Pressure, Touch Size: 125%", 650, -4); //name of graph
  drawLegend(0.25); //draw the legend (only correct units for measures, needs to be fixed to work with deltas
  pushMatrix();
  // translate(-50, 0);
  //draw some graphs
  for (int i = 0; i < fileNames.length; i++) {            //loop through all the files and grab the data of the ones we want
    if (textileSensors[i].spikeWidthIs(100)) {             //filter according to spikeWidth
      if (textileSensors[i].spikeRatioIs(0)) {          //filter according to ratio
        if (textileSensors[i].pointSizeIs(1.25)) {        //filter according to point szie

          for (int j = 0; j < 7; j++) {
            //  textileSensors[i].drawStripDelta(1, j);
          }
          for (int x = 0; x < 5; x++) {
            stroke(62*x, 180, 255-(62*x));
            strokeWeight(3);

            textileSensors[i].drawStripDelta(1, x, 0.25);
          }
        }
      }
    }
  }
  popMatrix();
  translate(0, 300);
  fill(120);
  text("Non-Interdigitized Sensor, Strips #1 - 5, High Pressure, Touch Size: 250%", 650, -4); //name of graph
  drawLegend(0.25); //draw the legend (only correct units for measures, needs to be fixed to work with deltas

  pushMatrix();
  // translate(20, 0);
  //draw some graphs
  for (int i = 0; i < fileNames.length; i++) {            //loop through all the files and grab the data of the ones we want
    if (textileSensors[i].spikeWidthIs(100)) {             //filter according to spikeWidth
      if (textileSensors[i].spikeRatioIs(0)) {          //filter according to ratio
        if (textileSensors[i].pointSizeIs(2.5)) {        //filter according to point szie
          for (int j = 0; j < 7; j++) {
            //  textileSensors[i].drawStripDelta(1, j);
          }
          for (int x = 0; x < 5; x++) {
            stroke(62*x, 180, 255-(62*x));
            strokeWeight(3);
            textileSensors[i].drawStripDelta(1, x, 0.25);
          }
        }
      }
    }
  }
  popMatrix();

  translate(0, 300);
  fill(120);
  text("Non-Interdigitized Sensor, Strips #1 - 5, High Pressure, Touch Size: 375%", 650, -4); //name of graph
  drawLegend(0.25); //draw the legend (only correct units for measures, needs to be fixed to work with deltas

  //draw some graphs
  for (int i = 0; i < fileNames.length; i++) {            //loop through all the files and grab the data of the ones we want
    if (textileSensors[i].spikeWidthIs(100)) {             //filter according to spikeWidth
      if (textileSensors[i].spikeRatioIs(0)) {          //filter according to ratio
        if (textileSensors[i].pointSizeIs(3.75)) {        //filter according to point szie
          for (int j = 0; j < 7; j++) {
            //  textileSensors[i].drawStripDelta(1, j);
          }
          for (int x = 0; x < 5; x++) {
           stroke(62*x, 180, 255-(62*x));
            strokeWeight(3);
            textileSensors[i].drawStripDelta(1, x, 0.25);
          }
        }
      }
    }
  }
}