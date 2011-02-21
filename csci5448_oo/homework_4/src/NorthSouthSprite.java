import java.util.LinkedList;
import java.util.List;
import javax.swing.Icon;
import javax.swing.ImageIcon;

public class NorthSouthSprite extends Sprite {

  public NorthSouthSprite(int x, int y) {
    super(x, y);
    images = new LinkedList<Icon>();
    images.add(new ImageIcon("images/north.png"));
    images.add(new ImageIcon("images/south.png"));
    setDirection(Sprite.Direction.NORTH);
  }

  public void move(Canvas c) {
    switch (getDirection()) {
      case NORTH:
        setY(getY() - 10);
        if (getY() < 0) {
          setY(0);
          setDirection(Sprite.Direction.SOUTH);
        }
        break;
      case SOUTH:
        setY(getY() + 10);
        Icon icon = getCurrentImage();
        if (getY() + icon.getIconHeight() > c.getSize().getHeight()) {
          setY((int)(c.getSize().getHeight() - icon.getIconHeight()));
          setDirection(Sprite.Direction.NORTH);
        }
        break;
    }
  }

  public void animate(Canvas c) {
     switch (getDirection()) {
      case NORTH:
        current = 0;
        break;
      case SOUTH:
        current = 1;
        break;
    }
  }

}
