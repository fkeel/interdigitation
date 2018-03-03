import processing.pdf.*; //for exporting visualizations
import java.io.BufferedWriter; //log lines
import java.io.FileWriter; //create files

Sensor firstSensor;


void setup() {
  firstSensor = new Sensor("SW35-RATIO100-P250.csv");

  // general graphics settings
  size(1720, 900); // for visualizing on screen
  // size(1620, 1100 , PDF, "nothing.pdf"); //for exporting to pdf
  strokeCap(SQUARE);
  background(255);
  translate(300, 0); //move the zero position towards the lower third of screen (data will be centred around that area)
  //scale(1, -1); //flip screen so +y is up



  firstSensor.drawConfidence("sensor3", "LOW");
  firstSensor.drawData("sensor3", "LOW");
  firstSensor.drawMean("sensor3", "LOW");
}