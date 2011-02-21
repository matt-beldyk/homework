import java.awt.Component;
import java.awt.Graphics;

import javax.swing.Icon;



public class RedSpriteAdaptor extends Sprite{

	private RedSprite rSprite;



	public RedSpriteAdaptor(int x, int y) {
		super(x, y);
		rSprite = new RedSprite(x,y);
		this.setDirection(Direction.NORTH);
	}


	@Override
	public void animate(Canvas c) {
		rSprite.animateMe(c);
	}

	@Override
	public void move(Canvas c) {
		rSprite.moveMe(c);
	}

	@Override
	public void draw(Component c, Graphics g) {
		rSprite.drawMe(c, g);
	}
	@Override
	public void highlight(Component c, Graphics g) {
		rSprite.drawMe(c, g);
	}

	public Icon getCurrentImage() {
		return images.get(current);
	}


}