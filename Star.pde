class Star
{
  PVector pos;
  color colour;
  float theta;
  int points=(int)random(5,10);
  float radius=random(15,20)*width/600;
  
  Star(PVector pos, color colour)
  {
    this.pos=pos;
    this.colour=colour;
    this.theta=0;
  }
  
  void update()
  {
    pos.x -= players.get(0).x_speed;
    pos.y+=1*(y_spd_mod);
    theta+=0.01f;
  }
  
  void display()
  {
    stroke(colour);
    //rect(pos.x,pos.y,cellSize,cellSize);
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(theta);
    
    float px, py;
    float lastx = 0, lasty = -radius;
    float theta1 = 0;
    float thetaInc = TWO_PI / (points * 2);
    
    for(int i = 0 ; i < (points * 2) ; i ++)
    {
      theta1 += thetaInc;
      if (i % 2 == 1)
      {
        px = sin(theta1) * radius;
        py = -cos(theta1) * radius;
      }
      else
      {
        px = sin(theta1) * (radius * 0.5f);
        py = -cos(theta1) * (radius * 0.5f);
      }
      line(lastx, lasty, px, py);
      lastx = px;
      lasty = py;
      
    }
    
    popMatrix();
  }
  
  boolean collision()
  {
    // Its easier to check if they DONT colide
    if (pl.x + playerSize < pos.x)
    {
      return false;
    }
    if (pl.x > pos.x + cellSize)
    {
      return false;
    } 
    
    if (pl.y > pos.y + cellSize)
    {
      return false;
    }
    
    if (pl.y + playerSize < pos.y)
    {
      return false;
    }
    // If none of the above then there is a collision
    if(health<100)
    {
      health+=points;
    }
    sound();
    return true;
  }
  
  void sound()
  {
    healthup.rewind();
    healthup.play();
  }
}
