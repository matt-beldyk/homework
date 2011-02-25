package beldyk.sprites;

import java.awt.Component;
import java.awt.Graphics;
import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import javax.swing.Icon;
import javax.swing.ImageIcon;

import beldyk.canvas.Canvas;
import beldyk.movements.DoNothingMoveBehavior;
import beldyk.movements.KeyboardControlledMoveBehavior;
import beldyk.movements.SpinMoveBehavior;

public class BlueSprite extends Sprite  {

  public BlueSprite(int x, int y) {
    super(x, y);
    images = new HashMap<Direction,Icon>();
    images.put(Direction.NORTH, new ImageIcon("images/BlueNorth.png"));
    images.put(Direction.SOUTH, new ImageIcon("images/BlueSouth.png"));
    images.put(Direction.EAST, new ImageIcon("images/BlueEast.png"));
    images.put(Direction.WEST, new ImageIcon("images/BlueWest.png"));
    images.put(Direction.NONE, new ImageIcon("images/BlueNorth.png"));
    setImgDirection(Sprite.Direction.NONE);
    //  this.mvBehavior = new DoNothingMoveBehavior();
      this.mvBehavior = new SpinMoveBehavior();
  }
  
  /*
  @Override 
  public void draw(Component c, Graphics g) {
    images.get(this.mvBehavior.getMvDirection()).paintIcon(c, g, getX(), getY());
  }
  */


  
  

}
