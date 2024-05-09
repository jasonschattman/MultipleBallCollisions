class Ball {
  PVector pos, vel, momentum;
  float mass, radius, diameter;
  float left, right, top, bottom;
  color col;
  
  Ball(float M, color c) {
    this.mass = M;
    this.col = c;
    
    this.radius = sqrt( this.mass/(ballDensity*PI) );
    this.diameter = 2 * this.radius;
    
    float gapFromWall = 1.02 * this.radius;
    
    this.pos = new PVector( random( gapFromWall, width-gapFromWall), random(gapFromWall, height-gapFromWall) ); 
    this.vel = new PVector( random(-maxSpeed, maxSpeed), random(-maxSpeed, maxSpeed) );
    this.momentum = PVector.mult( vel, this.mass );
    
    this.left = this.pos.x - this.radius;
    this.right = this.pos.x + this.radius;
    this.top = this.pos.y - this.radius;
    this.bottom = this.pos.y + this.radius;
  }
  
  
  void updatePos(){
    if( this.left < 0  ) {
      this.vel.x *= -1;
      this.pos.x = this.radius;
    }
      
    if( this.top < 0  ) {
      this.vel.y *= -1;
      this.pos.y = this.radius;
    }
     
    if( this.right > width ) {
      this.vel.x *= -1;
      this.pos.x = width-this.radius;
    }
      
    if( this.bottom > height  ) {
      this.vel.y *= -1;
      this.pos.y = height - this.radius;
    }
     
    this.pos.add( this.vel );
    this.vel.mult( friction );
    
    this.left = this.pos.x - this.radius;
    this.right = this.pos.x + this.radius;
    this.top = this.pos.y - this.radius;
    this.bottom = this.pos.y + this.radius;
  }
  
  
  void checkCollision( Ball other ) {
    PVector S = new PVector(other.pos.x-this.pos.x, other.pos.y-this.pos.y);
    float distBetweenCenters = this.radius + other.radius;
    
    if( S.mag() <= distBetweenCenters ) {
      PVector sHat = S.normalize(null);
     
      this.momentum = PVector.mult( this.vel, this.mass );
      other.momentum = PVector.mult( other.vel, other.mass );
      
      float k = other.momentum.dot(sHat) - this.momentum.dot(sHat);
      
      PVector deltaW = PVector.mult(sHat, k/this.mass);
      PVector deltaV = PVector.mult(deltaW, -this.mass/other.mass);
      
      other.vel.add( deltaV );
      this.vel.add( deltaW );
      
      //Anti-clumping
      PVector S_corrected = PVector.mult( sHat, distBetweenCenters * 1.01 ); 
      other.pos = PVector.add( this.pos, S_corrected );
    }
  }
  
  
  void drawMe() {
    fill(this.col);
    circle(this.pos.x, this.pos.y, this.diameter);
  }

}
