package {
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.display.MovieClip;
	import flash.text.TextFormat;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.Event;

	public class Upgrade extends MovieClip {
		public var upgradeNameField:TextField;
		public var statValueField:TextField;
		public var currentStatValue:Number = 0;
		public var upgradeButton:Sprite;
		public var upgradeTextField:TextField;
		public var upgradeCostField:TextField;
		public var upgradeCostValue:Number;
		private var textFormat:TextFormat = new TextFormat("Times New Roman", 18, 0x663300);
		public var currentLevel:int = 0;
		public var maxLevel:int;
		public var thisStatArray:Array;
		public var thisCostArray:Array;
		public static var info:Number;
		
		public function Upgrade(upgradeName:String, maxLevel:int, statArray:Array, costArray:Array) {
			thisStatArray = statArray;
			thisCostArray = costArray;
			upgradeCostValue = thisCostArray[currentLevel];
			currentStatValue = thisStatArray[currentLevel];
			this.maxLevel = maxLevel-1;
			addName(upgradeName);
			addStatValue();
			drawUpgradeButton();
			addUpgradeCost();
			addChild(upgradeButton);
		}		
		
		private function addName(upgradeName:String):void {
			upgradeNameField = new TextField();
			upgradeNameField.defaultTextFormat = textFormat;
			upgradeNameField.autoSize = TextFieldAutoSize.LEFT;
			upgradeNameField.text = upgradeName;
			upgradeNameField.selectable = false;
			addChild(upgradeNameField);
		}
		
		private function addStatValue():void {
			statValueField = new TextField();
			statValueField.defaultTextFormat = textFormat;
			statValueField.autoSize = TextFieldAutoSize.LEFT;
			statValueField.x = upgradeNameField.width;
			statValueField.selectable = false;
			statValueField.text = currentStatValue.toString();
			addChild(statValueField);
		}
		
		private function drawUpgradeButton():void {
			upgradeButton = new Sprite();
			upgradeButton.graphics.beginFill(0x663300);
			upgradeButton.graphics.drawRoundRect(0,0,50,30,25);
			upgradeButton.graphics.endFill();
			upgradeButton.y = upgradeNameField.height;
			upgradeTextField = new TextField();
			upgradeTextField.autoSize = TextFieldAutoSize.LEFT;
			upgradeTextField.text = "Upgrade";
			upgradeTextField.x = upgradeButton.x;
			upgradeTextField.y = upgradeTextField.height/2;
			upgradeTextField.selectable = false;
			upgradeButton.addChild(upgradeTextField);
		}
		
		public function addUpgradeCost():void {
			upgradeCostField = new TextField();
			upgradeCostField.defaultTextFormat = textFormat;
			upgradeCostField.autoSize = "left";
			upgradeCostField.x = upgradeButton.x + upgradeButton.width;
			upgradeCostField.y = upgradeNameField.height;
			upgradeCostField.text = "Cost: " + upgradeCostValue.toString();
			upgradeCostField.selectable = false;
			addChild(upgradeCostField);
		}
		
		public function set statValueLabel(text:String):void {
			statValueField.text = text;
		}
		
		public function get statValueLabel():String {
			return statValueField.text;
		}
		
		public function set upgradeCostLabel(text:String):void {
			upgradeCostField.text = text;
		}
		
		public function get upgradeCostLabel():String {
			return upgradeCostField.text;
		}
		
		public function addToValue(amount:Number):void {
			currentStatValue+=amount;
		}
		
		public function updateDisplay():void {
			upgradeCostField.text = "Cost: " + upgradeCostValue.toString();
			statValueField.text = currentStatValue.toString();
		}
		
		public function onClickUpgrade(me:MouseEvent):void {
			dispatchEvent(new Event("upgraded"));
			updateLevel();
		}
		
		public function updateLevel():void {
			if (currentLevel < maxLevel) {
				currentLevel++;
				upgradeCostValue = thisCostArray[currentLevel];
				currentStatValue = thisStatArray[currentLevel];
				updateDisplay();
			}
			if (currentLevel == maxLevel) {
				removeChild(upgradeButton);
				removeChild(upgradeCostField);
			}
		}
	}
}