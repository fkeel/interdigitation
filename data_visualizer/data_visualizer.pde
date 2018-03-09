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
  size(1150, 1050); // for visualizing on screen
  // size(1150, 1050, PDF, "EffectOfDigasdfasdfitWqweIdth6.pdf"); //for exporting to pdf
  strokeCap(ROUND); //this matters when you zoom in, not sure whats best
  background(255); //white background 
  translate(50, 20); //center stuff so it looks nice

  float ratio = 0.2;
  //legend


  fill(120);


  translate( 0, 20);
  text("Digit Width: 35%,  Touch Size: 375%", 750, -4); //name of graph
  drawLegend(ratio); //draw the legend (only correct units for measures, needs to be fixed to work with deltas

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
              stroke(52*x, 180, 255-(52*x));
              textileSensors[i].drawStripAverage(1, x, ratio);
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