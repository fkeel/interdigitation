float[] simpleSmooth(float[] data) {
  data[0] = (data[0]*2+data[1])/3;
  for (int i = 1; i < data.length-1; i++) {
    data[i] = (data[i-1]+data[i+1]+data[i])/3;
  }
  data[data.length-1] =  (data[data.length-2] +  data[data.length-1]*2)/3; 

  return data;
}

float mean(float[] data) {
  int counter = 0;
  float total = 0;
  for (int i = 0; i < data.length; i++) {
    total = total+ data[i];
    // println("total of: " + data[i]);
    counter++;
  }
  float mean = total / counter;
  return mean;
}


float standardDeviation(float[] data) {
  int counter = 0;
  float total = 0;  
  float variance = 0;
  float sd;
  float average = mean(data);

  for (int i = 0; i < data.length; i++) {
    //   println("sq of: " + data[i]);
    total = total + sq(data[i]-average);
    counter++;
  }

  variance = total / counter;
  sd = sqrt(variance);
  return sd;
}


float confidenceInterval(float[] data, float interval) { //this needs updating for DF, they are currently hardcoded
  float ci;
  int n = data.length;
  float sd = standardDeviation(data);
  ci = interval * 2.228 * (sd/sqrt(n));
  return ci;
}