package net.play5d.game.bvn.utils
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.geom.Point;
   
   public class GameUtils
   {
      
      public function GameUtils()
      {
         super();
      }
      
      public static function isInTop(param1:DisplayObject, param2:DisplayObjectContainer = null, param3:Point = null) : Boolean
      {
         var _loc6_:DisplayObject = null;
         var _loc4_:DisplayObjectContainer = null;
         if(!param2)
         {
            param2 = param1.stage;
         }
         if(!param3)
         {
            param3 = new Point(1,1);
            try
            {
               param3.x = param2.stage.stageWidth / 2;
               param3.y = param2.stage.stageHeight / 2;
            }
            catch(err:*)
            {
            }
         }
         var _loc5_:Array = param2.getObjectsUnderPoint(param3);
         if(_loc5_ && _loc5_.length > 0)
         {
            _loc6_ = _loc5_.pop();
            if(param1 is DisplayObjectContainer)
            {
               _loc4_ = param1 as DisplayObjectContainer;
               return _loc4_.contains(_loc6_);
            }
            return _loc6_ == param1;
         }
         return false;
      }
   }
}

