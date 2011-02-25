package beldyk.canvas;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;
import java.awt.Graphics;
import java.util.LinkedList;
import java.util.List;
import javax.swing.JComponent;
import javax.swing.JFrame;
import javax.swing.Timer;

import beldyk.movements.KeyboardControlledMoveBehavior;
import beldyk.movements.MoveBehavior;
import beldyk.sprites.Sprite;

public class Canvas extends JComponent implements ActionListener, KeyListener {

	private static Canvas canvas;

	private KeyboardControlledMoveBehavior keyMvBehav;
	private MoveBehavior savedMoveBehav;

	public static Canvas getCanvas() {
		if (canvas == null) {
			canvas = new Canvas();
		}
		return canvas;
	}

	private List<Sprite>  sprites;
	private Timer         timer;
	private JFrame        frame;
	private int           highlighted = 0;

	private Canvas() {
		super();

		frame = new JFrame("Monitor");
		frame.setSize(800, 800);
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		frame.add( this );

		sprites = new LinkedList<Sprite>();

		keyMvBehav = new KeyboardControlledMoveBehavior();

		timer = new Timer(25, this);
		timer.start();

		setFocusTraversalKeysEnabled(false);
		addKeyListener(this);

		frame.setVisible(true);
	}

	public synchronized void actionPerformed(ActionEvent evt) {
		for (Sprite s : sprites) {
			s.move(this);
			s.animate(this);
		}
		repaint();
	}

	public synchronized void addSprite(Sprite sprite) {
		sprites.add(sprite);
	}

	public synchronized void paint(Graphics g) {
		for (Sprite s : sprites) {
			s.draw(this, g);
		}
		if (sprites.size() > highlighted) {
			Sprite s = sprites.get(highlighted);
			s.highlight(this, g);
		}
	}

	public void keyTyped(KeyEvent e) {
		
		this.keyMvBehav.keyTyped(e, sprites.get(highlighted));

	}

	public void keyPressed(KeyEvent e) {
		System.out.println("Key Pressed:"+e.getKeyCode());
		this.keyMvBehav.keyPressed(e, sprites.get(highlighted));
	}

	public void keyReleased(KeyEvent e) {
		if (e.getKeyCode() == e.VK_TAB) {
			if(this.savedMoveBehav != null){
				sprites.get(highlighted).setMvBehavior(this.savedMoveBehav);
			}

			highlighted = highlighted + 1;
			if (highlighted == sprites.size()) {
				highlighted = 0;
			}
			this.savedMoveBehav = sprites.get(highlighted).getMvBehavior();

			sprites.get(highlighted).setMvBehavior(this.keyMvBehav);

		}else{
			this.keyMvBehav.keyReleased(e, sprites.get(highlighted));
		}
	}

}
