package entities;

import Main.Globals;
import InputManager.KeyCode;

import openfl.display.Sprite;
import openfl.events.Event;

class Ball extends Sprite {
	public static final Y_MOVE_SPEED = 7.0;

	public function new() {
		super();

		this.graphics.beginFill(0xffffff);
		this.graphics.drawCircle(0, 0, 10);
		this.graphics.endFill();

		this.addEventListener(Event.ENTER_FRAME, function(_) onUpdate());
	}

	function onUpdate():Void {
		var input = Globals.input;

		var keyUp = input.getHeld(KeyCode.UP);
		var keyDown = input.getHeld(KeyCode.DOWN);
		var dirY = if (keyDown) 1.0 else if (keyUp) -1.0 else 0.0;

		if (!Globals.isPaused) {
			y += dirY * Y_MOVE_SPEED;
			if (y < 5) y = 5;
			if (y > 395) y = 395;
		}
	}
}
