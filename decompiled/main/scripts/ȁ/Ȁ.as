package ȁ
{
   public class Ȁ
   {
      
      private var §̉§:String;
      
      private var §̊§:Array;
      
      public function Ȁ(param1:String = null)
      {
         super();
         §̋§(param1);
      }
      
      public static function §̏§(param1:String) : String
      {
         return §̓§(param1).join(".");
      }
      
      public static function §̐§(param1:String) : Array
      {
         var _loc2_:String = null;
         var _loc6_:int = 0;
         if(!param1)
         {
            return [0];
         }
         var _loc5_:Array = param1.split(/\.|,/);
         var _loc4_:String = _loc5_.pop();
         var _loc3_:Array = _loc4_.match(/^\d{1,}/);
         if(_loc3_)
         {
            _loc2_ = _loc3_.shift();
            _loc5_.push(_loc2_);
            _loc4_ = _loc4_.replace(_loc2_,"");
         }
         _loc6_ = 0;
         while(_loc6_ < _loc5_.length)
         {
            _loc5_[_loc6_] = parseInt(_loc5_[_loc6_]);
            _loc6_++;
         }
         if(_loc4_.length)
         {
            switch(_loc4_.charAt())
            {
               case " ":
               case "-":
               case "_":
               case ".":
               case ",":
                  _loc4_ = _loc4_.slice(1);
            }
         }
         _loc5_.push(_loc4_);
         return _loc5_;
      }
      
      public static function §̑§(param1:String) : String
      {
         var _loc2_:* = §̐§(param1).pop();
         return _loc2_ is int ? "" : _loc2_;
      }
      
      public static function §̒§(param1:String) : int
      {
         return §̓§(param1)[0];
      }
      
      public static function §̓§(param1:String) : Array
      {
         var _loc3_:Array = §̐§(param1);
         var _loc2_:* = _loc3_[_loc3_.length - 1];
         _loc2_ is String && _loc3_.pop();
         return _loc3_;
      }
      
      public static function §̔§(param1:String, param2:String) : Boolean
      {
         var _loc5_:int = 0;
         var _loc3_:Array = §̓§(param1);
         var _loc4_:Array = §̓§(param2);
         _loc5_ = 0;
         while(_loc5_ < _loc3_.length)
         {
            if(_loc3_[_loc5_] != int(_loc4_[_loc5_]))
            {
               return false;
            }
            _loc5_++;
         }
         return true;
      }
      
      public static function compare(param1:String, param2:String) : int
      {
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc6_:Array = §̓§(param1);
         var _loc7_:Array = §̓§(param2);
         var _loc8_:int = Math.max(_loc6_.length,_loc7_.length);
         if(_loc8_)
         {
            _loc5_ = 0;
            while(_loc5_ < _loc8_)
            {
               _loc3_ = int(_loc6_[_loc5_]);
               _loc4_ = int(_loc7_[_loc5_]);
               if(_loc3_ != _loc4_)
               {
                  return _loc3_ - _loc4_;
               }
               _loc5_++;
            }
         }
         return 0;
      }
      
      public function §̋§(param1:String) : void
      {
         this.§̉§ = param1;
         §̊§ = param1 ? §̓§(param1) : [];
      }
      
      public function compare(param1:Ȁ) : int
      {
         return Ȁ.compare(§̉§,param1.§̉§);
      }
      
      public function §̌§(param1:String = ".") : String
      {
         return §̊§.join(param1);
      }
      
      public function toString(param1:String = ".") : String
      {
         return §̌§(param1);
      }
      
      public function get §̍§() : uint
      {
         return §̊§.length;
      }
      
      public function §̎§(param1:int) : int
      {
         return §̊§[param1];
      }
   }
}

