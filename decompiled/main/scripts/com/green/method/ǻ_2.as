package com.green.method
{
   import flash.utils.getDefinitionByName;
   
   public class ǻ
   {
      
      public function ǻ()
      {
         super();
      }
      
      public static function get ˁ() : Boolean
      {
         return §˔§(true) == uts(99,110);
      }
      
      public static function get ʶ() : String
      {
         return gd(uts(102,108,97,115,104,46,101,120,116,101,114,110,97,108,46,69,120,116,101,114,110,97,108,73,110,116,101,114,102,97,99,101))[uts(111,98,106,101,99,116,73,68)];
      }
      
      public static function get §˂§() : String
      {
         var _loc2_:String = uts(112,97,103,101,68,111,109,97,105,110);
         var _loc1_:* = gd(uts(102,108,97,115,104,46,115,121,115,116,101,109,46,83,101,99,117,114,105,116,121));
         return _loc2_ in _loc1_ ? _loc1_[_loc2_] : null;
      }
      
      public static function get currentDomain() : String
      {
         try
         {
            return new (gd(uts(102,108,97,115,104,46,110,101,116,46,76,111,99,97,108,67,111,110,110,101,99,116,105,111,110)))()[uts(100,111,109,97,105,110)];
         }
         catch(e:*)
         {
         }
         return null;
      }
      
      public static function get §˃§() : Boolean
      {
         try
         {
            return !!gd(uts(102,108,97,115,104,46,101,118,101,110,116,115,46,84,104,114,111,116,116,108,101,69,118,101,110,116));
         }
         catch(e:*)
         {
         }
         return false;
      }
      
      public static function get §˄§() : Boolean
      {
         try
         {
            gd(uts(102,108,97,115,104,46,110,101,116,46,110,97,118,105,103,97,116,101,84,111,85,82,76))(new (gd(uts(102,108,97,115,104,46,110,101,116,46,85,82,76,82,101,113,117,101,115,116)))(),null);
         }
         catch(e:Error)
         {
            if(e is gd(uts(83,101,99,117,114,105,116,121,69,114,114,111,114)))
            {
               return false;
            }
         }
         return true;
      }
      
      public static function get §˅§() : Boolean
      {
         try
         {
            return ɑ(uts(101,118,97,108),true);
         }
         catch(e:*)
         {
         }
         return false;
      }
      
      public static function ˆ(param1:String) : Boolean
      {
         return gd(uts(102,108,97,115,104,46,100,101,115,107,116,111,112,46,67,108,105,112,98,111,97,114,100))[uts(103,101,110,101,114,97,108,67,108,105,112,98,111,97,114,100)][uts(115,101,116,68,97,116,97)](uts(97,105,114,58,116,101,120,116),param1);
      }
      
      private static function get ˇ() : *
      {
         return gd(uts(102,108,97,115,104,46,115,121,115,116,101,109,46,67,97,112,97,98,105,108,105,116,105,101,115));
      }
      
      private static function get ˈ() : String
      {
         return ˇ[uts(112,108,97,121,101,114,84,121,112,101)];
      }
      
      public static function get ˉ() : Boolean
      {
         return ˈ == uts(68,101,115,107,116,111,112);
      }
      
      public static function get ɵ() : Boolean
      {
         return ˈ == uts(65,99,116,105,118,101,88);
      }
      
      public static function get ˊ() : Boolean
      {
         return ˈ == uts(80,108,117,103,73,110) && ˇ[uts(109,97,110,117,102,97,99,116,117,114,101,114)][uts(105,110,100,101,120,79,102)](uts(80,101,112,112,101,114)) > -1;
      }
      
      public static function get ˋ() : Boolean
      {
         return ˈ == uts(80,108,117,103,73,110);
      }
      
      public static function get ˌ() : Boolean
      {
         return ɵ || ˋ;
      }
      
      public static function get ʸ() : String
      {
         return new (gd(uts(102,108,97,115,104,46,100,105,115,112,108,97,121,46,76,111,97,100,101,114)))()[uts(99,111,110,116,101,110,116,76,111,97,100,101,114,73,110,102,111)][uts(108,111,97,100,101,114,85,82,76)];
      }
      
      public static function get ˍ() : Boolean
      {
         return ʸ[uts(105,110,100,101,120,79,102)](uts(102,105,108,101,58)) == 0;
      }
      
      public static function get ˎ() : Boolean
      {
         return ˇ[uts(105,115,68,101,98,117,103,103,101,114)];
      }
      
      public static function get ˏ() : Boolean
      {
         return ˈ == uts(69,120,116,101,114,110,97,108) || ˈ == uts(83,116,97,110,100,65,108,111,110,101);
      }
      
      public static function get ː() : Number
      {
         var _loc2_:Array = §˒§.split(/[^\d]/);
         return parseFloat(_loc2_[0] + "." + _loc2_[1]);
      }
      
      private static function get ˑ() : String
      {
         return ˇ[uts(118,101,114,115,105,111,110)];
      }
      
      public static function get §˒§() : String
      {
         return ˑ.split(" ").pop();
      }
      
      public static function get §˓§() : String
      {
         return ˑ.replace(/,/g,".");
      }
      
      public static function §˔§(param1:Boolean = false, param2:String = null) : String
      {
         var _loc3_:String = param2 || ˇ[uts(108,97,110,103,117,97,103,101)];
         return param1 ? _loc3_.replace(/zh-[A-Za-z]+/,uts(99,110)) : _loc3_;
      }
      
      public static function §˕§(param1:Boolean = true, param2:Boolean = false) : String
      {
         var _loc3_:Date = new Date();
         return _loc3_.fullYear + "-" + (_loc3_.month + 1) + "-" + _loc3_.date + (param1 ? " " + (_loc3_.hours < 10 ? "0" : "") + _loc3_.hours + ":" + (_loc3_.minutes < 10 ? "0" : "") + _loc3_.minutes + ":" + (_loc3_.seconds < 10 ? "0" : "") + _loc3_.seconds + (param2 ? "." + _loc3_.milliseconds : "") : "");
      }
      
      public static function get §˖§() : Boolean
      {
         try
         {
            return gd(uts(102,108,97,115,104,46,117,105,46,77,117,108,116,105,116,111,117,99,104))[uts(115,117,112,112,111,114,116,101,100,71,101,115,116,117,114,101,115)].length > 0;
         }
         catch(e:Error)
         {
         }
         return false;
      }
      
      public static function §˗§() : void
      {
         if(ˉ)
         {
            gd(uts(102,108,97,115,104,46,100,101,115,107,116,111,112,46,78,97,116,105,118,101,65,112,112,108,105,99,97,116,105,111,110))[uts(110,97,116,105,118,101,65,112,112,108,105,99,97,116,105,111,110)][uts(101,120,105,116)]();
         }
         else if(ˌ && §˅§)
         {
            ɑ(uts(99,108,111,115,101));
         }
         else
         {
            gd(uts(102,108,97,115,104,46,115,121,115,116,101,109,46,102,115,99,111,109,109,97,110,100))(uts(113,117,105,116));
         }
      }
      
      private static function uts(... rest) : String
      {
         return "".constructor.fromCharCode.apply(null,rest);
      }
      
      private static function ɑ(param1:String, ... rest) : *
      {
         return gd(uts(102,108,97,115,104,46,101,120,116,101,114,110,97,108,46,69,120,116,101,114,110,97,108,73,110,116,101,114,102,97,99,101))[uts(99,97,108,108)][uts(97,112,112,108,121)](null,[param1].concat(rest));
      }
      
      private static function gd(param1:String) : *
      {
         return getDefinitionByName(param1);
      }
      
      public static function get §˘§() : Boolean
      {
         var _loc1_:String = null;
         var _loc4_:RegExp = null;
         var _loc3_:Array = null;
         var _loc6_:int = 0;
         var _loc2_:String = null;
         var _loc5_:String = null;
         try
         {
            ɑ(uts(39,39,46,116,111,83,116,114,105,110,103));
         }
         catch(error:Error)
         {
            if(error.errorID == 2060)
            {
               _loc1_ = error.message as String;
               _loc4_ = /[a-zA-Z]+:\/+[%:a-zA-Z0-9\/\.\-]+/g;
               _loc3_ = _loc1_.match(_loc4_);
               if(_loc3_ && _loc3_.length)
               {
                  _loc6_ = 0;
                  while(_loc6_ < _loc3_.length)
                  {
                     _loc2_ = _loc3_[_loc6_];
                     if(_loc2_.charAt(_loc2_.length - 1) == ".")
                     {
                        _loc2_ = _loc2_.slice(0,-1);
                        _loc3_[_loc6_] = _loc2_;
                     }
                     _loc4_.lastIndex = 0;
                     if(_loc4_.test(_loc2_) == false)
                     {
                        _loc3_.splice(_loc6_,1);
                        _loc6_--;
                     }
                     _loc6_++;
                  }
                  if(_loc3_.length)
                  {
                     _loc5_ = _loc3_.pop();
                     if(_loc5_.indexOf(uts(102,105,108,101,58,47,47,47)) == 0)
                     {
                        return true;
                     }
                  }
               }
            }
         }
         return false;
      }
   }
}

