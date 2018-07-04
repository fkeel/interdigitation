import processing.pdf.*; //for exporting visualizations
import java.io.BufferedWriter; //log lines
import java.io.FileWriter; //create files

String[] lines; //stores raw data
String[] fileNames = loadFileNames(); //list of all files

void setup() {

  for (int fileID = 0; fileID < fileNames.length; fileID++) {
    //do this for each file
    lines = loadStrings(fileNames[fileID]); //create lines
    // appendTextToFile("new/"+fileNames[fileID], "timestamp,  deadSpace,  offset,  spikeWidth,  ratio,  Y,  X,  Z,  area,  strip1,  strip2,  strip3,  strip4,  strip5,  strip6,  strip7" + "\r\n");

    for (int i = 0; i < lines.length; i++) {

      //do this for each line
      String[] lineArray = split(lines[i], ','); //create an array of all items in a line
      String dataToWrite = "";

      dataToWrite = dataToWrite + trim(lineArray[6]) + ","; 
      dataToWrite = dataToWrite + trim(lineArray[5]) + ","; 
      if (i<1) {
        dataToWrite = dataToWrite + trim(lineArray[7]) + ",";
      } else if (i<782) {
        dataToWrite = dataToWrite + "0,";
      } else if (i<1563) {
        dataToWrite = dataToWrite + "1,";
      } else {
        println("THIS SHOULD NEVER HAPPEN");
      }


      dataToWrite = dataToWrite + trim(lineArray[9]) + ","; 
      dataToWrite = dataToWrite + trim(lineArray[10]) + ","; 
      dataToWrite = dataToWrite + trim(lineArray[11]) + ","; 
      dataToWrite = dataToWrite + trim(lineArray[12]) + ","; 
      dataToWrite = dataToWrite + trim(lineArray[13]) + ","; 
      dataToWrite = dataToWrite + trim(lineArray[14]) + ","; 
      dataToWrite = dataToWrite + trim(lineArray[15]) ; 


      //do this for each line
      appendTextToFile("new/"+fileNames[fileID], dataToWrite + "\r\n");
     // print(".");
    }
   // println("File Complete");    //print statements make this a *lot* slower than it needs to be
    //do this for each file
  }
}