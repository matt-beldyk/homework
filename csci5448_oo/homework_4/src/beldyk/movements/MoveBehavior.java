package beldyk.movements;

import java.awt.Graphics;

import beldyk.canvas.Canvas;
import beldyk.sprites.Sprite;


public abstract class MoveBehavior {

	private Sprite.Direction mvDirection;

	public  void move(Canvas c,  Sprite s){}
	public  void animate(Canvas c, Sprite s){}

	public MoveBehavior(){
		mvDirection  = Sprite.Direction.NONE;
	}

	public void setMvDirection(Sprite.Direction mvDirection) {
		this.mvDirection = mvDirection;
	}
	public Sprite.Direction getMvDirection() {
		return mvDirection;
	};

}
