package beldyk.movements;

import beldyk.canvas.Canvas;
import beldyk.sprites.Sprite;

public class SpinMoveBehavior extends MoveBehavior {

	private Integer rot;
	public SpinMoveBehavior(){
		super();
		rot = 0;
	}
	@Override
	public void move(Canvas c,  Sprite s) {

		switch (rot) {
		case 0:
		case 1:
			s.setImgDirection(Sprite.Direction.NORTH);
			break;
		case 2:		
		case 3:
			s.setImgDirection(Sprite.Direction.EAST);
			break;
		case 4:
		case 5:
			s.setImgDirection(Sprite.Direction.SOUTH);
			break;
		case 6:
		case 7:
			s.setImgDirection(Sprite.Direction.WEST);
			break;
		}

		rot +=1;
		if(rot >= 8){
			rot = 0;
		}
	}
}
