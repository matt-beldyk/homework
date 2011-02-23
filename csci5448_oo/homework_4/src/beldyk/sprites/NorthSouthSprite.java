package beldyk.sprites;

import java.util.LinkedList;
import java.util.List;
import javax.swing.Icon;
import javax.swing.ImageIcon;

import beldyk.canvas.Canvas;
import beldyk.movements.NorthSouthMoveBehavior;

public class NorthSouthSprite extends Sprite {

  public NorthSouthSprite(int x, int y) {
    super(x, y);
    images = new LinkedList<Icon>();
    images.add(new ImageIcon("images/north.png"));
    images.add(new ImageIcon("images/south.png"));
    setDirection(Sprite.Direction.NORTH);
    setMvBehavior(new NorthSouthMoveBehavior());
  }

  public void move(Canvas c) {
	  this.mvBehavior.move(c, this);

  }

  public void animate(Canvas c) {
	  this.mvBehavior.animate(c, this);
     
  }

}
