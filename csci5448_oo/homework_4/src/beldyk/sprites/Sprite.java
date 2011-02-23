package beldyk.sprites;

import java.awt.Color;
import java.awt.Component;
import java.awt.Graphics;
import java.util.LinkedList;
import java.util.List;
import javax.swing.Icon;

import beldyk.canvas.Canvas;
import beldyk.movements.MoveBehavior;

public abstract class Sprite {

  public enum Direction {
    NONE, NORTH, EAST, SOUTH, WEST
  }

  private int  x;
  private int  y;
  private Direction direction;

  protected List<Icon> images;
  protected int  current;
  protected MoveBehavior mvBehavior;

  public MoveBehavior getMvBehavior() {
	return mvBehavior;
}

public void setMvBehavior(MoveBehavior mvBehavior) {
	this.mvBehavior = mvBehavior;
}

public int getCurrent() {
	return current;
}

public Sprite(int x, int y) {
    this.x  = x;
    this.y  = y;
    current = 0;
  }

  public void draw(Component c, Graphics g) {
    images.get(current).paintIcon(c, g, x, y);
  }

  public void highlight(Component c, Graphics g) {
    Icon icon   = images.get(current);
    int  height = icon.getIconHeight();
    int  width  = icon.getIconWidth();

    g.setColor(Color.red);
    g.draw3DRect(x, y, width, height, true);

  }
  public void move(Canvas c) {
	  this.mvBehavior.move(c, this);

  }

  public void animate(Canvas c) {
	  this.mvBehavior.animate(c, this);
     
  }

  public int getX() {
    return x;
  }

  public void setX(int x) {
    this.x = x;
  }

  public int getY() {
    return y;
  }

  public void setY(int y) {
    this.y = y;
  }

  public Direction getDirection() {
    return direction;
  }
  public void setCurrent(int i){
	  this.current = i;
  }

  public void setDirection(Direction direction) {
    this.direction = direction;
  }

  public Icon getCurrentImage() {
    return images.get(current);
  }

}
