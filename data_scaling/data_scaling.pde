import processing.pdf.*; //for exporting visualizations
import java.io.BufferedWriter; //log lines
import java.io.FileWriter; //create files

String[] lines; //stores raw data
float[][] allData; //2dArray for all data
String[] fileNames = loadFileNames(); //list of all files

//format of each line: X,Y,Z,strip1,strip2,strip3,strip4,strip5,strip6,strip7

float[] max = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
float[] previous = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
float k = 0.95;

void setup() {

  println("Checking for files");
  for (int fileID = 0; fileID < fileNames.length; fileID++) { //do this for each file.
    //do this for each file
  println("found: " );
    lines = loadStrings(fileNames[fileID]); //create lines
    String[] lineArray = split(lines[3], ',');
    allData = new float[lines.length][lineArray.length];

    for (int i = 0; i < lineArray.length; i++) { //reset lowpass filter + max variables
      max[i] = 0;
      previous[i] = 99999;
    }


    for (int i = 1; i < lines.length; i++) {
      if (allData[i][0] == 0) { //if X is at position zero restart the filtering process
        for (int y = 3; y < lineArray.length; y++) {  //assign initial variable
          previous[y] = allData[i][y]; //for filtering
        }
      } else if (allData[i][0] == 0) { //lowpass filter all positions after pos 0
        for (int y = 3; y < lineArray.length; y++) {  //lowpassFilter each strip value
          allData[i][y] = previous[y] + (k * (allData[i][y] - previous[y])); 
          previous[y] = allData[i][y]; //for filtering
        }
      }
    }


    for (int i = 0; i < lines.length; i++) {

      for (int y = 3; y < lineArray.length; y++) {  //find max
        if (allData[i][y]>max[y]) {
          max[y] = allData[i][y];
        }
      }
    }

    for (int i = 0; i < lines.length; i++) {

      //invert and rescale
      //set max to max * 0,95
      //set min to 40
      //if strip>max*0.95, strip = max*0.95
      //map(strip, 40, max * 0,95, 0, 1);
      //if strip <0, strip = 0;

      for (int y = 3; y < lineArray.length; y++) {  //find max
        map(allData[i][y], 40, max[y] * 0.95, 0, 1);
        constrain(allData[i][y], 0, 1);
      }
    }


    for (int i = 0; i < lines.length; i++) {
      String dataToWrite = "";
      for (int y = 0; y < lineArray.length; y++) {
        if (y+1 < lineArray.length) { 
          dataToWrite = dataToWrite + allData[i][y] + ",";
        } else {
          dataToWrite = dataToWrite + allData[i][y];
        }
      }
      //do this for each line
      appendTextToFile("new/"+fileNames[fileID], dataToWrite + "\r\n");
    }
  }
  println("File Complete");    //print statements make this a *lot* slower than it needs to be
  //do this for each file
}