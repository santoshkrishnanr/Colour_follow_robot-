
import processing.io.*;
import gohai.glvideo.*;
GLCapture video;
// from processing track color tutorial 
int r=255,g=255,b=255;

color trackColor;

void setup() {
  size(320, 220, P2D);

  video = new GLCapture(this);

  video.start();
  
  GPIO.pinMode(4, GPIO.OUTPUT);
  GPIO.pinMode(14, GPIO.OUTPUT);
  GPIO.pinMode(17, GPIO.OUTPUT);
  GPIO.pinMode(18, GPIO.OUTPUT);
}

void draw() {
   background(0);
  if (video.available()) {
    video.read();
  }
  
  video.loadPixels();
  image(video, 0, 0);
  
  float worldRecord = 500; 
  int closestX = 0;
  int closestY = 0;
  
  // Begin loop to walk through every pixel and compare it with given color 
  for (int x = 0; x < video.width; x ++ ) {
    for (int y = 0; y < video.height; y ++ ) {
      int loc = x + y*video.width;
      // What is current color
      color currentColor = video.pixels[loc];
      float r1 = red(currentColor);
      float g1 = green(currentColor);
      float b1 = blue(currentColor);
      float r2 = r;
      float g2 = g;
      float b2 = b;
      
      float d = dist(r1, g1, b1, r2, g2, b2); // We are using the dist( ) function to compare the current color with the color we are tracking.

      // If current color is more similar to tracked color than
      // closest color, save current location and current difference
      if (d < worldRecord) {
        worldRecord = d;
        closestX = x;
        closestY = y;
      }
    }
  }
  
  if (worldRecord < 10) { 
    
    fill(trackColor);
    strokeWeight(2.0);
    stroke(100,0,0);
    rect(closestX, closestY, 10,10);
    
     println(r);
     println(g);
     println(b);
     
    if (closestX<140)
    {
     GPIO.digitalWrite(4, GPIO.HIGH);
     GPIO.digitalWrite(14, GPIO.HIGH);
     GPIO.digitalWrite(17, GPIO.HIGH);
     GPIO.digitalWrite(18, GPIO.LOW);
     delay(20);
     
     println("Right"); 
    }
    else if (closestX>200)
    {
     GPIO.digitalWrite(4, GPIO.HIGH);
     GPIO.digitalWrite(14, GPIO.LOW);
     GPIO.digitalWrite(17, GPIO.HIGH);
     GPIO.digitalWrite(18, GPIO.HIGH);
     delay(20);
    
     println(" Left"); 
    }
    else if (closestY<170)
    {
     GPIO.digitalWrite(4, GPIO.HIGH);
     GPIO.digitalWrite(14, GPIO.LOW);
     GPIO.digitalWrite(17, GPIO.HIGH);
     GPIO.digitalWrite(18, GPIO.LOW);
     delay(20);
    
     println("Go Frwd"); 
   
    }
    else
     {
     GPIO.digitalWrite(4, GPIO.HIGH);
     GPIO.digitalWrite(14, GPIO.LOW);
     GPIO.digitalWrite(17, GPIO.HIGH);
     GPIO.digitalWrite(18, GPIO.LOW);
     delay(20);delay(20);
     }   
  }
  else
 
}

void keyPressed(){                     // entring the color which has to be followed 
  if (keyPressed){
    if (key == 'r' || key =='R')
   {  r = 121;
      g = 21;
      b = 35;
    println("red");}
    else if(key == 'g' || key =='G')
   {  r = 67;
      g = 115;
      b = 52;
    println("green");}
    
    else if(key == 'b' || key =='B')
   {  r = 62;
      g = 92;
      b = 142;
    println("red");} 
  }
else {r=0;
g=0;
b=0;
}}
