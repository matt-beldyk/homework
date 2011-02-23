package beldyk.movements;

import java.awt.Graphics;

import beldyk.canvas.Canvas;
import beldyk.sprites.Sprite;


public abstract class MoveBehavior {

	
	public abstract void move(Canvas c,  Sprite s);
	  public abstract void animate(Canvas c, Sprite s);

}
