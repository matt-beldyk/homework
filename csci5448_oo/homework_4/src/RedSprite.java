import java.awt.Color;
import java.awt.Component;
import java.awt.Graphics;
import java.util.LinkedList;
import java.util.List;
import javax.swing.Icon;
import javax.swing.ImageIcon;

public class RedSprite {

  public enum Direction {
    NORTH, EAST, SOUTH, WEST
  }

  private Direction direction = Direction.NORTH;
  private int x;
  private int y;
  private int current;
  private List<Icon> images;


  public RedSprite(int x, int y) {
    this.x = x;
    this.y = y;
    current = 0;
    images = new LinkedList<Icon>();
    images.add(new ImageIcon("images/RedNorth.png"));
    images.add(new ImageIcon("images/RedSouth.png"));
    images.add(new ImageIcon("images/RedEast.png"));
    images.add(new ImageIcon("images/RedWest.png"));
  }

  public void moveMe(Canvas c) {
    Icon icon = images.get(current);

    int  iconHeight   = icon.getIconHeight();
    int  iconWidth    = icon.getIconWidth();
    int  canvasHeight = (int)c.getSize().getHeight();
    int  canvasWidth  = (int)c.getSize().getWidth();

    switch (direction) {
      case NORTH:
        y = y - 10;
        if (y < 0) {
          y = 0;
          direction = Direction.WEST;
        }
        break;
      case SOUTH:
        y = y + 10;
        if (y + iconHeight > canvasHeight) {
          y = (int)(canvasHeight - iconHeight);
          direction = Direction.EAST;
        }
        break;
      case EAST:
        x = x + 10;
        if (x + iconWidth > canvasWidth) {
          y = (int)(canvasWidth - iconWidth);
          direction = Direction.NORTH;
        }
        break;
      case WEST:
        x = x - 10;
        if (x < 0) {
          x = 0;
          direction = Direction.SOUTH;
        }
        break;
    }

  }

  public void animateMe(Canvas c) {
    switch (direction) {
      case NORTH:
        current = 0;
        break;
      case SOUTH:
        current = 1;
        break;
      case EAST:
        current = 2;
        break;
      case WEST:
        current = 3;
        break;
    }
  }

  public void drawMe(Component c, Graphics g) {
    images.get(current).paintIcon(c, g, x, y);
  }

  public void highlightMe(Component c, Graphics g) {
    Icon icon   = images.get(current);
    int  height = icon.getIconHeight();
    int  width  = icon.getIconWidth();

    g.setColor(Color.red);
    g.draw3DRect(x, y, width, height, true);

  }


}
