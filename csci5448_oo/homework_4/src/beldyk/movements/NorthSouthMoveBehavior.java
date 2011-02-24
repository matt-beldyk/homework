package beldyk.movements;

import java.awt.Graphics;

import javax.swing.Icon;

import beldyk.canvas.Canvas;
import beldyk.sprites.Sprite;

public class NorthSouthMoveBehavior extends MoveBehavior {

	@Override
	public void move(Canvas c,  Sprite s) {
		
	    switch (s.getImgDirection()) {
	      case NORTH:
	        s.setY(s.getY() - 10);
	        if (s.getY() < 0) {
	          s.setY(0);
	          s.setImgDirection(Sprite.Direction.SOUTH);
	        }
	        break;
	      case SOUTH:
	        s.setY(s.getY() + 10);
	        Icon icon = s.getCurrentImage();
	        if (s.getY() + icon.getIconHeight() > c.getSize().getHeight()) {
	          s.setY((int)(c.getSize().getHeight() - icon.getIconHeight()));
	          s.setImgDirection(Sprite.Direction.NORTH);
	        }
	        break;
	    }
	}

	

}
