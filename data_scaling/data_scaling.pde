import processing.pdf.*; //for exporting visualizations
import java.io.BufferedWriter; //log lines
import java.io.FileWriter; //create files

String[] lines; //stores raw data
float[][] allData; //2dArray for all data
String[] fileNames = loadFileNames(); //list of all files

//format of each line: X,Y,Z,strip1,strip2,strip3,strip4,strip5,strip6,strip7

float[] max = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
float[] min = { 9999, 9999, 9999, 9999, 9999, 9999, 9999, 9999, 9999, 9999};
float[] previous = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
float k = 0.9;

void setup() {

  // println("Checking for files");
  for (int fileID = 0; fileID < fileNames.length; fileID++) { //do this for each file.
    //do this for each file
    // // println("found: " + fileID);
    lines = loadStrings(fileNames[fileID]); //create lines
    String[] lineArray = split(lines[3], ',');
    allData = new float[lines.length][lineArray.length];

    for (int i = 0; i < lineArray.length; i++) { //reset lowpass filter + max variables
      max[i] = 0;
      previous[i] = 123456;
      min[i] = 9999;
    }


    //populate the array
    // println("Populate Array");
    for (int i = 1; i < lines.length; i++) {
      String[] lineArrayb = split(lines[i], ',');
      for (int y = 0; y < lineArrayb.length; y++) {  //assign initial variable
        allData[i][y] = float(lineArrayb[y]); //for filtering
      }
    }
    // println(allData[15]);


    // println("Lowpass Filter:");
    for (int i = 1; i < lines.length; i++) {
      if (allData[i][0] == 0) { //if X is at position zero restart the filtering process
        //// println("prepping filter: " + allData[i][0]);
        for (int y = 3; y < lineArray.length; y++) {  //assign initial variable
          previous[y] = allData[i][y]; //for filtering
        }
      } else { //lowpass filter all positions after pos 0

        for (int y = 3; y < lineArray.length; y++) {  //lowpassFilter each strip value
          allData[i][y] = previous[y] + (k * (allData[i][y] - previous[y])); 
          previous[y] = allData[i][y]; //for filtering
        }
      }
    }
    // println(allData[15]);


    // println("finding max");
    for (int i = 1; i < lines.length; i++) {

      for (int y = 3; y < lineArray.length; y++) {  //find max
        if (allData[i][y]>max[y]) {
          max[y] = allData[i][y];
        }

        if (allData[i][y]<min[y]) {
          min[y] = allData[i][y];
        }
      }
    }
    // println(allData[15]);


    // println("rescaling");
    for (int i = 1; i < lines.length; i++) {

      //invert and rescale
      //set max to max * 0,95
      //set min to 40
      //if strip>max*0.95, strip = max*0.95
      //map(strip, 40, max * 0,95, 0, 1);
      //if strip <0, strip = 0;

      for (int y = 3; y < lineArray.length; y++) {  //find max
        if (min[y] > 80) {
          min[y] = 40;
        }
        allData[i][y] = map(allData[i][y], max[y] * 0.95, min[y], 0, 1);
        allData[i][y] = constrain(allData[i][y], 0, 1);
      }
    }


    // println(allData[15]);
    // println("// printing to file");
    for (int i = 1; i < lines.length; i++) {
      //    // println("starting a line");
      String dataToWrite = "";
      for (int y = 0; y < lineArray.length; y++) {
        if (y == 0 || y == 2 ) {
          dataToWrite = dataToWrite + int(allData[i][y]) + ", ";
        } else if (y == 1) {
          dataToWrite = dataToWrite + allData[i][y] + ", ";
        } else if (y+1 < lineArray.length) { 
          dataToWrite = dataToWrite + nf(allData[i][y], 1, 4) + ", ";
        } else {
          dataToWrite = dataToWrite + nf(allData[i][y], 1, 4);
        }
      }
      //do this for each line
      //nf(num, left, right)
      //  // println("writing to file");
      appendTextToFile("new/"+fileNames[fileID], dataToWrite + "\r\n");
    }
    println("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX    File Complete");    //// print statements make this a *lot* slower than it needs to be
    //do this for each file
  }

  println("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX   All Files Complete");
}