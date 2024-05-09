int numBalls = 2;

float smallestMass = 1.0;
boolean ballsEqualMass = false;
float massIncreaseRate = 5;
float ballDensity = 0.0002;  //mass per square-pixel
float maxSpeed = 2;
float friction = 1;

Ball[] balls;
color[] billiardColours;


void setup(){
  size(400,400);
  
  setColours();
  setBalls();
}


void draw(){
  background(0, 200, 0);
  
  for( int i = 0; i < numBalls; i++ ) {
    balls[i].drawMe();
    balls[i].updatePos(); 
    
    for( int j = i+1; j < numBalls; j++ ) 
      balls[i].checkCollision( balls[j] );
  }
}
