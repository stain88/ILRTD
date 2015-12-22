package  {
	
	public class MineFrequency extends Upgrade {
		public static var info:Number;
		private var myName:String = "MineFrequency";
		private var mineFrequencyStatArray:Array = [5, 4, 3, 2, 1];
		private var mineFrequencyCostArray:Array = [1000, 2000, 5000, 10000];

		public function MineFrequency() {
			super("Mine Frequency: ", mineFrequencyStatArray.length, mineFrequencyStatArray, mineFrequencyCostArray);
			if (SharedObjectManager.getData(myName)!=null) {
				currentLevel = SharedObjectManager.getData(myName)[0];
				if (currentLevel>mineFrequencyStatArray.length) {
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
		
		public static function showStat():Number {
			return info;
		}

	}
	
}
