package  {
	import flash.display.MovieClip;
	
	public class MegaLaunch extends MovieClip {
		public var maxFill:int = 200;
		public var currentFill:int;
		public var percentFill:Number;

		public function MegaLaunch() {
			this.x = 700;
			this.y = 150;
			if (SharedObjectManager.getData("Filler")!=null) {
				currentFill = SharedObjectManager.getData("Filler");
				if (currentFill>maxFill) {
					currentFill = maxFill;
				}
			} else {
				currentFill = 0;
			}
			percentFill = currentFill/maxFill;
			updateBar();
		}
		
		public function updateBar():void {
			percentFill = currentFill/maxFill;
			barColour.scaleY = percentFill;
		}
		
		public function updateFill(amount:int):void {
			currentFill+=amount;
			if (currentFill>=maxFill) {
				currentFill = maxFill;
			}
			if (currentFill<=0) {
				currentFill = 0;
			}
			updateBar();
		}
	}
}