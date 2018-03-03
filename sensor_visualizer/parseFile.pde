//"SW100-RATIO0-P125.csv"

float[][] parseFile(String filename) {
  //read data and split it up into smaller arrays that are easyer to work with
  // initialize stuff
  String[] lines = loadStrings(filename);
  String[] classes = split(lines[1], ','); // should probably be zero, if formatted correctly
  float[][] data = new float[lines.length][classes.length]; 


  for (int i = 0; i < classes.length; i++) {
    classes[i] = trim(classes[i]);
    //  println(classes[i]);
  }
  //assign data

  for (int i = 0; i < lines.length; i++) {
    String[] placeHolder = split(lines[i], ','); //create an array of all items in a line


    for (int y = 0; y < placeHolder.length; y++) {

      data[i][y] = float(trim(placeHolder[y])); //trim white spaces, convert to int (the date will be useless)
    }

    // Sanity checks to see if data is read correctly:
    // println(lines[i]);
    // println(classes[i]);
    // println(resistive[i][1]);
    // println(capacitive[i][0]);
  }
  return data;
}