package  {
	
	public class CatCooldown extends Upgrade {
		public static var info:Number;
		private var myName:String = "CatCooldown";
		private var cooldownStatArray:Array = [3, 2.5, 2.0, 1.75, 1.5, 1.25, 1, 0.7];
		private var cooldownCostArray:Array = [100, 500, 1000, 2000, 5000, 10000, 25000];

		public function CatCooldown() {
			super("Catapult Cooldown: ", cooldownStatArray.length, cooldownStatArray, cooldownCostArray);
			if (SharedObjectManager.getData(myName)!=null) {
				currentLevel = SharedObjectManager.getData(myName)[0];
				if (currentLevel>cooldownStatArray.length) {
					currentLevel = 0;
				}
				currentLevel--;
				updateLevel();
			}
			updateDisplay();
			info = Number(currentStatValue);
		}
		
		override public function updateLevel():void {
			super.updateLevel();
			info = Number(currentStatValue);
			SharedObjectManager.setData(myName, [currentLevel, currentStatValue]);
		}
		
		override public function updateDisplay():void {
			upgradeCostField.text = "Cost: " + upgradeCostValue.toString();
			statValueField.text = currentStatValue.toString()+"s";
		}
		
		override public function set statValueLabel(text:String):void {
			statValueField.text = text+"s";
		}
		
		override public function get statValueLabel():String {
			return statValueField.text.substring(0, statValueField.text.length-1);
		}
		
		public static function showStat():Number {
			return info;
		}

	}
	
}
