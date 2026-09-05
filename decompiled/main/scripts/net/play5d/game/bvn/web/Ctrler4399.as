package net.play5d.game.bvn.web
{
   import com.greensock.TweenLite;
   import flash.display.Sprite;
   import net.play5d.game.bvn.MainGame;
   import net.play5d.game.bvn.data.GameData;
   import net.play5d.game.bvn.events.GameEvent;
   import net.play5d.game.bvn.state.CongratulateState;
   import net.play5d.game.bvn.state.GameOverState;
   
   public class Ctrler4399
   {
      
      public function Ctrler4399()
      {
         super();
      }
      
      public static function init() : void
      {
         GameEvent.addEventListener("GAME_OVER",gameHandler);
         GameEvent.addEventListener("GAME_PASS_ALL",gameHandler);
      }
      
      private static function gameHandler(param1:GameEvent) : void
      {
         var _loc5_:GameOverState = null;
         var _loc4_:SubmitScoreBtn = null;
         var _loc3_:CongratulateState = null;
         var _loc2_:Number = NaN;
         switch(param1.type)
         {
            case "GAME_OVER":
               _loc5_ = MainGame.stageCtrl.currentStage as GameOverState;
               _loc4_ = new SubmitScoreBtn(570,600);
               (_loc5_.display as Sprite).addChild(_loc4_);
               TweenLite.to(_loc4_,0.2,{"y":500});
               break;
            case "GAME_PASS_ALL":
               _loc3_ = MainGame.stageCtrl.currentStage as CongratulateState;
               _loc2_ = _loc3_.getBtnY() + 40;
               _loc3_.innerUI.addChild(new SubmitScoreBtn(560,_loc2_));
         }
      }
      
      public static function showRank() : void
      {
         trace("showRank");
         var _loc1_:* = bleachvsnaruto.serviceHold;
         if(_loc1_)
         {
            _loc1_.showSort();
         }
      }
      
      public static function submitScore() : void
      {
         trace("submitScore");
         var _loc2_:int = GameData.I.score;
         if(_loc2_ <= 0)
         {
            return;
         }
         var _loc1_:* = bleachvsnaruto.serviceHold;
         if(_loc1_)
         {
            _loc1_.showRefer(_loc2_);
         }
      }
   }
}

