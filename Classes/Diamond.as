package  {
	
	public class Diamond extends Upgrade {
		private var myName:String = "Diamond";

		public function Diamond() {
			super("Diamonds: ", 2, [0], [100000]);
			upgradeTextField.text = "Convert";
			if (SharedObjectManager.getData(myName)!=null) {
				currentLevel = Number(Simplecrypt.decrypt(SharedObjectManager.getData(myName)));
				updateLevel();
			}
			updateDisplay();
		}

		override public function updateLevel():void {
			currentStatValue++;
			updateDisplay();
		}
		
		override public function updateDisplay():void {
			upgradeCostField.text = "Cost: " + upgradeCostValue.toString();
			statValueField.text = currentStatValue.toString();
		}
	}
}