package net.play5d.game.bvn.web
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.DataEvent;
   import flash.events.KeyboardEvent;
   import flash.net.LocalConnection;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import net.play5d.game.bvn.MainGame;
   import net.play5d.game.bvn.ctrl.GameLogic;
   import net.play5d.game.bvn.data.ConfigVO;
   import net.play5d.game.bvn.input.GameKeyInput;
   import net.play5d.game.bvn.input.IGameInput;
   import net.play5d.game.bvn.interfaces.GameInterface;
   import net.play5d.game.bvn.interfaces.IExtendConfig;
   import net.play5d.game.bvn.interfaces.IFighterActionCtrl;
   import net.play5d.game.bvn.interfaces.IGameInterface;
   import net.play5d.kyo.KyoSharedObject;
   
   public class GameInterfaceManager implements IGameInterface
   {
      
      public function GameInterfaceManager()
      {
         super();
         if(new LocalConnection().domain == String.fromCharCode(108,111,99,97,108,104,111,115,116))
         {
            bleachvsnaruto.STAGE.addEventListener("5d_message",messageHandler);
         }
      }
      
      public function initTitleUI(param1:DisplayObject) : void
      {
      }
      
      public function moreGames() : void
      {
         var _loc1_:* = bleachvsnaruto.serviceHold;
         if(_loc1_)
         {
            _loc1_.showGameList();
         }
         MainGame.I.stage.dispatchEvent(new DataEvent("5d_message",false,false,JSON.stringify(["more_games"])));
      }
      
      public function submitScore(param1:int) : void
      {
         var _loc2_:* = bleachvsnaruto.serviceHold;
         if(_loc2_)
         {
            _loc2_.showRefer(param1);
         }
      }
      
      public function showRank() : void
      {
         var _loc1_:* = bleachvsnaruto.serviceHold;
         if(_loc1_)
         {
            _loc1_.showSort();
         }
      }
      
      public function saveGame(param1:Object) : void
      {
         KyoSharedObject.save("bvn3_save",param1);
         trace("saveData",JSON.stringify(param1));
      }
      
      public function loadGame() : Object
      {
         var _loc1_:Object = KyoSharedObject.load("bvn3_save");
         if(_loc1_)
         {
            trace("loadData",JSON.stringify(_loc1_));
         }
         return _loc1_;
      }
      
      public function getFighterCtrl(param1:int) : IFighterActionCtrl
      {
         return null;
      }
      
      public function getGameMenu() : Array
      {
         var _loc2_:Array = GameInterface.getDefaultMenu();
         var _loc1_:Array = _loc2_.slice(0,4);
         _loc1_.push({
            "txt":"RANK",
            "cn":"排行榜",
            "func":Ctrler4399.showRank
         });
         return _loc1_.concat(_loc2_.splice(4));
      }
      
      public function getSettingMenu() : Array
      {
         return null;
      }
      
      public function getGameInput(param1:String) : Vector.<IGameInput>
      {
         var _loc2_:Vector.<IGameInput> = new Vector.<IGameInput>();
         _loc2_.push(new GameKeyInput());
         return _loc2_;
      }
      
      public function getConfigExtend() : IExtendConfig
      {
         return null;
      }
      
      public function afterBuildGame() : void
      {
      }
      
      private function messageHandler(param1:DataEvent) : void
      {
         var _loc3_:String = param1.data;
         var _loc2_:Object = JSON.parse(_loc3_);
         trace("receive message",_loc2_[0]);
         if(_loc2_[0] == "games_inited")
         {
            bleachvsnaruto.STAGE.addEventListener("keyUp",keyHandler);
         }
      }
      
      private function keyHandler(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == 119 && param1.ctrlKey)
         {
            GameLogic.setGameMode(1);
         }
         if(param1.keyCode == 120 && param1.ctrlKey)
         {
            GameLogic.setGameMode(0);
         }
      }
      
      public function updateInputConfig() : Boolean
      {
         return false;
      }
      
      public function applyConfig(param1:ConfigVO) : void
      {
      }
      
      public function getCreadits(param1:String) : Sprite
      {
         param1 += "游戏出品：5dplay<br/>";
         param1 += "发布支持：GreenHD<br/>";
         var _loc2_:Sprite = new Sprite();
         var _loc4_:TextField = new TextField();
         var _loc3_:TextFormat = new TextFormat();
         _loc3_.font = "微软雅黑";
         _loc3_.size = 20;
         _loc3_.color = 16776960;
         _loc3_.leading = 15;
         _loc4_.defaultTextFormat = _loc3_;
         _loc4_.multiline = true;
         _loc4_.htmlText = param1;
         _loc4_.autoSize = "left";
         _loc4_.x = 50;
         _loc4_.y = 30;
         _loc2_.addChild(_loc4_);
         return _loc2_;
      }
   }
}

