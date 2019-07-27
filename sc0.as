package {

	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;


	public class sc0 extends MovieClip {

		//public var backkeyvar = new backkeyfunction();
		public function sc0() {
			// constructor code
			stbt.addEventListener(MouseEvent.CLICK, clicked);
			trace("mouse event added");
		}
		
		function clicked(e: MouseEvent): void {
			trace("clicked on start");
			stbt.removeEventListener(MouseEvent.CLICK, clicked);
			dispatchEvent(new StartGameEvent(StartGameEvent.onbtpressed));
		}
	}

}