package  {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.GradientType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.events.Event;
	import fl.transitions.Tween;
	import fl.transitions.TweenEvent;
	import fl.transitions.easing.*;
	
	public class DistanceNotification extends MovieClip {
		private var notifBox:Sprite;
		private var notifText:TextField;
		private var textFormat:TextFormat = new TextFormat("Times New Roman", 18, 0x0000FF);
		private var animationDelay:int = 4;
		private var animationCount:int = 0;
		private var velocity:int = 10;
		private var boxTween:Tween;
		private var textTween:Tween;

		public function DistanceNotification(distance:Number, isMax:Boolean) {
			drawText(distance);
			drawNotification(distance);
			addChild(notifBox);
			boxTween = new Tween(this, "y", Back.easeIn, 300, -notifBox.height, 2, true);
			boxTween.start();
			boxTween.addEventListener(TweenEvent.MOTION_FINISH, onFinishBoxTween, false, 0, true);
			if (isMax) {
				textTween = new Tween(notifText, "alpha", Regular.easeInOut, 1, 0, 0.5, true);
				textTween.start();
				textTween.addEventListener(TweenEvent.MOTION_FINISH, onFinishTextTween, false, 0, true);
			}
		}
		
		private function drawText(distance:Number):void {
			notifText = new TextField();
			notifText.defaultTextFormat = textFormat;
			notifText.autoSize = TextFieldAutoSize.LEFT;
			notifText.text = distance.toString() + " ft!";
			notifText.selectable = false;
		}
		
		private function drawNotification(distance:Number):void {
			notifBox = new Sprite();
			notifBox.graphics.beginFill(0xFF0000, 1);
			notifBox.graphics.drawEllipse(0,0,notifText.width,notifText.width*1.5);
			notifBox.graphics.endFill();
			notifText.y = notifBox.height/2-notifText.height/2;
			notifBox.addChild(notifText);
		}
		
		private function onFinishTextTween(twe:TweenEvent):void {
			textTween.yoyo();
		}
		
		private function onFinishBoxTween(twe:TweenEvent):void {
			boxTween.removeEventListener(TweenEvent.MOTION_FINISH, onFinishBoxTween);
			removeChild(notifBox);
			notifBox = null;
		}
	}
}