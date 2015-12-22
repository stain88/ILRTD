package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.net.SharedObject;
	import flash.display.Sprite;
	import flash.display.GradientType;
	import flash.geom.Matrix;
	import fl.transitions.Tween;
	import fl.transitions.TweenEvent;
	import fl.transitions.easing.*;
	
	public class Main extends MovieClip {
		private var stageRef:Stage;
		
		private var army:Array;
		private var enemy:Enemy;
		private var canSummon:Boolean = true;
		private var summonTimer:Timer;
		private var summonTick:Number = 1000;
		
		private var dayBg:Sprite;
		private var dayBgStats:Array = [[0x0099FF, 0x6699FF], [0.8, 0.8], [0x00, 0xFF]];
		private var nightBg:Sprite;
		private var nightBgStats:Array = [[0x000033, 0x000099], [0.9, 0.9], [0x00, 0xFF]];
		private var bgMat:Matrix = new Matrix();
		private var dayTimer:Timer;
		private var dayTick:int = 30000;
		private var dayTween:Tween;
		private var ground:Sprite;
		private var catapult:Catapult;
		private var castle:Castle;
		
		private var catapultCooldown:CatCooldown;
		private var coinDrop:CoinDrop;
		private var numEnemies:NumEnemies;
		private var catapultPower:CatPower;
		private var autoMine:AutoMine;
		private var mineFrequency:MineFrequency;
		private var megaLaunchFiller:MegaLaunchFiller;
		private var upgradePool:Array;
		
		private var mineTimer:Timer;
		private var money:Money;
		private var diamond:Diamond;
		
		private var megaLaunch:MegaLaunch;
		private var maxLaunch:Number;
		private var numberLaunches:int;
				
		private var saveTimer:Timer;
		private var saveTick:Number = 5000;
		
		public function Main() {
			QuickKong.connectToKong(stage);
			SharedObjectManager.setup();
			stageRef = stage;
			dayBg = new Sprite();
			nightBg = new Sprite();
			bgMat.createGradientBox(800, 600, Math.PI/2);
			trace("Hello");
			if (SharedObjectManager.getData("Launch")!=null) {
				numberLaunches = int(Simplecrypt.decrypt(SharedObjectManager.getData("Launch")[0]));
				maxLaunch = Number(Simplecrypt.decrypt(SharedObjectManager.getData("Launch")[1]));
			} else {
				numberLaunches = 0;
				maxLaunch = 0;
			}
			
			drawBackground();
			drawGround();
			army = new Array();
			catapult = new Catapult();
			addChild(catapult);
			castle = new Castle();
			addChild(castle);
			castle.y = stageRef.height-ground.height-castle.height;
			upgradePool = new Array();
			addUpgrades();
			
			money = new Money();
			money.x = 0;
			money.y = 0;
			addChild(money);
			
			diamond = new Diamond();
			diamond.y = money.height;
			addChild(diamond);
			upgradePool.push(diamond);
			
			mineTimer = new Timer(MineFrequency.showStat()*1000,1);
			mineTimer.addEventListener(TimerEvent.TIMER, onMineTick, false, 0, true);
			mineTimer.start();
			
			megaLaunch = new MegaLaunch();
			addChild(megaLaunch);
			
			saveTimer = new Timer(saveTick);
			saveTimer.addEventListener(TimerEvent.TIMER, onSaveTick, false, 0, true);
			saveTimer.start();
			
			setChildIndex(clearData, numChildren-1);
			clearData.addEventListener(MouseEvent.CLICK, onClickClear, false, 0, true);
			
			dayTimer = new Timer(dayTick);
			dayTimer.addEventListener(TimerEvent.TIMER, timeChange, false, 0, true);
			dayTimer.start();
			
			addEventListener(Event.ADDED_TO_STAGE, onAddToStage, false, 0, true);
		}
		
		public function onAddToStage(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, onAddToStage);
			addEventListener(Event.ENTER_FRAME, frameHandler, false, 0, true);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, moneyHandler, false, 0, true);
		}
		
		private function drawBackground():void {
			dayBg.graphics.beginGradientFill(GradientType.LINEAR, dayBgStats[0], dayBgStats[1], dayBgStats[2], bgMat);
			dayBg.graphics.drawRect(0,0,800,600);
			dayBg.graphics.endFill();
			addChild(dayBg);
			nightBg.graphics.beginGradientFill(GradientType.LINEAR, nightBgStats[0], nightBgStats[1], nightBgStats[2], bgMat);
			nightBg.graphics.drawRect(0,0,800,600);
			nightBg.graphics.endFill();
			nightBg.alpha = 0;
			addChild(nightBg);
			setChildIndex(dayBg,0);
			setChildIndex(nightBg,1);
		}
		private function drawGround():void {
			ground = new Sprite();
			var gColors:Array = [0x009900, 0x009933];
			var gAlphas:Array = [1, 1];
			var gRatios:Array = [0xF0, 0xFF];
			var gMat:Matrix = new Matrix();
			gMat.createGradientBox(800,34,Math.PI/2,0,0);
			ground.graphics.beginGradientFill(GradientType.LINEAR, gColors, gAlphas, gRatios, gMat);
			ground.graphics.drawRect(0,stage.stageHeight-21,800,21);
			ground.graphics.endFill();
			addChildAt(ground,2);
		}//end background drawing
		
		private function addUpgrades():void {
			catapultCooldown = new CatCooldown();
			catapultCooldown.x = 170;
			addChild(catapultCooldown);
			upgradePool.push(catapultCooldown);
						
			catapultPower = new CatPower();
			catapultPower.x = catapultCooldown.x + catapultCooldown.width + 25;
			addChild(catapultPower);
			upgradePool.push(catapultPower);
			
			autoMine = new AutoMine();
			autoMine.x = catapultPower.x + catapultPower.width + 25;
			addChild(autoMine);
			upgradePool.push(autoMine);
			
			coinDrop = new CoinDrop();
			coinDrop.x = catapultCooldown.x;
			coinDrop.y = catapultCooldown.height;
			addChild(coinDrop);
			upgradePool.push(coinDrop);
			
			numEnemies = new NumEnemies();
			numEnemies.x = catapultPower.x;
			numEnemies.y = catapultPower.height;
			addChild(numEnemies);
			upgradePool.push(numEnemies);
			
			megaLaunchFiller = new MegaLaunchFiller();
			megaLaunchFiller.x = numEnemies.x;
			megaLaunchFiller.y = numEnemies.y + numEnemies.height;
			addChild(megaLaunchFiller);
			upgradePool.push(megaLaunchFiller);
			
			mineFrequency = new MineFrequency();
			mineFrequency.x = autoMine.x;
			mineFrequency.y = autoMine.height;
			addChild(mineFrequency);
			upgradePool.push(mineFrequency);
		}
		
		private function frameHandler(e:Event):void {
			if (canSummon) {
				if (army.length < NumEnemies.showStat()) {
					enemy = new Enemy(stage, stage.stageWidth+40, stage.stageHeight-ground.height-34);
					army.push(enemy);
					stage.addChild(enemy);
					canSummon = false;
					summonTimer = new Timer(summonTick,1);
					summonTimer.addEventListener(TimerEvent.TIMER, onSummonTick, false, 0, true);
					summonTimer.start();
				}
			}
			for each (var enemy in army) {
				if (catapult.canLaunch) {
					if (PixelPerfectCollisionDetection.isColliding(enemy, catapult, this, true)) {
						dispatchEvent(new Event("triggered!",true));
						if (megaLaunch.currentFill==megaLaunch.maxFill) {
							numberLaunches++;
							enemy.launched(5*CatPower.showStat());
							money.addToValue(3*CoinDrop.showStat());
							megaLaunch.updateFill(-200);
							var distance:Number = Math.floor(Math.random()*5*CatPower.showStat()+catapultPower.currentLevel*5*CatPower.showStat());
							distance*=(1+numberLaunches/100);
							distance = (int(distance*100))/100;
							var isMax:Boolean = false;
							if (distance>maxLaunch) {
								maxLaunch = distance;
								isMax = true;
								QuickKong.stats.submit("Furthest Launch", maxLaunch);
							}
							var notification:DistanceNotification = new DistanceNotification(distance, isMax);
							notification.x = 350;
							notification.y = 300;
							addChild(notification);
						} else {
							enemy.launched(CatPower.showStat());
							money.addToValue(CoinDrop.showStat());
							megaLaunch.updateFill(MegaLaunchFiller.showStat());
						}
					}
				} else if (PixelPerfectCollisionDetection.isColliding(enemy, castle, this, true)) {
					enemy.attacking();
					enemy.x+=3;
				}
				enemy.addEventListener(Event.REMOVED_FROM_STAGE, enemyRemove, false, 0, true);
			}
			for each (var upgrade in upgradePool) {
				if (upgrade.upgradeCostValue <= Money.showMoney()) {
					upgrade.upgradeTextField.textColor = 0xFF0000;
					upgrade.upgradeButton.addEventListener(MouseEvent.CLICK, upgradedUpgrade, false, 0, true);
				} else {
					upgrade.upgradeTextField.textColor = 0x0000FF;
					upgrade.upgradeButton.removeEventListener(MouseEvent.CLICK, upgradedUpgrade);
				}
			}
		}//end frameHandler
		
		private function upgradedUpgrade(me:Event):void {
			money.addToValue(-me.currentTarget.parent.upgradeCostValue);
			me.currentTarget.parent.updateLevel();
		}
		
		private function moneyHandler(ke:KeyboardEvent):void {
			if (ke.keyCode == Keyboard.SPACE) {
				money.addToValue(100000);
			}
		}
		
		private function onClickClear(me:MouseEvent):void {
			SharedObjectManager.destroy();
		}
		
		private function timeChange(te:TimerEvent):void {
			dayTween = new Tween(dayBg, "alpha", Regular.easeInOut, dayBg.alpha, 0.8-dayBg.alpha, 2, true);
			dayTween = new Tween(nightBg, "alpha", Regular.easeInOut, nightBg.alpha, 0.9-nightBg.alpha, 2, true);
		}
		
		private function onMineTick(te:TimerEvent):void {
			money.addToValue(AutoMine.showStat());
			mineTimer = new Timer(MineFrequency.showStat()*1000, 1);
			mineTimer.addEventListener(TimerEvent.TIMER, onMineTick, false, 0, true);
			mineTimer.start();
		}
		
		private function onSaveTick(te:TimerEvent):void { trace("saving");
			SharedObjectManager.setData("Money", Simplecrypt.encrypt(Money.showMoney().toString()));
			SharedObjectManager.setData("Diamond", Simplecrypt.encrypt(diamond.currentStatValue.toString()));
			SharedObjectManager.setData("Filler", megaLaunch.currentFill);
			SharedObjectManager.setData("Launch", [Simplecrypt.encrypt(numberLaunches.toString()), Simplecrypt.encrypt(maxLaunch.toString())]);
			QuickKong.stats.submit("Money", money.maxMoney);
			QuickKong.stats.submit("Diamonds", diamond.currentStatValue);
		}
		
		private function onSummonTick(te:TimerEvent):void {
			canSummon = true;
		}
				
		private function enemyRemove(e:Event):void {
			e.currentTarget.removeEventListener(Event.REMOVED_FROM_STAGE, enemyRemove);
			army.splice(army.indexOf(e.currentTarget),1);
		}		
	}
}