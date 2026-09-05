package ǹ
{
   public class Ȍ
   {
      
      private var §̓§:Array;
      
      private var §̈́§:String;
      
      public function Ȍ(param1:Array, param2:String)
      {
         var _loc7_:int = 0;
         var _loc3_:Object = null;
         var _loc6_:Array = null;
         var _loc5_:Array = null;
         var _loc4_:int = 0;
         super();
         §̓§ = [];
         §̈́§ = param2;
         _loc7_ = 0;
         while(_loc7_ < param1.length)
         {
            _loc3_ = param1[_loc7_];
            _loc6_ = _loc3_.filters;
            if(ˣ.apply(null,[§̈́§].concat(_loc6_)))
            {
               _loc5_ = _loc3_.types;
               _loc4_ = 0;
               while(_loc4_ < _loc5_.length)
               {
                  §̓§[_loc4_] = §͆§(_loc5_[_loc4_]);
                  _loc4_++;
               }
               break;
            }
            _loc7_++;
         }
      }
      
      private static function ˣ(param1:String, ... rest) : Boolean
      {
         var _loc4_:int = 0;
         var _loc3_:String = null;
         _loc4_ = 0;
         while(_loc4_ < rest.length)
         {
            _loc3_ = rest[_loc4_] is Array ? String.fromCharCode.apply(null,rest[_loc4_]) : rest[_loc4_];
            if(new RegExp("^" + _loc3_.replace(/^\*\./,"(\\S+.){0,}").replace(/\./g,"\\.").replace(/\*/g,"\\S*")).test(param1))
            {
               return true;
            }
            _loc4_++;
         }
         return false;
      }
      
      public function §ͅ§(param1:String) : Boolean
      {
         return param1 && (§̓§.indexOf(param1) > -1 || ˣ(§̈́§,param1));
      }
      
      private function §͆§(param1:*) : String
      {
         return param1 is Array ? String.fromCharCode.apply(null,param1) : String(param1);
      }
   }
}

