package  {
	
	public class MegaLaunchFiller extends Upgrade {
		public static var info:Number;
		private var myName:String = "LaunchFiller";
		private var launchStatArray:Array = [10, 12, 14, 16, 18, 20];
		private var launchCostArray:Array = [100, 250, 500, 1000, 2500];

		public function MegaLaunchFiller() {
			super("MegaLaunch Fill: ", launchStatArray.length, launchStatArray, launchCostArray);
			if (SharedObjectManager.getData(myName)!=null) {
				currentLevel = SharedObjectManager.getData(myName)[0];
				if (currentLevel>launchStatArray.length) {
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
