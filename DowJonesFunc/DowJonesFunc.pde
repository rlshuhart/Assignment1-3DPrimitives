// Dow Jones 
// https://processing.org/reference/loadTable_.html
// https://processing.org/tutorials/data/
// https://processing.org/tutorials/text/
// http://learningprocessing.com/examples/chp17/example-17-03-scrollingtext

// TODO
// fix balloon
// Shift to classes
// Move to eclipse


// initial variables, table and arrays
Table Dow;
int currentRowCount = 0;
int row;
String[] Date;
float[] Close;
float[] priceChange;
float[] pctChange;
PImage wall;
float size;
// ticker
PFont f;  
float x; // Horizontal location
int index = 0;
String[] ticker;

void setup() {
  // create 3D canvas 
  size(800,600, P3D);
  // Load background image
  wall = loadImage("wall.jpg");
  
  loadData();
  ticker();
  
}

void draw() {
   // show background image
   image(wall, 0, 0);
  // Draw Text
    fill(0);
    
   tickerMove();

   balloon();
    
}