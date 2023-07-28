package;

import openfl.display.Sprite;
import openfl.display.StageScaleMode;
import openfl.display.StageAlign;
import openfl.events.Event;
import openfl.Lib;
import openfl.events.KeyboardEvent;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;
import InputManager;

@:nullSafety(Strict)
class Main {
	public static function main() {
		var stage = Lib.current.stage;

		// stage scaling
		stage.scaleMode = StageScaleMode.SHOW_ALL;
		stage.align = StageAlign.TOP_LEFT;

		Lib.current.addChild(new GameRoot());
	}
}

class GameRoot extends Sprite {
	private var input:InputManager;
	private var isPaused:Bool;

	private var platform1:Platform;
	private var platform2:Platform;
	private var ball:Ball;
	private var scorePlayer:Int;
	private var scoreAI:Int;
	private var scoreField:TextField;
	private var messageField:TextField;
	private var platformSpeed:Int;

	public function new() {
		super();

		isPaused = true;
		addEventListener(Event.ADDED_TO_STAGE, onAdd);
	}

	function onAdd(e) {
		removeEventListener(Event.ADDED_TO_STAGE, onAdd);
		var stage = Lib.current.stage;

		// update background
		updateScreen();
		stage.addEventListener(Event.RESIZE, function(_) updateScreen());

		// input handling
		input = new InputManager();
		input.enableKey(KeyCode.SPACE);
		input.enableKey(KeyCode.UP);
		input.enableKey(KeyCode.DOWN);
		stage.addEventListener(KeyboardEvent.KEY_DOWN, function(ev) input.handleKeyEvent(true, ev.keyCode));
		stage.addEventListener(KeyboardEvent.KEY_UP, function(ev) input.handleKeyEvent(false, ev.keyCode));

		#if ios
		haxe.Timer.delay(initStage, 100); // iOS 6
		#else
		initStage();
		#end
	}

	function initStage() {
		platform1 = new Platform();
		platform1.x = 5;
		platform1.y = 200;
		this.addChild(platform1);

		platform2 = new Platform();
		platform2.x = 480;
		platform2.y = 200;
		this.addChild(platform2);

		ball = new Ball();
		ball.x = 250;
		ball.y = 250;
		this.addChild(ball);

		var scoreFormat = new TextFormat("Verdana", 24, 0xbbbbbb, true);
		scoreFormat.align = TextFormatAlign.CENTER;
		scoreField = new TextField();
		addChild(scoreField);
		scoreField.width = 500;
		scoreField.y = 30;
		scoreField.defaultTextFormat = scoreFormat;
		scoreField.selectable = false;

		var messageFormat = new TextFormat("Verdana", 18, 0xbbbbbb, true);
		messageFormat.align = TextFormatAlign.CENTER;
		messageField = new TextField();
		addChild(messageField);
		messageField.width = 500;
		messageField.y = 450;
		messageField.defaultTextFormat = messageFormat;
		messageField.selectable = false;
		messageField.text = "Press SPACE to start\nUse ARROW KEYS to move your platform";

		scorePlayer = 0;
		scoreAI = 0;
		platformSpeed = 7;

		this.addEventListener(Event.ENTER_FRAME, function(_) onEnterFrame());
	}

	private function updateScreen() {
		var stage = Lib.current.stage;

		this.graphics.beginFill(0x000000);
		this.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
		this.graphics.endFill();
	}

	function onEnterFrame():Void {
		input.update();

		var keyUp = input.getHeld(KeyCode.UP);
		var keyDown = input.getHeld(KeyCode.DOWN);
		var keyPauseJP = input.getJustPressed(KeyCode.SPACE);

		if (!isPaused) {
			if (keyDown) {
				platform1.y += platformSpeed;
			} else if (keyUp) {
				platform1.y -= platformSpeed;
			}

			if (platform1.y < 5)
				platform1.y = 5;

			if (platform1.y > 395)
				platform1.y = 395;
		}

		if (keyPauseJP) {
			isPaused = !isPaused;

			if (isPaused) {
				scoreField.text = scorePlayer + ":" + scoreAI;
			}

			messageField.alpha = if (isPaused) 1.0 else 0.0;
		}
	}
}

