
// rescaled data has dummy line2!!!!

/*-----------Simple
/*- Naive
/*- Linear
 
/*----------- Curve Fitting
/*- Gaussian
/*- Cubic
/*- Parabolic
 
/*----------- Curve Fitting + Filtering
/*- Blais Rioux Detector
 
/*----------- Geometric
/*- Centre Of Mass (COM7)
/*- Microchip (COM3)
 
/*----------- Computer Vision Inspired
/*- Blob
 
/*------------------------------------------------------*/
/* NAIVE - Returns the max strip. Used as reference 
/* algorithm and as helper function for some of the other algorithms
/*------------------------------------------------------*/
int naive(float[] stripValues) { //returns the position with the highest value --> no interpolation

  float maxValue = 0;
  int maxIndex = 0;
  int naivePosition;

  for (int i = 0; i < stripValues.length; i++) {

    if (stripValues[i] > maxValue) {
      maxValue = stripValues[i];
      maxIndex = i;
    }
  }

  naivePosition = maxIndex;
  return naivePosition;
}

/*------------------------------------------------------*/
/* LINEAR - Assumes that the spread of intensity values 
/* before and after the peak is linear.
/*------------------------------------------------------*/
float linear(float[] stripValues) {
  //from: Robert Fisher and K. Naidu. 2001. A Comparison of Algorithms for Subpixel Peak Detection. September 2001. https://doi.org/10.1007/978-3-642-58288-2
  //See also: Humza Akhtar and Ramakrishna Kakarala. 2014. A methodology for evaluating accuracy of capacitive touch sensing grid patterns. IEEE/OSA Journal of Display Technology 10, 8: 672–682. https://doi.org/10.1109/JDT.2014.2312975

  int maxIndex = naive(stripValues);
  int previous = previous(maxIndex);
  int next = next(maxIndex, stripValues);

  float offset;

  if (stripValues[next] > stripValues[previous]) {
    offset = 0.5 * ((stripValues[next] - stripValues[previous]) / (stripValues[maxIndex] - stripValues[previous]));
  } else {
    offset = 0.5 * ((stripValues[next] - stripValues[previous]) / (stripValues[maxIndex] + stripValues[previous]));
  }

  float touchPosition = maxIndex + offset;

  return touchPosition;
}


/*------------------------------------------------------*/
/* GAUSSIAN - Uses the three highest, contiguous intensity 
/* values around the observed peak of the strip and assumes
/* that the observed peak shape fts a Gaussian profile.
/*------------------------------------------------------*/
float gaussian(float[] stripValues) {
  //from: Robert Fisher and K. Naidu. 2001. A Comparison of Algorithms for Subpixel Peak Detection. September 2001. https://doi.org/10.1007/978-3-642-58288-2
  //See also: Humza Akhtar and Ramakrishna Kakarala. 2014. A methodology for evaluating accuracy of capacitive touch sensing grid patterns. IEEE/OSA Journal of Display Technology 10, 8: 672–682. https://doi.org/10.1109/JDT.2014.2312975

  //offset = 0.5 * ( ln(previous)-ln(next) / lg(previous) - 2ln(maxIndex) + ln(next) )
  //log() in processing is the natural logarithm

  int maxIndex = naive(stripValues);
  int previous = previous(maxIndex);
  int next = next(maxIndex, stripValues);
  float offset;
  float a;
  float b;

  //adding small values to prevent -infinity for zero measures
  a = log(stripValues[previous]+0.0001) - log (stripValues[next]+0.0001);
  b = log(stripValues[previous]+0.0001) - 2*log(stripValues[maxIndex]+0.0001) + log(stripValues[next]+0.0001);

  offset = 0.5 * a / b;

  float touchPosition = maxIndex + offset;

  return touchPosition;
}

/*------------------------------------------------------*/
/* CUBIC - Fits a Cubic curve through 
/* the maximum strip value, its preceding strip's value and the two subsequent strips' values
/*
/* Implemented by Cedric Honnet
/*------------------------------------------------------*/
float cubic(float[] niceData) {
  // This function aims to retrieve finger position

  int interFactor = 400; // improves error smoothness
  int stripNumber = 7;
  float retrievedPos = -1;
  float[] y = new float[stripNumber*interFactor];

  // interpolate
  for (int s = 0; s < stripNumber; s++) { // sensor strips
    // avoid overflows
    int s0 = (s-1 < 0)? -1 : s-1;
    int s1 = s;
    int s2 = (s+1 >= stripNumber)? s : s+1;
    int s3 = (s+2 >= stripNumber)? s : s+2;

    for (int i = 0; i < interFactor; i++) { // interpolation steps
      y[i+s*interFactor] = CubicInterpolate(s0<0? 0 : niceData[s0], 
        niceData[s1], 
        niceData[s2], 
        niceData[s3], 
        float(i)/interFactor);
    }
  }

  // Find max index
  float maxArray = max(y);

  for (int i = 0; i < y.length; i++) {
    if (maxArray == y[i]) {
      retrievedPos = i;
      break;
    }
  }

  // retrievedPos *= scaling; // normalize to display
  //retrievedPos += zzUnitWidth/2;

  retrievedPos=retrievedPos/interFactor;


  return retrievedPos+0.5;
}

