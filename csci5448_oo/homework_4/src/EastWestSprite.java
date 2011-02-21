import java.util.LinkedList;
import java.util.List;
import javax.swing.Icon;
import javax.swing.ImageIcon;

public class EastWestSprite extends Sprite {

  public EastWestSprite(int x, int y) {
    super(x, y);
    images = new LinkedList<Icon>();
    images.add(new ImageIcon("images/east.png"));
    images.add(new ImageIcon("images/west.png"));
    super.setDirection(Sprite.Direction.EAST);
  }

  public void move(Canvas c) {
    switch (getDirection()) {
      case EAST:
        setX(getX() + 10);
        Icon icon = getCurrentImage();
        if (getX() + icon.getIconWidth() > c.getSize().getWidth()) {
          setX((int)(c.getSize().getWidth() - icon.getIconWidth()));
          setDirection(Sprite.Direction.WEST);
        }
        break;
      case WEST:
        setX(getX() - 10);
        if (getX() < 0) {
          setX(0);
          setDirection(Sprite.Direction.EAST);
        }
        break;
    }
  }

  public void animate(Canvas c) {
    switch (getDirection()) {
      case EAST:
        current = 0;
        break;
      case WEST:
        current = 1;
        break;
    }
  }

}
