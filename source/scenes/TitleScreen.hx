package scenes;

import Main;
import InputManager;
import openfl.events.Event;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;
import scenes.DemoStage;

class TitleScreen extends Scene {
	private var messageField:TextField = new TextField();

	public function new() {
		super();
	}

	function onAdd():Void {
		final gr = Main.gr;

		// enable keys
		gr.input.enableKey(KeyCode.SPACE);

		final margin_x = 10;

		addChild(messageField);
		messageField.width = 500;
		messageField.x = gr.screen_size.x / 2 - messageField.width / 2;
		messageField.y = gr.screen_size.y / 2 - messageField.height / 2;
		messageField.selectable = false;
		var messageFormat = new TextFormat("Verdana", 18, 0xbbbbbb, true);
		messageFormat.align = TextFormatAlign.CENTER;
		messageField.defaultTextFormat = messageFormat;
		messageField.text = "FUNKY LIL GAME\nPRESS SPACE TO START";
	}

	function onUpdate():Void {
		final keySpaceJP = Main.gr.input.getJustPressed(KeyCode.SPACE);
		if (keySpaceJP) {
			final ds = new DemoStage();
			Main.gr.setCurrentScene(ds);
		}
	}
}
