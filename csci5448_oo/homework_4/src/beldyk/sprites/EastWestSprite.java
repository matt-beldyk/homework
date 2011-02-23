package beldyk.sprites;

import java.util.LinkedList;
import java.util.List;
import javax.swing.Icon;
import javax.swing.ImageIcon;

import beldyk.canvas.Canvas;
import beldyk.movements.EastWestMoveBehavior;

public class EastWestSprite extends Sprite {

  public EastWestSprite(int x, int y) {
    super(x, y);
    images = new LinkedList<Icon>();
    images.add(new ImageIcon("images/east.png"));
    images.add(new ImageIcon("images/west.png"));
    super.setDirection(Sprite.Direction.EAST);
    super.setMvBehavior(new EastWestMoveBehavior());
  }

  

}
