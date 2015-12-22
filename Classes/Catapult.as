package {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	
	public class Catapult extends MovieClip {
		
		public var launchTimer:Timer;
		public var canLaunch:Boolean = true;
		public var power:Number = 11;
		public var damage:Number = 5;
		
		public function Catapult() {
			addEventListener(Event.ADDED_TO_STAGE, onAddToStage, false, 0, true);
		}
		
		public function onAddToStage(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, onAddToStage);
			this.x = 2*this.width;
			this.y = stage.stageHeight;
			this.addEventListener(Event.ENTER_FRAME, frameHandler, false, 0, true);
		}
		
		public function frameHandler(e:Event):void {
			this.parent.addEventListener("triggered!", launch, false, 0, true);
			if (rotation>0) {
				this.rotation -= 60/(CatCooldown.showStat()*24);
			}
			if (rotation<0) {
				rotation = 0;
			}
		}
		
		public function launch(e:Event):void {
			if (canLaunch) {
				this.rotation = 60;
				canLaunch = false;
				launchTimer = new Timer(CatCooldown.showStat()*1000,1);
				launchTimer.addEventListener(TimerEvent.TIMER_COMPLETE, cooled, false, 0, true);
				launchTimer.start();
			}
		}
		
		public function cooled(te:TimerEvent):void {
			launchTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, cooled);
			canLaunch = true;
		}
	}
}