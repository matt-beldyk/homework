package beldyk.movements;

import javax.swing.Icon;

import beldyk.canvas.Canvas;
import beldyk.sprites.Sprite;

public class EastWestMoveBehavior extends MoveBehavior {

	@Override
	public void move(Canvas c, Sprite s) {
		 switch (s.getDirection()) {
	      case EAST:
	        s.setX(s.getX() + 10);
	        Icon icon = s.getCurrentImage();
	        if (s.getX() + icon.getIconWidth() > c.getSize().getWidth()) {
	          s.setX((int)(c.getSize().getWidth() - icon.getIconWidth()));
	          s.setDirection(Sprite.Direction.WEST);
	        }
	        break;
	      case WEST:
	        s.setX(s.getX() - 10);
	        if (s.getX() < 0) {
	          s.setX(0);
	          s.setDirection(Sprite.Direction.EAST);
	        }
	        break;
	    }

	}


}
