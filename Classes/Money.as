package  {
	import flash.events.Event;
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class Money extends MovieClip {
		public var moneyNameField:TextField;
		public static var moneyValueField:TextField;
		public var textFormat:TextFormat = new TextFormat("Times New Roman", 18, 0x663300);
		private var _currentValue:Number = 0;
		private var myName:String = "Money";
		public var maxMoney:Number = 0;
		
		public function Money() {
			addName();
			addValue();
			if (SharedObjectManager.getData(myName)!=null) {
				_currentValue = Number(Simplecrypt.decrypt(SharedObjectManager.getData(myName)));
			}
			updateDisplay();
			this.addEventListener(Event.ENTER_FRAME, frameHandler, false, 0, true);
		}
		
		public function addName():void {
			moneyNameField = new TextField();
			moneyNameField.defaultTextFormat = textFormat;
			moneyNameField.autoSize = TextFieldAutoSize.LEFT;
			moneyNameField.text = "Money :";
			moneyNameField.selectable = false;
			addChild(moneyNameField);
		}
		
		public function addValue():void {
			moneyValueField = new TextField();
			moneyValueField.defaultTextFormat = textFormat;
			moneyValueField.autoSize = TextFieldAutoSize.LEFT;
			moneyValueField.x = moneyNameField.width;
			moneyValueField.selectable = false;
			addChild(moneyValueField);
		}
		
		public function frameHandler(e:Event):void {
			if (_currentValue>=maxMoney) {
				maxMoney = _currentValue;
			}
		}
		
		public function addToValue(amount:Number):void {
			_currentValue+=amount;
			updateDisplay();
		}
		
		public function updateDisplay():void {
			moneyValueField.text = _currentValue.toString();
		}
		
		public static function showMoney():Number {
			return Number(moneyValueField.text);
		}
	}
}