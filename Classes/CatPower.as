package  {
	
	public class CatPower extends Upgrade {
		public static var info:Number;
		private var myName:String = "CatPower";
		private var catPowerStatArray:Array = [11, 13, 15, 17, 20];
		private var catPowerCostArray:Array = [200, 500, 1000, 2000];
		
		public function CatPower() {
			super("Catapult Power: ", catPowerStatArray.length, catPowerStatArray, catPowerCostArray);
			if (SharedObjectManager.getData(myName)!=null) {
				currentLevel = SharedObjectManager.getData(myName)[0];
				if (currentLevel>catPowerStatArray.length) {
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
		
		public static function showStat():Number {
			return info;
		}
	}
}