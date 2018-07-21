

float mean(float[] data) {
  int counter = 0;
  float total = 0;
  for (int i = 0; i < data.length; i++) {
    total = total+ data[i];
    counter++;
  }
  float mean = total / counter;
  return mean;
}


float standardDeviation(float[] data) {
  int n = 0;
  float total = 0;  
  float variance = 0;
  float sd;
  float average = mean(data);

  for (int i = 0; i < data.length; i++) {
    total = total + sq(data[i]-average);
    n++;
  }

  variance = total / n-1; // kinda confused when its n and when its n-1
  sd = sqrt(variance);
  return sd;
}


float slope(float[] dataX, float[] dataY) {
  //x independent
  //y dependent
  // slope = ( n*sum(x*y)-sum(x)*sum(y) ) / n*sum(squared(x)) - squared(sum(x))

  if (dataX.length != dataY.length) { 
    println("ERROR - X and Y arrays not equal length. Cannot calculate slope");
  }

  float slope;
  float sumX = 0;
  float sumY= 0;
  float sumXsquared= 0;
  float sumXY= 0;
  float n = 0;

  for (int i = 0; i < dataX.length; i++) {
    sumX = sumX + dataX[i];
    sumY = sumY + dataY[i];
    sumXsquared = sumXsquared + dataX[i]*dataX[i];
    sumXY= sumXY + dataX[i]*dataY[i];
    n = n + 1;
  }

  slope = (n * sumXY - sumX * sumY) / (n * sumXsquared - sumX*sumX);

  return slope;
}


float intercept(float[] dataX, float[] dataY) {
  //x independent
  //y dependent
  // intercept = ((sum(y)*sum(squared(x)) - sum(x)*sum(x*y)) / n*sum(squared(x)) - squared(sum(x))

  float intercept;
  float sumX = 0;
  float sumY= 0;
  float sumXsquared= 0;
  float sumXY= 0;
  float n = 0;

  for (int i = 0; i < dataX.length; i++) {
    sumX = sumX + dataX[i];
    sumY = sumY + dataY[i];
    sumXsquared = sumXsquared + dataX[i]*dataX[i];
    sumXY= sumXY + dataX[i]*dataY[i];
    n = n + 1;
  }

  intercept = (sumY * sumXsquared - sumX * sumXY) / (n * sumXsquared - sumX*sumX);

  return intercept;
}

float correlation(float[] dataX, float[] dataY) {

  float correlation;
  float sumXdeviation = 0;
  float sumYdeviation = 0;
  float meanX = 0;
  float meanY = 0;
  float sdX = 0;
  float sdY = 0;
  float n = 0;
  
  meanX = mean(dataX);
  meanY = mean(dataY);
  sdX = standardDeviation(dataX);
  sdY = standardDeviation(dataY);

  for (int i = 0; i < dataX.length; i++) {
    sumXdeviation = sumXdeviation + dataX[i] - meanX;
     sumYdeviation = sumYdeviation + dataY[i] - meanY;
    n = n + 1;
  }

  correlation = (sumXdeviation *  sumYdeviation) / (sdX * sdY);

  return correlation;
}

float[] simpleSmooth(float[] data) {
  data[0] = (data[0]*2+data[1])/3;
  for (int i = 1; i < data.length-1; i++) {
    data[i] = (data[i-1]+data[i+1]+data[i])/3;
  }
  data[data.length-1] =  (data[data.length-2] +  data[data.length-1]*2)/3; 

  return data;
}