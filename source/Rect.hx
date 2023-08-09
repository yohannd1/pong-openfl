import Vec2;

class Rect {
	public var x:Float;
	public var y:Float;
	public var w:Float;
	public var h:Float;

	public function new(x:Float, y:Float, w:Float, h:Float) {
		this.x = x;
		this.y = y;
		this.w = w;
		this.h = h;
	}

	public function getPos():Vec2 {
		return Vec2(x, y);
	}

	public function getSize():Vec2 {
		return Vec2(w, h);
	}
}

