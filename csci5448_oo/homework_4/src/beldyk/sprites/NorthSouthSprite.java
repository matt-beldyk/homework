package beldyk.sprites;

import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import javax.swing.Icon;
import javax.swing.ImageIcon;

import beldyk.canvas.Canvas;
import beldyk.movements.NorthSouthMoveBehavior;

public class NorthSouthSprite extends Sprite {

  public NorthSouthSprite(int x, int y) {
    super(x, y);
    images = new HashMap<Direction,Icon>();
    images.put(Direction.NORTH, new ImageIcon("images/north.png"));
    images.put(Direction.SOUTH, new ImageIcon("images/south.png"));
    setImgDirection(Sprite.Direction.NORTH);
    setMvBehavior(new NorthSouthMoveBehavior());
  }

 

}
