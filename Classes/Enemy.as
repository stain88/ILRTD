package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.display.Stage;
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.net.URLRequest;
		
	public class Enemy extends MovieClip {
		[Embed(source="../images/person-sprite-sheet.png")]
		public static var testSheet:Class;

		public var stageRef:Stage;
		public var isRunning:Boolean = true;
		public var runSpeed:Number = 5;
		public var isThrown:Boolean = false;
		public var distance:Number;
		public var _power:Number = 12;
		public var gravity:Number = 2;
		public var xSpeed:Number;
		public var ySpeed:Number;
		public var isAttacking:Boolean = false;
		
		private var tileSheet:SpriteSheet;
		private var tsLength:int = 9;
		private var animationBitmap:Bitmap;
		private var animationIndex:int = 2;
		private var animationCount:int = 0;
		private var animationDelay:int = 3;
				
		public function Enemy(stageRef:Stage, X:int, Y:int) {	
			this.stageRef = stageRef;
			this.x = X;
			this.y = Y;
			animationBitmap = new Bitmap();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddToStage, false, 0, true);
		}
				
		private function onAddToStage(e:Event):void {
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddToStage);
			tileSheet = new SpriteSheet(new testSheet() as Bitmap, 34, 34);
			this.addEventListener(Event.ENTER_FRAME, frameHandler, false, 0, true);
		}
		
		private function frameHandler(e:Event):void {
			if (isThrown) {
				this.x+=_power;
				this.y-=distance;
				distance -= gravity;
				if (this.y==stage.stageHeight - animationBitmap.height-21) {
					landed();
				}
			}
			if (isRunning) {
				this.x -= runSpeed;
				drawRunningSprite(2);
			}
			if (isAttacking) {
				drawRunningSprite(2);
			}
			if (this.y<0 || this.x<0) {
				this.removeEventListener(Event.ENTER_FRAME, frameHandler);
				dispatchEvent(new Event(Event.REMOVED_FROM_STAGE));
				this.parent.removeChild(this);
			}
		}
		
		private function drawRunningSprite(startSprite:int):void {
			if (animationCount==animationDelay) {
				animationIndex++;
				animationCount = 0;
				if (animationIndex >= tsLength) {
					animationIndex = 2;
				}
			} else {
				animationCount++;
			}
			
			animationBitmap.bitmapData = tileSheet.drawTile(animationIndex, 2, true);
			addChild(animationBitmap);
		}
				
		public function launched(power:Number):void {
			isRunning = false;
			isAttacking = false;
			isThrown = true;
			distance = power*2;
		}
		
		public function landed():void {
			isThrown = false;
			isAttacking = false;
			isRunning = true;
		}
		
		public function attacking():void {
			isRunning = false;
			isThrown = false;
			isAttacking = true;
		}
	}
}