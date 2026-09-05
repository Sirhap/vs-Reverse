package ȁ
{
   import flash.utils.ByteArray;
   
   public class Ȅ
   {
      
      public static const FWS:String = "FWS";
      
      public static const CWS:String = "CWS";
      
      public static const ZWS:String = "ZWS";
      
      public function Ȅ()
      {
         super();
      }
      
      public static function §̩§(param1:ByteArray, param2:String) : ByteArray
      {
         var _loc5_:ByteArray = §̬§(param1);
         if(!_loc5_)
         {
            throw new Error("目标格式错误");
         }
         var _loc3_:ByteArray = new ByteArray();
         _loc3_.endian = "littleEndian";
         _loc3_.writeUTFBytes(param2);
         _loc3_.writeByte(param1[3]);
         var _loc4_:uint = _loc5_.length + 8;
         switch(param2)
         {
            case "FWS":
               _loc3_.writeUnsignedInt(_loc4_);
               _loc3_.writeBytes(_loc5_);
               break;
            case "CWS":
               _loc3_.writeUnsignedInt(_loc4_);
               _loc5_.compress("zlib");
               _loc3_.writeBytes(_loc5_);
               break;
            case "ZWS":
               _loc3_.writeUnsignedInt(_loc4_ + 8);
               _loc5_.compress("lzma");
               _loc3_.writeUnsignedInt(_loc5_.length - 13);
               _loc3_.writeBytes(_loc5_,0,5);
               _loc3_.writeBytes(_loc5_,13);
         }
         _loc3_.position = 0;
         return _loc3_;
      }
      
      public static function §̪§(param1:String) : Boolean
      {
         switch(param1)
         {
            case "FWS":
            case "CWS":
            case "ZWS":
               return true;
            default:
               return false;
         }
      }
      
      public static function §̫§(param1:ByteArray) : uint
      {
         var _loc3_:* = 0;
         var _loc2_:String = null;
         var _loc4_:uint = 0;
         if(param1.length >= 8)
         {
            _loc3_ = param1.position;
            _loc2_ = param1.endian;
            param1.endian = "littleEndian";
            param1.position = 4;
            _loc4_ = param1.readUnsignedInt();
            param1.endian = _loc2_;
            param1.position = _loc3_;
         }
         return _loc4_;
      }
      
      public static function §̬§(param1:ByteArray) : ByteArray
      {
         var _loc2_:ByteArray = null;
         switch(§̱§(param1))
         {
            case "FWS":
               _loc2_ = new ByteArray();
               _loc2_.endian = "littleEndian";
               _loc2_.writeBytes(param1,8);
               _loc2_.position = 0;
               break;
            case "CWS":
               _loc2_ = new ByteArray();
               _loc2_.endian = "littleEndian";
               _loc2_.writeBytes(param1,8);
               _loc2_.uncompress("zlib");
               break;
            case "ZWS":
               if((param1[8] | param1[9] << 8 | param1[10] << 16 | param1[11] << 24) != param1.length - 12 - 5)
               {
                  return null;
               }
               try
               {
                  _loc2_ = §̭§(param1,0);
               }
               catch(error:Error)
               {
                  _loc2_ = §̭§(param1,-8);
               }
         }
         return _loc2_;
      }
      
      private static function §̭§(param1:ByteArray, param2:int) : ByteArray
      {
         var _loc4_:ByteArray = new ByteArray();
         _loc4_ = new ByteArray();
         _loc4_.endian = "littleEndian";
         _loc4_.writeBytes(param1,12,5);
         var _loc3_:int = param1[4] | param1[5] << 8 | param1[6] << 16 | param1[7] << 24;
         _loc4_.writeUnsignedInt(_loc3_ - 8 + param2);
         _loc4_.writeUnsignedInt(0);
         _loc4_.position = 13;
         _loc4_.writeBytes(param1,17);
         _loc4_.uncompress("lzma");
         return _loc4_;
      }
      
      public static function §̮§(param1:ByteArray) : Array
      {
         var _loc5_:ByteArray = null;
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc8_:int = 0;
         var _loc6_:int = 0;
         var _loc3_:int = 0;
         var _loc9_:* = 0;
         var _loc11_:* = 0;
         var _loc10_:Array = [];
         var _loc7_:int = 0;
         var _loc12_:uint = param1.position;
         var _loc13_:String = param1.endian;
         switch(§̱§(param1))
         {
            case "FWS":
               _loc5_ = param1;
               _loc5_.endian = "littleEndian";
               _loc5_.position = 21;
               break;
            case "CWS":
               _loc5_ = new ByteArray();
               _loc5_.endian = "littleEndian";
               _loc5_.writeBytes(param1,8);
               _loc5_.uncompress("zlib");
               _loc5_.position = 13;
               break;
            case "ZWS":
               _loc5_ = new ByteArray();
               _loc5_.endian = "littleEndian";
               _loc5_.writeBytes(param1,8);
               _loc5_.uncompress("lzma");
               _loc5_.position = 13;
               break;
            default:
               throw new Error("不能识别的SWF文件格式");
         }
         while(_loc5_.bytesAvailable > 0)
         {
            _loc2_ = int(_loc5_.readUnsignedShort());
            _loc4_ = _loc2_ >> 6;
            _loc8_ = _loc2_ & 0x3F;
            if((_loc8_ & 0x3F) == 63)
            {
               _loc8_ = int(_loc5_.readUnsignedInt());
            }
            if(_loc4_ == 76)
            {
               _loc6_ = 0;
               _loc3_ = _loc5_.readShort();
               while(_loc6_ < _loc3_)
               {
                  _loc5_.readShort();
                  _loc9_ = _loc5_.position;
                  while(_loc5_.readByte() != 0)
                  {
                  }
                  _loc11_ = _loc5_.position;
                  _loc5_.position = _loc9_;
                  _loc10_[_loc7_++] = _loc5_.readUTFBytes(_loc11_ - _loc9_);
                  _loc6_++;
               }
            }
            else
            {
               _loc5_.position += _loc8_;
            }
         }
         param1.position = _loc12_;
         param1.endian = _loc13_;
         return _loc10_;
      }
      
      public static function §̯§(param1:ByteArray, param2:uint) : Boolean
      {
         return false;
      }
      
      public static function §̰§(param1:ByteArray) : void
      {
         var _loc2_:int = 0;
         if(param1.length > 8)
         {
            _loc2_ = 0;
            while(_loc2_ < 8)
            {
               param1[_loc2_] = int(255 * Math.random());
               _loc2_++;
            }
         }
      }
      
      public static function §̱§(param1:ByteArray) : String
      {
         if(param1.length < 8)
         {
            return null;
         }
         var _loc2_:uint = param1.position;
         param1.position = 0;
         var _loc3_:String = param1.readUTFBytes(3);
         param1.position = _loc2_;
         return _loc3_;
      }
   }
}

