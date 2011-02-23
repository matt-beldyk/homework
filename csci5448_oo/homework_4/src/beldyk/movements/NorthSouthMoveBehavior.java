package beldyk.movements;

import java.awt.Graphics;

import javax.swing.Icon;

import beldyk.canvas.Canvas;
import beldyk.sprites.Sprite;

public class NorthSouthMoveBehavior extends MoveBehavior {

	@Override
	public void move(Canvas c,  Sprite s) {
		
	    switch (s.getDirection()) {
	      case NORTH:
	        s.setY(s.getY() - 10);
	        if (s.getY() < 0) {
	          s.setY(0);
	          s.setDirection(Sprite.Direction.SOUTH);
	        }
	        break;
	      case SOUTH:
	        s.setY(s.getY() + 10);
	        Icon icon = s.getCurrentImage();
	        if (s.getY() + icon.getIconHeight() > c.getSize().getHeight()) {
	          s.setY((int)(c.getSize().getHeight() - icon.getIconHeight()));
	          s.setDirection(Sprite.Direction.NORTH);
	        }
	        break;
	    }
	}

	@Override
	public void animate(Canvas c, Sprite s) {
		//FIXME  this is terrible!!!!!
		switch (s.getDirection()) {
	      case NORTH:
	        s.setCurrent(0);
	        break;
	      case SOUTH:
	        s.setCurrent(1);
	        break;
	    }		
	}

}
