@:nullSafety(Strict)
class InputManager {
	private var states:Map<Int, KeyPress>;

	// two input queues, swapped every frame.
	private var queueReceiving:Array<KeyPressEvent>;
	private var queueAlt:Array<KeyPressEvent>;

	public function new() {
		states = new Map();
		queueReceiving = [];
		queueAlt = [];
	}

	public function enableKey(code:Int):Void {
		if (!states.exists(code)) {
			states[code] = {justPressed: false, held: false};
		}
	}

	public function disableKey(code:Int):Void {
		if (states.exists(code)) {
			states.remove(code);
		}
	}

	public function update():Void {
		// swap the queues
		var processing = queueReceiving;
		queueReceiving = queueAlt;

		// clear all "just pressed"
		for (s in states.iterator()) {
			s.justPressed = false;
		}

		// begin processing
		for (ev in processing) {
			var s = states[ev.keyCode];
			if (s == null)
				continue;

			if (ev.isDown) {
				s.justPressed = !s.held;
				s.held = true;
			} else {
				s.justPressed = false;
				s.held = false;
			}
		}

		// empty the array now that we processed it
		processing.resize(0);
		queueAlt = processing;
	}

	public function handleKeyEvent(isDown:Bool, keyCode:Int):Void {
		queueReceiving.push({isDown: isDown, keyCode: keyCode});
	}

	public function getHeld(code:Int):Bool {
		var s = states[code];
		if (s == null)
			return false;
		return s.held;
	}

	public function getJustPressed(code:Int):Bool {
		var s = states[code];
		if (s == null)
			return false;
		return s.justPressed;
	}
}

@:nullSafety(Strict)
typedef KeyPress = {
	justPressed:Bool,
	held:Bool,
}

@:nullSafety(Strict)
typedef KeyPressEvent = {
	isDown:Bool,
	keyCode:Int,
}

@:nullSafety(Strict)
class KeyCode {
	public static final SPACE = 32;
	public static final UP = 38;
	public static final DOWN = 40;
}

