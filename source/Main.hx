package;

import openfl.display.Sprite;
import openfl.display.StageScaleMode;
import openfl.display.StageAlign;
import openfl.events.Event;
import openfl.Lib;
import openfl.events.KeyboardEvent;
import InputManager;
import scenes.TitleScreen;

@:nullSafety(Strict)
class Main {
	public static var gr:GameRoot = new GameRoot();

	public static function main() {
		final stage = Lib.current.stage;

		// stage scaling
		stage.scaleMode = StageScaleMode.SHOW_ALL;
		stage.align = StageAlign.TOP_LEFT;

		Lib.current.addChild(gr);

		final title_screen = new TitleScreen();
		gr.setCurrentScene(title_screen);
	}
}

@:nullSafety(Strict)
class Globals {
	public static var isPaused:Bool = true;
	public static var scoreAI:Int = 0;
	public static var scorePlayer:Int = 0;
}

class GameRoot extends Sprite {
	public final screen_size = new Vec2(800, 600);

	private var current_scene:Scene;

	public var input:InputManager = new InputManager();
	public var isPaused:Bool = false;

	public function new() {
		super();
		addEventListener(Event.ADDED_TO_STAGE, onAdd);
	}

	function onAdd(e) {
		removeEventListener(Event.ADDED_TO_STAGE, onAdd);
		var stage = Lib.current.stage;

		// update background
		updateScreen();
		stage.addEventListener(Event.RESIZE, function(_) updateScreen());

		// input handling
		stage.addEventListener(KeyboardEvent.KEY_DOWN, function(ev) input.handleKeyEvent(true, ev.keyCode));
		stage.addEventListener(KeyboardEvent.KEY_UP, function(ev) input.handleKeyEvent(false, ev.keyCode));

		addEventListener(Event.ENTER_FRAME, function(_) onUpdate());
	}

	function updateScreen() {
		var stage = Lib.current.stage;

		this.graphics.beginFill(0x000000);
		this.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
		this.graphics.endFill();
	}

	public function setCurrentScene(s:Scene):Void {
		removeChildren();

		current_scene = s;
		addChild(s);
		s.onAdd();
	}

	function onUpdate():Void {
		input.update();

		if (current_scene != null) {
			current_scene.onUpdate();
		}
	}
}

abstract class Scene extends Sprite {
	public function new() {
		super();
	}

	abstract public function onAdd():Void;

	abstract public function onUpdate():Void;
}

