package  {
	
	public class AutoMine extends Upgrade {
		public static var info:Number;
		private var myName:String = "AutoMine";
		private var autoMineStatArray:Array = [0,1,3,10,25,50];
		private var autoMineCostArray:Array = [50,100,250,1000,5000];

		public function AutoMine() {
			super("Auto Mine: ", autoMineStatArray.length, autoMineStatArray, autoMineCostArray);
			if (SharedObjectManager.getData(myName)!=null) {
				currentLevel = SharedObjectManager.getData(myName)[0];
				if (currentLevel>autoMineStatArray.length) {
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
