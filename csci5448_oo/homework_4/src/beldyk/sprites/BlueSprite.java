package beldyk.sprites;

import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import javax.swing.Icon;
import javax.swing.ImageIcon;

import beldyk.canvas.Canvas;

public class BlueSprite extends Sprite implements KeyListener {

  public BlueSprite(int x, int y) {
    super(x, y);
    images = new HashMap<Direction,Icon>();
    images.put(Direction.NORTH, new ImageIcon("images/BlueNorth.png"));
    images.put(Direction.SOUTH, new ImageIcon("images/BlueSouth.png"));
    images.put(Direction.EAST, new ImageIcon("images/BlueEast.png"));
    images.put(Direction.WEST, new ImageIcon("images/BlueWest.png"));
    setDirection(Sprite.Direction.NORTH);
  }

  public void move(Canvas c) {
    Icon icon = getCurrentImage();

    int  iconHeight   = icon.getIconHeight();
    int  iconWidth    = icon.getIconWidth();
    int  canvasHeight = (int)c.getSize().getHeight();
    int  canvasWidth  = (int)c.getSize().getWidth();

    switch (getDirection()) {
      case NORTH:
        setY(getY() - 10);
        if (getY() < 0) {
          setY(0);
        }
        break;
      case SOUTH:
        setY(getY() + 10);
        if (getY() + iconHeight > canvasHeight) {
          setY((int)(canvasHeight - iconHeight));
        }
        break;
      case EAST:
        setX(getX() + 10);
        if (getX() + iconWidth > canvasWidth) {
          setX((int)(canvasWidth - iconWidth));
        }
        break;
      case WEST:
        setX(getX() - 10);
        if (getX() < 0) {
          setX(0);
        }
        break;
    }

  }

  
  

  public void keyTyped(KeyEvent e) {
  }

  public void keyReleased(KeyEvent e) {
    if (e.getKeyCode() != e.VK_TAB) {
      setDirection(Sprite.Direction.NONE);
    }
  }

  public void keyPressed(KeyEvent e) {
    if (e.getKeyCode() == e.VK_UP) {
      setDirection(Sprite.Direction.NORTH);
    }
    if (e.getKeyCode() == e.VK_DOWN) {
      setDirection(Sprite.Direction.SOUTH);
    }
    if (e.getKeyCode() == e.VK_RIGHT) {
      setDirection(Sprite.Direction.EAST);
    }
    if (e.getKeyCode() == e.VK_LEFT) {
      setDirection(Sprite.Direction.WEST);
    }
  }

}
