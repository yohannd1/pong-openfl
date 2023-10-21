package entities;

import Main;
import InputManager.KeyCode;
import openfl.display.Sprite;
import openfl.events.Event;

class Ball extends Sprite {
	public static final Y_MOVE_SPEED = 7.0;
	public static final RADIUS = 10.0;

	public function new() {
		super();

		this.graphics.beginFill(0xffffff);

		final p = -RADIUS / 2;
		this.graphics.drawCircle(p, p, RADIUS);
		this.graphics.endFill();

		this.addEventListener(Event.ENTER_FRAME, function(_) onUpdate());
	}

	function onUpdate():Void {
		var gr = Main.gr;

		var keyUp = gr.input.getHeld(KeyCode.UP);
		var keyDown = gr.input.getHeld(KeyCode.DOWN);
		var dirY = if (keyDown) 1.0 else if (keyUp) -1.0 else 0.0;

		if (!gr.isPaused) {
			y += dirY * Y_MOVE_SPEED;

			final ss = gr.screen_size;
			y = if (y < 0) 0 else if (y > ss.y) ss.y else y;
		}
	}
}