/////////////////////////////////////////////////////////////////
float CubicInterpolate(float y0, float y1, 
  float y2, float y3, float mu) {
  /* @article{bourke1999interpolation,
   title={Interpolation methods},
   author={Bourke, Paul},
   journal={paulbourke.net/miscellaneous/interpolation},
   year={1999} } */

  float a0, a1, a2, a3, mu2;
  mu2 = mu*mu;

  // Breeuwsma approach:
  a0 = -0.5*y0 + 1.5*y1 - 1.5*y2 + 0.5*y3;
  a1 = y0 - 2.5*y1 + 2*y2 - 0.5*y3;
  a2 = -0.5*y0 + 0.5*y2;
  a3 = y1;

  return (a0*mu*mu2 + a1*mu2 + a2*mu + a3);
}


/*------------------------------------------------------*/
/* PARABOLIC - Fits a prabolic curve through the highest 
/* strip-value and its neighbors.
/*------------------------------------------------------*/
float parabolic(float[] stripValues) {
  //from: Robert Fisher and K. Naidu. 2001. A Comparison of Algorithms for Subpixel Peak Detection. September 2001. https://doi.org/10.1007/978-3-642-58288-2
  //See also: Humza Akhtar and Ramakrishna Kakarala. 2014. A methodology for evaluating accuracy of capacitive touch sensing grid patterns. IEEE/OSA Journal of Display Technology 10, 8: 672–682. https://doi.org/10.1109/JDT.2014.2312975
  //Equivilant to linear interpolation between the values adjacent to the zero-crossing of the first derivitive. See Figure 5 of:
  //                  François Blais and Marc Rioux. 1986. Real-time numerical peak detector. Signal Processing 11, 2: 145–155. https://doi.org/10.1016/0165-1684(86)90033-2 

  int maxIndex = naive(stripValues);
  int previous = previous(maxIndex);
  int next = next(maxIndex, stripValues);
  float offset;

  offset = 0.5 * ((stripValues[previous] - stripValues[next]) / (stripValues[next] - 2*stripValues[maxIndex] + stripValues[previous]));

  float touchPosition = maxIndex + offset;

  return touchPosition;
}

/*------------------------------------------------------*/
/* BLAIS_RIOUX - Uses a filtered version of the 
/* first derivitive and performs linear interpolation 
/* between the values adjacent to the zero crossing
/*------------------------------------------------------*/
float blaisRioux(float[] stripValues) {
  //from: François Blais and Marc Rioux. 1986. Real-time numerical peak detector. Signal Processing 11, 2: 145–155. https://doi.org/10.1016/0165-1684(86)90033-2 
  //As the original peak-detector assumes a continuous stream of data, it needs to be modified for the sensor.
  //We use the modified second order filter suggested in:  Robert Fisher and K. Naidu. 2001. A Comparison of Algorithms for Subpixel Peak Detection. September 2001. https://doi.org/10.1007/978-3-642-58288-2
  int maxIndex = naive(stripValues);
  int previous = previous(maxIndex);
  int next = next(maxIndex, stripValues);
  float offset;

  offset = 0.5 * ( secondOrderFilter(stripValues, maxIndex) /   ( secondOrderFilter(stripValues, maxIndex) - secondOrderFilter(stripValues, previous)));

  return maxIndex + offset;
}


float secondOrderFilter(float[] stripValues, int index) { //for Blais and Rioux Detector

  int previous = previous(index);
  int next = next(index, stripValues);

  float filteredValue;

  filteredValue = previous - next;

  return filteredValue;
}



/*------------------------------------------------------*/
/* CENTRE OF MASS - Assume all strips readings are weights 
/* placed equidistant on an imaginary plank. 
/* Calculate where they would balence.
/*------------------------------------------------------*/
float centreOfMass(float[] weights) { //takes an array of values, and calculates their centre of mass (see https://www.mathsnetalevel.com/2924)

  //Centre of Mass = weightA * positionA + weightB * positionB + weightC * positionC ... / weightA + weightB + weightC ...

  float weightLocation = 0;
  float weightSum = 0;
  float centreOfMass;

  for (int i = 0; i < weights.length; i++) {

    weightLocation = weightLocation + weights[i]*(i); //sum of all weights multiplied by their position
    weightSum = weightSum + weights[i]; //sum of all weights
  }

  centreOfMass = weightLocation / weightSum;
  // println(centreOfMass);
  return centreOfMass;
}







/*------------------------------------------------------*/
/* MICROCHIP - Position is calculated as the centroid of 2 adjacent values
/* Implemented by Cedric Honnet
/*------------------------------------------------------*/
float microchip(float[] niceData) {
  // Retrieval method from Microchip TB3064 white paper (p12):
  // microchip.com/stellent/groups/techpub_sg/documents/devicedoc/en550192.pdf

  float retrievedPos = -1;

  // Find max index
  float maxArray = max(niceData);
  int maxIndex = 0;
  for (int i = 0; i < niceData.length; i++) {
    if (maxArray == niceData[i]) {
      maxIndex = i;
      break;
    }
  }

  float prev = (maxIndex==0)?
    0 : niceData[maxIndex-1];

  float next = (maxIndex>=niceData.length-1)?
    0 : niceData[maxIndex+1];

  retrievedPos = maxIndex + 0.5 * (next - prev) / niceData[maxIndex];

  // Offset TODO?
  retrievedPos += 0.5; //maybe not required as we rescale anyway
  // retrievedPos *= width / stripNumber;

  return (retrievedPos);
}



/*------------------------------------------------------*/
/* BLOB CENTRE - Use Blob Tracking to detect touch-points. Use Centre of Blob for Touch Position. Interpolate and adjust threshold for precision.
/*
/*float blobCentre(float[] stripValues, int interpolations, int threshold) { //returns the position with the highest value --> no interpolation
/*------------------------------------------------------*/

// ToDo