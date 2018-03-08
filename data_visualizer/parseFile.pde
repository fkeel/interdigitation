//for parsing files

int[][][][] parseFile(String filename) {
  String[] lines = loadStrings(filename);

  //create file that is [pressure(2)][x(71)][y(11)][strip(7)]

  int[][][][] data = new int[2][71][11][7]; 

  //  println("created the monster array");

  for (int i = 1; i < lines.length; i++) { //throw away first line
    //    println("Parsing file: " + filename);
    //    print("creating a new split string... ");
    String[] items = split(lines[i], ','); //create an array of all items in a line
    //    println("... done");
    for (int y = 0; y < 7; y++) {
      //      println("writing to array index (" + items[2] + " / " + items[0] + " / " + abs(int(float(items[1])/2.5))+") Value: " + items[y+3]); 
      data[int(items[2])][int(items[0])][abs(int(float(items[1])/2.5))][y] = int(items[y+3]);
    }
  }
  return data;
}

String[] parseFileName(String filename) {
  //example filename "SW100-RATIO0-P125.csv" 


  String[] proporties = splitTokens(filename, "- .");

  proporties[0] = proporties[0].replace('S', '0'); //replace all letters with zero, to make conversion from String to numericals easier
  proporties[0] = proporties[0].replace('W', '0');
  proporties[1] = proporties[1].replace('R', '0');
  proporties[1] = proporties[1].replace('A', '0');
  proporties[1] = proporties[1].replace('T', '0');
  proporties[1] = proporties[1].replace('I', '0');
  proporties[1] = proporties[1].replace('O', '0');
  proporties[2] = proporties[2].replace('P', '0');

  return proporties;
}