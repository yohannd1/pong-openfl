package scenes;

import Main.Scene;
import openfl.events.Event;
import entities.Ball;
import entities.Platform;
import InputManager.KeyCode;

class DemoStage extends Scene {
	private var isPaused:Bool = false;

	public function new() {
		super();
	}

	function onAdd():Void {
		final gr = Main.gr;

		// enable keys
		gr.input.enableKey(KeyCode.SPACE);
		gr.input.enableKey(KeyCode.UP);
		gr.input.enableKey(KeyCode.DOWN);

		final margin_x = 10;

		var p1 = new Platform();
		p1.x = margin_x;
		p1.y = gr.screen_size.y / 2;
		this.addChild(p1);

		var p2 = new Platform();
		p2.x = gr.screen_size.x - margin_x;
		p2.y = gr.screen_size.y / 2;
		this.addChild(p2);

		var ball = new Ball();
		ball.x = 250;
		ball.y = 250;
		this.addChild(ball);

		this.addEventListener(Event.ENTER_FRAME, function(_) onUpdate());
	}

	function onUpdate():Void {
		var keyPauseJP = Main.gr.input.getJustPressed(KeyCode.SPACE);
		if (keyPauseJP) {
			isPaused = !isPaused;
		}
	}
}

