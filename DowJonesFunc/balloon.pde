void balloon(){
  
    // Sphere stroke, sphere, translation and rotation. 
  // control sphere, or balloon, size by the close value
    stroke(255, 50);
    translate(250,row + 100, row + 10);
    rotateX(row + 100);
    rotateY(row + 50);
    fill(54,95,152);
    //sphereDetail(row / 4);
    sphere(Close[row]/150);
  // Balloon String    
    //noFill();
    fill(0,0,0);
    //stroke(0, 0, 0);
    bezier(250, 250, 10, 10, 50, 50, 15, 80);
    
}



void keyPressed(){
  // Move down a position in the array with each key click
  // 
  if (row < ticker.length - 1){
    row++;
  }
  else {
    row = 0;
  }
   //println(Date[row] + " ended with a close of "+ Close[row]);
  }