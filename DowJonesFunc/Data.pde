void loadData() {
    
  // load data from Yahoo
  Dow = loadTable("http://chart.finance.yahoo.com/table.csv?s=^DJI&a=0&b=01&c=2016&d=0&e=12&f=2017&g=d&ignore=.csv", "header"); 
  // initial currentRowCount variable with the number of rows
  currentRowCount = Dow.getRowCount();
  // initial Date and Close arrays with the number of rows
  Date = new String[Dow.getRowCount()];
  Close = new float[Dow.getRowCount()];
  ticker = new String[Dow.getRowCount()];

 // Reverse order of close so it will go from past to present
  Close = reverse(Close);

  
  // iterate through the rows of the table and move the values to the arrays
  for (int row=0; row < currentRowCount; row++){
     Date[row] = Dow.getString(row, 0);
     Close[row] = Dow.getFloat(row, 6);
     ticker[row] = Date[row] + " ended with a close of "+ Close[row];
     //println(ticker[row]);
  }
  
}

void ticker() {
  
   // Find close change
  priceChange = new float[Close.length];
  pctChange = new float[Close.length];
  
  for (int i = 1; i < Close.length; i++){
      priceChange[i] = (Close[i-1] - Close[i]);
      pctChange[i] = (Close[i-1] - Close[i])/Close[i] * 100;
      println(Close[i-1] + " change from " + Close[i] + " equals " + nfc(pctChange[i],2) + "%");
  }
  
  // Reverse order of ticker so it scroll past to present
  ticker = reverse(ticker);
  priceChange = reverse(priceChange);
  pctChange = reverse(pctChange);
  
  //ticker
  f = createFont("Arial Bold",22,true); // STEP 2 Create Font
  // Initialize ticker offscreen
  x = width;
}


void tickerMove() {
  
  // Display headline at x location
    textFont(f);
    textAlign (LEFT);
    // A specific String from the array is displayed according to the value of the "index" variable.
    if (index==0){
    text(ticker[index], x, height-20);     
    } else {
      if (priceChange[index-1] < 0){
        fill(255,0,0);
      } else {
        fill(0,255,0);
      }
      text(ticker[index] + " " + nfc(priceChange[index-1], 2) + " (" + nfc(pctChange[index-1],2) + "%)", x, height-20);     
    }
    
    
    // Decrement x
    x = x - 3;
  
    // If x is less than the negative width, then it is off the screen
    // textWidth() is used to calculate the width of the current String.
    float w = textWidth(ticker[index]); 
    if (x < -w) {
      x = width;
      // index is incremented when the current String has left the screen in order to display a new String.
      index = (index + 1) % ticker.length;
    }
    
}