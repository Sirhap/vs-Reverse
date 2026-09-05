package ȁ
{
   import flash.utils.ByteArray;
   
   public class Ȃ
   {
      
      public static const AUTO:String = "auto";
      
      public static const §̕§:String = "gb18030";
      
      public static const ANSI:String = "gb18030";
      
      public static const §̖§:String = "utf-8";
      
      public function Ȃ()
      {
         super();
      }
      
      public static function join(param1:*, ... rest) : String
      {
         return rest.join(param1);
      }
      
      public static function add(... rest) : String
      {
         return rest.join("");
      }
      
      public static function §̗§(param1:Number, param2:int = 2, param3:String = " ") : String
      {
         var _loc4_:Array = ["B","KB","MB","GB","TB","PB","EB","ZB","YB","BB"];
         var _loc5_:int = 0;
         while(param1 >= 1000 && _loc5_ < _loc4_.length)
         {
            _loc5_++;
            param1 /= 1024;
         }
         return parseFloat(param1.toFixed(param2)) + param3 + _loc4_[_loc5_];
      }
      
      public static function §̘§(param1:String, param2:String) : int
      {
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(param1 && param2)
         {
            _loc5_ = param1.indexOf(param2);
            _loc3_ = param2.length;
            while(_loc5_ > -1)
            {
               _loc4_++;
               _loc5_ = param1.indexOf(param2,_loc5_ + _loc3_);
            }
         }
         return _loc4_;
      }
      
      public static function §̙§(param1:String, param2:int = 0) : Boolean
      {
         var _loc3_:int = param1.charCodeAt(param2);
         return _loc3_ >= 19968 && _loc3_ <= 40959;
      }
      
      public static function §̚§(param1:*, param2:int = 1) : String
      {
         var _loc3_:String = null;
         var _loc4_:String;
         _loc3_ = _loc4_ = param1 + "";
         var _loc5_:int = 0;
         while(_loc5_++ < param2)
         {
            _loc3_ += _loc4_;
         }
         return _loc3_;
      }
      
      public static function §̛§(param1:*, param2:int = 1) : String
      {
         var _loc4_:int = 0;
         var _loc3_:String = "";
         _loc4_ = 0;
         while(_loc4_ < param2)
         {
            _loc3_ += param1;
            _loc4_++;
         }
         return _loc3_;
      }
      
      public static function §̜§(param1:String, param2:Boolean = true) : *
      {
         return JSON.parse(param2 ? §̠§(param1) : param1);
      }
      
      public static function §̝§(param1:ByteArray, param2:Boolean = true, param3:String = "auto") : *
      {
         var _loc4_:String = param3 == "auto" ? §̥§(param1,true,0,param1.length) : §̣§(param1,param3,0,param1.length);
         return §̜§(_loc4_,param2);
      }
      
      public static function §̞§(param1:String) : String
      {
         return param1.replace(/(^\s+)|(\s+$)/g,"");
      }
      
      public static function §̟§(param1:String) : String
      {
         return param1.replace(/((\n)\s*\n){1,}/g,"\n").replace(/^\r?\n/,"");
      }
      
      public static function §̠§(param1:String) : String
      {
         var _loc9_:int = 0;
         var _loc6_:String = null;
         var _loc12_:int = 0;
         var _loc2_:int = 0;
         var _loc4_:String = null;
         var _loc13_:int = 0;
         var _loc5_:int = 0;
         var _loc11_:int = 0;
         var _loc8_:int = 0;
         var _loc14_:String = null;
         var _loc10_:int = 0;
         var _loc3_:Array = param1.split(/[\r\n]+/);
         var _loc7_:uint = _loc3_.length;
         _loc9_ = 0;
         for(; _loc9_ < _loc7_; _loc9_++)
         {
            _loc6_ = _loc3_[_loc9_];
            if(_loc6_)
            {
               _loc12_ = _loc6_.indexOf("/*");
               _loc2_ = _loc6_.indexOf("//");
               if(_loc12_ > -1 && (_loc12_ < _loc2_ || _loc2_ == -1))
               {
                  _loc4_ = _loc6_.slice(0,_loc12_);
                  _loc4_ = _loc4_.replace(/(\"[^\"]*\")|('[^']*\')/g,"");
                  _loc13_ = _loc4_.indexOf("\"");
                  _loc5_ = _loc4_.indexOf("\'");
                  if(_loc13_ == -1 && _loc5_ == -1)
                  {
                     _loc11_ = _loc6_.indexOf("*/",_loc12_ + 2);
                     if(_loc11_ <= -1)
                     {
                        _loc8_ = _loc9_ + 1;
                        while(_loc8_ < _loc7_)
                        {
                           _loc14_ = _loc3_[_loc8_];
                           _loc11_ = _loc14_.indexOf("*/");
                           if(_loc11_ >= 0)
                           {
                              _loc3_[_loc9_] = _loc6_.slice(0,_loc12_);
                              _loc3_[_loc8_] = _loc14_.slice(_loc11_ + 2);
                              break;
                           }
                           _loc3_[_loc8_] = "";
                           _loc8_++;
                        }
                        _loc9_ = _loc8_ - 1;
                        continue;
                     }
                     _loc3_[_loc9_] = _loc6_ = _loc6_.slice(0,_loc12_) + _loc6_.slice(_loc11_ + 2);
                     if(_loc2_ > -1)
                     {
                        _loc2_ = _loc6_.indexOf("//",_loc12_);
                     }
                  }
               }
               _loc10_ = 0;
               while(_loc2_ > -1)
               {
                  _loc4_ = _loc6_.slice(_loc10_,_loc2_);
                  _loc4_ = _loc4_.replace(/(\"[^\"]*\")|('[^']*\')/g,"");
                  _loc13_ = _loc4_.indexOf("\"");
                  _loc5_ = _loc4_.indexOf("\'");
                  if(!(_loc13_ > -1 || _loc5_ > -1))
                  {
                     _loc3_[_loc9_] = _loc6_ = _loc6_.slice(0,_loc2_);
                     break;
                  }
                  if(_loc13_ == -1)
                  {
                     _loc10_ = _loc5_;
                  }
                  else if(_loc5_ == -1)
                  {
                     _loc10_ = _loc13_;
                  }
                  else
                  {
                     _loc10_ = Math.min(_loc13_,_loc5_);
                  }
                  if(_loc10_ == _loc5_)
                  {
                     _loc10_ = _loc6_.indexOf("\'",_loc2_ + 2) + 1;
                  }
                  else
                  {
                     _loc10_ = _loc6_.indexOf("\"",_loc2_ + 2) + 1;
                  }
                  _loc2_ = _loc6_.indexOf("//",_loc10_);
               }
            }
         }
         return _loc3_.join("\n");
      }
      
      public static function §̡§(... rest) : String
      {
         return String.fromCharCode.apply(String,rest);
      }
      
      public static function §̢§(param1:String, param2:int = 0) : Array
      {
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:Array = [];
         _loc5_ = 0;
         _loc4_ = param1.length;
         while(_loc5_ < _loc4_)
         {
            _loc3_[_loc5_] = param1.charCodeAt(_loc5_) + param2;
            _loc5_++;
         }
         return _loc3_;
      }
      
      public static function §̣§(param1:ByteArray, param2:String = "gb18030", param3:uint = 0, param4:uint = 0) : String
      {
         var _loc8_:uint = param1.position;
         var _loc6_:uint = param1.length;
         param3 = param3 <= _loc6_ ? param3 : 0;
         var _loc7_:uint = _loc6_ - param3;
         param4 = param4 > 0 && param4 <= _loc7_ ? param4 : _loc7_;
         param1.position = param3;
         var _loc5_:String = param2 == "utf-8" ? param1.readUTFBytes(param4) : param1.readMultiByte(param4,param2);
         param1.position = _loc8_;
         return _loc5_;
      }
      
      public static function §̤§(param1:ByteArray, param2:String = "auto") : String
      {
         return param2 ? §̣§(param1,param2) : String(param1);
      }
      
      public static function §̥§(param1:ByteArray, param2:Boolean = true, param3:uint = 0, param4:uint = 0) : String
      {
         var _loc9_:uint = param1.position;
         var _loc7_:uint = param1.length;
         param3 = param3 <= _loc7_ ? param3 : 0;
         var _loc8_:uint = _loc7_ - param3;
         param4 = param4 > 0 && param4 <= _loc8_ ? param4 : _loc8_;
         param1.position = param3;
         var _loc6_:String = §̦§(param1,"gb18030",param3,param4,param2);
         var _loc5_:String = _loc6_ == "utf-8" ? param1.readUTFBytes(param4) : param1.readMultiByte(param4,_loc6_);
         param1.position = _loc9_;
         return _loc5_;
      }
      
      public static function §̦§(param1:ByteArray, param2:String = "gb18030", param3:uint = 0, param4:uint = 0, param5:Boolean = true) : String
      {
         var _loc6_:String = null;
         var _loc12_:uint = param1.position;
         var _loc10_:uint = param1.length;
         param3 = param3 <= _loc10_ ? param3 : 0;
         var _loc11_:uint = _loc10_ - param3;
         param4 = param4 > 0 && param4 <= _loc11_ ? param4 : _loc11_;
         if(_loc11_ < 3)
         {
            return param2;
         }
         param1.position = param3;
         param1.position = param3;
         var _loc7_:int = int(param1.readUnsignedByte());
         var _loc8_:int = int(param1.readUnsignedByte());
         var _loc9_:int = int(param1.readUnsignedByte());
         if(_loc7_ == 255 && _loc8_ == 254)
         {
            _loc6_ = "unicode";
         }
         else if(_loc7_ == 254 && _loc8_ == 255)
         {
            _loc6_ = "unicodeFFFE";
         }
         else if(_loc7_ == 239 && _loc8_ == 187)
         {
            _loc6_ = "utf-8";
         }
         else if(param5 && isUTF8(param1,param3,param4))
         {
            _loc6_ = "utf-8";
         }
         else
         {
            _loc6_ = param2;
         }
         param1.position = _loc12_;
         return _loc6_;
      }
      
      public static function isUTF8(param1:ByteArray, param2:uint = 0, param3:uint = 0) : Boolean
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc12_:int = 0;
         var _loc9_:uint = param1.position;
         var _loc7_:uint = param1.length;
         param2 = param2 <= _loc7_ ? param2 : 0;
         var _loc8_:uint = _loc7_ - param2;
         param3 = param3 > 0 && param3 <= _loc8_ ? param3 : _loc8_;
         param1.position = param2;
         var _loc6_:int = 0;
         var _loc10_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:int = int(param3);
         while(_loc14_ > 0)
         {
            param1.position = param2 + (param3 - _loc14_);
            _loc12_ = param1.readByte();
            _loc14_ -= 1;
            if(_loc14_ >= 1)
            {
               _loc4_ = param1.readByte();
            }
            if(_loc14_ >= 2)
            {
               _loc5_ = param1.readByte();
            }
            if((_loc12_ & 0x7F) == _loc12_)
            {
               _loc13_++;
            }
            else if(-64 <= _loc12_ && _loc12_ <= -33 && _loc14_ >= 1 && -128 <= _loc4_ && _loc4_ <= -65)
            {
               _loc10_ += 2;
               _loc14_ -= 1;
            }
            else if(-32 <= _loc12_ && _loc12_ <= -17 && _loc14_ >= 2 && -128 <= _loc4_ && _loc4_ <= -65 && -128 <= _loc5_ && _loc5_ <= -65)
            {
               _loc10_ += 3;
               _loc14_ -= 2;
            }
         }
         param1.position = _loc9_;
         if(_loc13_ == param3)
         {
            return false;
         }
         _loc6_ = 100 * _loc10_ / (param3 - _loc13_);
         if(_loc6_ > 98)
         {
            return true;
         }
         if(_loc6_ > 95 && _loc10_ > 30)
         {
            return true;
         }
         return false;
      }
   }
}

