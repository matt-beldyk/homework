package beldyk.sprites;

import java.util.HashMap;

import javax.swing.Icon;
import javax.swing.ImageIcon;

import beldyk.movements.EastWestMoveBehavior;
import beldyk.sprites.Sprite.Direction;

public class CCSupermanSprite extends Sprite {

	public CCSupermanSprite(int x, int y) {
		super(x, y);
		images = new HashMap<Direction,Icon>();
	    images.put(Direction.EAST, new ImageIcon("images/CC_SuperMan_East.png"));
	    images.put(Direction.WEST, new ImageIcon("images/CC_SuperMan_West.png"));
	    super.setImgDirection(Sprite.Direction.EAST);

	    this.setMvBehavior(new EastWestMoveBehavior());
	}

}
