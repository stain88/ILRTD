package  {
	
	public class CoinDrop extends Upgrade {
		public static var info:Number;
		private var myName:String = "CoinDrop";
		private var coinDropArray:Array = [1, 2, 5, 10, 20, 40, 75, 100, 500];
		private var coinCostArray:Array = [10, 25, 50, 100, 500, 1500, 5000, 10000];

		public function CoinDrop() {
			super("Coins Dropped: ", coinDropArray.length, coinDropArray, coinCostArray);
			if (SharedObjectManager.getData(myName)!=null) {
				currentLevel = SharedObjectManager.getData(myName)[0];
				if (currentLevel>coinDropArray.length) {
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