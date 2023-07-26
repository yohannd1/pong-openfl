// TODO https://keyreal-code.github.io/haxecoder-tutorials/09_how_to_make_a_pong_game_in_haxe_and_openfl_part_3.html

package;

import openfl.display.Sprite;

class Main extends Sprite
{
	public function new()
	{
		super();
		var data = openfl.Assets.getBitmapData("assets/player.png");
		var b = new openfl.display.Bitmap(data);
		addChild(b);
		addEventListener(openfl.events.KeyboardEvent.KEY_DOWN, function(ev: openfl.events.KeyboardEvent) {
			trace("Event type: " + ev.type + " at " + b);
		});
	}
}
