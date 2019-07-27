package {

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.*;
	import flash.events.KeyboardEvent;
	import flash.events.TouchEvent;
	import flash.display.Stage;
	import flash.sampler.StackFrame;

	public class cargame extends MovieClip {
		Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
		public var stageref: Stage;
		public var speed: Number = 0;
		public var maxspeed: Number = 20;
		public var scale: Number = 1.1;
		public var speedx: Number = 0;
		public var speedy: Number = 0;
		public var frame: Number = 0;
		public var acc: Number = 0.8;
		public var deacc: Number = -1;
		public var rev: Number = -0.6;
		public var maxrevspeed: Number = -3;
		public var friction: Number = -0.3;
		public var flag: Boolean = true;
		public var up: Boolean = false;
		public var down: Boolean = false;
		public var left: Boolean = false;
		public var right: Boolean = false;
		public function cargame(stageref: Stage) {
			// constructor code

			this.stageref = stageref;
			addEventListener(Event.ENTER_FRAME, loop);

			au.addEventListener(MouseEvent.MOUSE_DOWN, ondown);
			al.addEventListener(MouseEvent.MOUSE_DOWN, ondown);
			ad.addEventListener(MouseEvent.MOUSE_DOWN, ondown);
			ar.addEventListener(MouseEvent.MOUSE_DOWN, ondown);
			au.addEventListener(MouseEvent.MOUSE_OUT, onup);
			al.addEventListener(MouseEvent.MOUSE_OUT, onup);
			ar.addEventListener(MouseEvent.MOUSE_OUT, onup);
			ad.addEventListener(MouseEvent.MOUSE_OUT, onup);
			au.addEventListener(MouseEvent.MOUSE_UP, onup);
			al.addEventListener(MouseEvent.MOUSE_UP, onup);
			ad.addEventListener(MouseEvent.MOUSE_UP, onup);
			ar.addEventListener(MouseEvent.MOUSE_UP, onup);

			au.addEventListener(TouchEvent.TOUCH_BEGIN, ondown);
			al.addEventListener(TouchEvent.TOUCH_BEGIN, ondown);
			ad.addEventListener(TouchEvent.TOUCH_BEGIN, ondown);
			ar.addEventListener(TouchEvent.TOUCH_BEGIN, ondown);
			au.addEventListener(TouchEvent.TOUCH_OUT, onup);
			al.addEventListener(TouchEvent.TOUCH_OUT, onup);
			ar.addEventListener(TouchEvent.TOUCH_OUT, onup);
			ad.addEventListener(TouchEvent.TOUCH_OUT, onup);
			au.addEventListener(TouchEvent.TOUCH_END, onup);
			al.addEventListener(TouchEvent.TOUCH_END, onup);
			ad.addEventListener(TouchEvent.TOUCH_END, onup);
			ar.addEventListener(TouchEvent.TOUCH_END, onup);

			this.stageref.addEventListener(KeyboardEvent.KEY_DOWN, ondown);
			this.stageref.addEventListener(KeyboardEvent.KEY_UP, onup);
		}

		public function loop(e: Event): void {

			//trace("Speed = " + speedx + " " + speedy);

			if (up == true && speed < maxspeed)
				speed += acc;
			if (down == true && speed > 0)
				speed += deacc;
			else if (down == true && speed <= 0) {
				if (speed > maxrevspeed)
					speed += rev;
			}

			if (right == true)
				c.rotation += 5;
			if (left == true)
				c.rotation -= 5;

			//else if (left == true && speedx <= 0) {
			//if (speedx > maxrevspeed)
			//	speedx += rev;
			//	}


			if (speed > 0.4)
				speed += friction;
			else if (speed < -0.4)
				speed -= friction;
			else if (speed >= -0.4 && speed <= 0.4)
				speed = 0;

			if (c.x + c.width / 2 >= stageref.stageWidth)
				c.x = c.width / 2 + 1;

			if (c.x - c.width / 2 <= 0)
				c.x = stageref.stageWidth - c.width / 2;

			if (c.y + c.height / 2 >= stageref.stageHeight)
				c.y = c.height / 2 + 1;

			if (c.y - c.height / 2 <= 0)
				c.y = stageref.stageHeight - c.height / 2;

			speedx = speed * Math.cos(c.rotation * Math.PI / 180);
			speedy = speed * Math.sin(c.rotation * Math.PI / 180);
			c.y += speedy;
			c.x += speedx;
		}


		public function getdirection(e): String {
			trace(e.type)
			var direction
			if (e.type == KeyboardEvent.KEY_DOWN || e.type == KeyboardEvent.KEY_UP)
				direction = e.keyCode
			else {
				if (e.target == au)
					direction = Keyboard.UP
				else if (e.target == ad)
					direction = Keyboard.DOWN
				else if (e.target == al)
					direction = Keyboard.LEFT
				else if (e.target == ar)
					direction = Keyboard.RIGHT
			}
			return direction

		}

		public function ondown(e): void {
			var direction = getdirection(e)
			if (direction == Keyboard.UP) {
				up = true;
				au.alpha = 0.7;
				au.scaleX = scale;
				au.scaleY = scale;
			}
			if (direction == Keyboard.DOWN) {
				down = true;
				ad.alpha = 0.7;
				ad.scaleX = scale;
				ad.scaleY = scale;
			}
			if (direction == Keyboard.RIGHT) {
				right = true;
				ar.alpha = 0.7;
				ar.scaleX = scale;
				ar.scaleY = scale;
			}
			if (direction == Keyboard.LEFT) {
				left = true;
				al.alpha = 0.7;
				al.scaleX = scale;
				al.scaleY = scale;
			}
			//pressed = true;
			//trace(e.target.name);

		}

		public function onup(e): void {
			var direction = getdirection(e)
			if (direction == Keyboard.UP) {
				up = false;
				au.alpha = 1;
				au.scaleX = 1;
				au.scaleY = 1;
			}
			if (direction == Keyboard.DOWN) {
				down = false;
				ad.scaleX = 1;
				ad.scaleY = 1;
				ad.alpha = 1;
			}
			if (direction == Keyboard.LEFT) {
				al.scaleX = 1;
				left = false;
				al.scaleY = 1;
				al.alpha = 1;
			}

			if (direction == Keyboard.RIGHT) {
				right = false;
				ar.scaleX = 1;
				ar.scaleY = 1;
				ar.alpha = 1;
				//pressed = false;
			}


		}
	}
}