ArrayList<Block> blocks = new ArrayList<Block>();
class VisibleBoard {
  
  VisibleBoard() {
    int blockheight = 8;
    for (int i=0;i<50;i++) {
      blocks.add(new Block(blockheight,20));
      if (random(1) < .10) {
        if (random(1) < .5) {
          if (blockheight > 0) blockheight--;
        } else if (blockheight < 15) blockheight++;
      }
    }
  }
  
  int stepforward() {
    //Block Cleanup
    for(int i=0;i<blocks.size();i++)
    {
      if(blocks.get(i).block_x < 0-(blocks.get(i).w)*4)
      {
        blocks.remove(i);
      }
    }
    
    int blockheight;
    blockheight = ((Block)blocks.get(blocks.size()-1)).h;
    
    if (random(1) < .10)
    {
      if (random(1) < .5) 
      {
        if (blockheight > 1) blockheight--;
      } 
      else 
      {
        if (blockheight < 15) blockheight++;
      }
      
      blocks.add(new Block(blockheight,20));
      blocks.remove(0); 
      return ((Block)blocks.get(blocks.size()-1)).w;
    } 
    else if (random(1) < .2) 
    {
      int i;
      for(i=0;i<(int)random(4,8);i++)
      {
        blocks.add(new Block(0,20));
      }
      blocks.add(new Block(blockheight,20));
      blocks.remove(0);
      return (20*i)+20;
    } 
    else 
    {
      blocks.add(new Block(blockheight,20));
      blocks.remove(0);
      return ((Block)blocks.get(blocks.size()-1)).w;
    }
    //return the width of the right-most block
    //return ((Block)blocks.get(blocks.size()-1)).w;
  }
  
  void displayboard(float position,int offset) {
    Block block;
    int x=width+offset;
    for (int i=(blocks.size()-1);i>1;i--) {
      block = (Block)blocks.get(i);
      block.displayblock(x);
      block = (Block)blocks.get(i-1);
      x = x-block.w;
    }
  }
  
  int widthoflastblock() {
    return ((Block)blocks.get(0)).w;
  }
  
  
  float find_floor(float x1, float w) {
    
    //the purpose of this function is to find the highest point
    //betwee x and x+w (those represent the feet of the character)
    x1 -= 100;
    float x2 = x1+w;
    float the_floor = height*2;
    Block block;
    int x=width+offset;
    boolean show = false;
    if (random(1) > .98) show = true;
    
    for (int i=(blocks.size()-1);i>1;i--) {
      block = (Block)blocks.get(i);
      
      //falls off a forward edge too soon
      //  if ((x >= x1) && (x <= x2)) {
      // x - start of square
      if (((x >= x1-block.w) && (x <= x2))) {
        if (block.top_y < the_floor) {
          the_floor = block.top_y;
        }
      }
      x = x-block.w;
    }
    return the_floor;  
  }
  
  
}
