package  {
	
	public class NumEnemies extends Upgrade {
		public static var info:Number;
		private var myName:String = "NumEnemies";
		private var numEnemiesArray:Array = [1,2,3,4,5,6];
		private var enemiesCostArray:Array = [500, 1000, 2000, 5000, 10000];

		public function NumEnemies() {
			super("Enemies: ", numEnemiesArray.length, numEnemiesArray, enemiesCostArray);
			if (SharedObjectManager.getData(myName)!=null) {
				currentLevel = SharedObjectManager.getData(myName)[0];
				if (currentLevel>numEnemiesArray.length) {
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