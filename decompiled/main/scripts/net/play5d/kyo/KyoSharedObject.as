package net.play5d.kyo
{
   import flash.net.SharedObject;
   
   public class KyoSharedObject
   {
      
      public function KyoSharedObject()
      {
         super();
      }
      
      public static function load(param1:String) : Object
      {
         var _loc2_:SharedObject = SharedObject.getLocal(param1);
         var _loc3_:Object = _loc2_.data;
         _loc2_.close();
         return _loc3_;
      }
      
      public static function save(param1:String, param2:Object) : void
      {
         var _loc4_:String = null;
         var _loc3_:SharedObject = SharedObject.getLocal(param1);
         _loc3_.clear();
         for(_loc4_ in param2)
         {
            _loc3_.data[_loc4_] = param2[_loc4_];
         }
         _loc3_.flush();
         _loc3_.close();
      }
      
      public static function deletee(param1:String) : void
      {
         var _loc2_:SharedObject = SharedObject.getLocal(param1);
         _loc2_.clear();
      }
   }
}

