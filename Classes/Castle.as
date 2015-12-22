package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.display.Stage;
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.net.URLRequest;

	public class Castle extends MovieClip {
		[Embed(source="../images/castle.png")]
		public static var castlePic:Class;
		
		private var stageRef:Stage;
		private var castleImage:SpriteSheet;
		private var castleBitmap:Bitmap;
		
		public function Castle() {
			castleBitmap = new Bitmap();
			addEventListener(Event.ADDED_TO_STAGE, onAddToStage, false, 0, true);
		}
		
		public function onAddToStage(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, onAddToStage);
			castleImage = new SpriteSheet(new castlePic() as Bitmap, 150, 160);
			castleBitmap.bitmapData = castleImage.drawTile(0);
			addChild(castleBitmap);
		}
	}
	
}
