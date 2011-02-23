package beldyk.sprites;

import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import javax.swing.Icon;
import javax.swing.ImageIcon;

import beldyk.canvas.Canvas;
import beldyk.movements.EastWestMoveBehavior;

public class EastWestSprite extends Sprite {

  public EastWestSprite(int x, int y) {
    super(x, y);
    images = new HashMap<Direction,Icon>();
    images.put(Direction.EAST, new ImageIcon("images/east.png"));
    images.put(Direction.WEST, new ImageIcon("images/west.png"));
    super.setDirection(Sprite.Direction.EAST);
    super.setMvBehavior(new EastWestMoveBehavior());
  }

  

}
