//for parsing files

float[][] parseFile(String filename) {
  String[] lines = loadStrings(filename);
  String[] classes = split(lines[1], ','); // should probably be zero, if formatted correctly
  float[][] data = new float[lines.length][classes.length]; 

  for (int i = 0; i < classes.length; i++) {
    classes[i] = trim(classes[i]);

  }

  for (int i = 0; i < lines.length; i++) {
    String[] placeHolder = split(lines[i], ','); //create an array of all items in a line

    for (int y = 0; y < placeHolder.length; y++) {

      data[i][y] = float(trim(placeHolder[y])); //trim white spaces, convert to int (the date will be useless)
    }
  }
  return data;
}