import java.util.LinkedList;
import java.util.List;
import javax.swing.Icon;
import javax.swing.ImageIcon;

import beldyk.canvas.Canvas;
import beldyk.sprites.BlueSprite;
import beldyk.sprites.EastWestSprite;
import beldyk.sprites.NorthSouthSprite;

public class Test {

  public static void main(String[] args) {
    Canvas c = Canvas.getCanvas();;
    c.requestFocus();

    c.addSprite(new NorthSouthSprite(400, 400));
    c.addSprite(new EastWestSprite(200, 200));
    c.addSprite(new RedSpriteAdaptor(350, 350));

    BlueSprite b = new BlueSprite(200, 200);
    c.addKeyListener(b);
    c.addSprite(b);

  }

}
