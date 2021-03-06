package beldyk.movements;

import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;

import javax.swing.Icon;

import beldyk.canvas.Canvas;
import beldyk.sprites.Sprite;

public class KeyboardControlledMoveBehavior extends MoveBehavior {

	@Override
	public  void move(Canvas c,  Sprite s){
		Icon icon = s.getCurrentImage();

		int  iconHeight   = icon.getIconHeight();
		int  iconWidth    = icon.getIconWidth();
		int  canvasHeight = (int)c.getSize().getHeight();
		int  canvasWidth  = (int)c.getSize().getWidth();

		switch (getMvDirection()) {
		case NORTH:
			s.setY(s.getY() - 10);
			if (s.getY() < 0) {
				s.setY(0);
			}
			break;
		case SOUTH:
			s.setY(s.getY() + 10);
			if (s.getY() + iconHeight > canvasHeight) {
				s.setY((int)(canvasHeight - iconHeight));
			}
			break;
		case EAST:
			s.setX(s.getX() + 10);
			if (s.getX() + iconWidth > canvasWidth) {
				s.setX((int)(canvasWidth - iconWidth));
			}
			break;
		case WEST:
			s.setX(s.getX() - 10);
			if (s.getX() < 0) {
				s.setX(0);
			}
			break;
		}
	}




	public void keyReleased(KeyEvent e, Sprite s) {
		if (e.getKeyCode() != e.VK_TAB) {
			setMvDirection(Sprite.Direction.NONE);
		}
	}


	public void keyTyped(KeyEvent e, Sprite s) {
		/*
		System.out.println("type type");
		if (e.getKeyCode() == e.VK_UP) {
		     // s.setImgDirection(Sprite.Direction.NORTH);
		      setMvDirection(Sprite.Direction.NORTH);
		    }
		    if (e.getKeyCode() == e.VK_DOWN) {
		    //	s.setImgDirection(Sprite.Direction.SOUTH);
		    	setMvDirection(Sprite.Direction.SOUTH);
		    }
		    if (e.getKeyCode() == e.VK_RIGHT) {
		    //	s.setImgDirection(Sprite.Direction.EAST);
		    	setMvDirection(Sprite.Direction.EAST);
		    }
		    if (e.getKeyCode() == e.VK_LEFT) {
		    //	s.setImgDirection(Sprite.Direction.WEST);
		    	setMvDirection(Sprite.Direction.WEST);
		    }
		 */
	}




	public void keyPressed(KeyEvent e, Sprite s) {
		System.out.println("type type");
		if (e.getKeyCode() == e.VK_UP) {
			//     s.setImgDirection(Sprite.Direction.NORTH);
			setMvDirection(Sprite.Direction.NORTH);
		}
		if (e.getKeyCode() == e.VK_DOWN) {
			// 	s.setImgDirection(Sprite.Direction.SOUTH);
			setMvDirection(Sprite.Direction.SOUTH);
		}
		if (e.getKeyCode() == e.VK_RIGHT) {
			//	s.setImgDirection(Sprite.Direction.EAST);
			setMvDirection(Sprite.Direction.EAST);
		}
		if (e.getKeyCode() == e.VK_LEFT) {
			//	s.setImgDirection(Sprite.Direction.WEST);
			setMvDirection(Sprite.Direction.WEST);
		}		
	}

}
