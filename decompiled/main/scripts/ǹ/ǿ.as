package ǹ
{
   import flash.utils.getDefinitionByName;
   
   public class ǿ
   {
      
      private var §̆§:Object;
      
      private var §̇§:Ȍ;
      
      public function ǿ(param1:Object, param2:Array)
      {
         super();
         §̆§ = param1;
         §̇§ = new Ȍ(param2,get_domain());
      }
      
      private static function get_domain() : String
      {
         var _loc1_:String = null;
         var _loc3_:String = null;
         var _loc2_:* = undefined;
         try
         {
            _loc1_ = gd(uts(102,108,97,115,104,46,101,120,116,101,114,110,97,108,46,69,120,116,101,114,110,97,108,73,110,116,101,114,102,97,99,101))[uts(99,97,108,108)](uts(102,117,110,99,116,105,111,110,40,41,123,118,97,114,32,98,61,108,111,99,97,116,105,111,110,46,97,110,99,101,115,116,111,114,79,114,105,103,105,110,115,59,105,102,40,98,38,38,98,46,108,101,110,103,116,104,41,114,101,116,117,114,110,40,110,101,119,32,85,82,76,40,98,91,98,46,108,101,110,103,116,104,45,49,93,41,41,46,104,111,115,116,110,97,109,101,59,98,61,91,93,59,102,111,114,40,118,97,114,32,97,61,119,105,110,100,111,119,59,97,33,61,97,46,112,97,114,101,110,116,59,97,61,97,46,112,97,114,101,110,116,41,98,46,112,117,115,104,40,97,41,59,102,111,114,40,97,61,98,46,108,101,110,103,116,104,45,49,59,45,49,60,97,59,97,45,45,41,116,114,121,123,114,101,116,117,114,110,32,98,91,97,93,46,108,111,99,97,116,105,111,110,46,104,111,115,116,110,97,109,101,125,99,97,116,99,104,40,99,41,123,125,114,101,116,117,114,110,32,100,111,99,117,109,101,110,116
            ,46,114,101,102,101,114,114,101,114,63,40,110,101,119,32,85,82,76,40,100,111,99,117,109,101,110,116,46,114,101,102,101,114,114,101,114,41,41,46,104,111,115,116,110,97,109,101,58,100,111,99,117,109,101,110,116,46,100,111,109,97,105,110,124,124,108,111,99,97,116,105,111,110,46,104,111,115,116,110,97,109,101,125));
         }
         catch(error:Error)
         {
         }
         if(!_loc1_)
         {
            _loc3_ = uts(112,97,103,101,68,111,109,97,105,110);
            _loc2_ = gd(uts(102,108,97,115,104,46,115,121,115,116,101,109,46,83,101,99,117,114,105,116,121));
            if(_loc3_ in _loc2_)
            {
               _loc1_ = get_domain_of(_loc2_[_loc3_]);
            }
            if(!_loc1_)
            {
               _loc1_ = get_domain_of(new (gd(uts(102,108,97,115,104,46,100,105,115,112,108,97,121,46,76,111,97,100,101,114)))()[uts(99,111,110,116,101,110,116,76,111,97,100,101,114,73,110,102,111)][uts(108,111,97,100,101,114,85,82,76)]);
            }
         }
         return _loc1_;
      }
      
      private static function uts(... rest) : String
      {
         return "".constructor.fromCharCode.apply(null,rest);
      }
      
      private static function get_domain_of(param1:String) : String
      {
         if(!param1)
         {
            return null;
         }
         var _loc2_:String = uri_get_protocol(param1);
         if(_loc2_ == uts(102,105,108,101,58))
         {
            return uts(108,111,99,97,108,104,111,115,116);
         }
         return uri_get_hostname(param1);
      }
      
      private static function uri_get_protocol(param1:String) : String
      {
         var _loc2_:Array = /^([a-zA-Z0-9]+\:)?(\/+)(([a-zA-Z0-9\-\_]+\.)*[a-zA-Z0-9\-\_]+)(\:\d+)?(\/+(.+)?)?/g.exec(param1);
         return _loc2_ && _loc2_[1] ? _loc2_[1] : "";
      }
      
      private static function uri_get_hostname(param1:String) : String
      {
         var _loc2_:Array = /^([a-zA-Z0-9]+\:)?(\/+)(([a-zA-Z0-9\-\_]+\.)*[a-zA-Z0-9\-\_]+)(\:\d+)?(\/+(.+)?)?/g.exec(param1);
         return _loc2_ && _loc2_[3] ? _loc2_[3] : "";
      }
      
      private static function gd(param1:String) : *
      {
         return getDefinitionByName(param1);
      }
      
      public function get §̈§() : Object
      {
         return §̆§;
      }
      
      public function get minVersion() : String
      {
         return §̆§[uts(109,105,110,86,101,114,115,105,111,110)];
      }
      
      public function get recVersion() : String
      {
         return §̆§[uts(114,101,99,86,101,114,115,105,111,110)];
      }
      
      public function get id() : String
      {
         return §̆§[uts(105,100)];
      }
      
      public function get easy() : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:String = null;
         var _loc1_:Array = §̆§[uts(101,97,115,121,115)] as Array;
         if(_loc1_)
         {
            _loc3_ = 0;
            while(_loc3_ < _loc1_.length)
            {
               _loc2_ = _loc1_[_loc3_] is Array ? uts.apply(null,_loc1_[_loc3_]) : _loc1_[_loc3_];
               if(§̇§.§ͅ§(_loc2_))
               {
                  return true;
               }
               _loc3_++;
            }
         }
         return false;
      }
      
      public function get waitTop() : Boolean
      {
         return §̆§[uts(119,97,105,116,84,111,112)];
      }
      
      public function get params() : Object
      {
         return §̆§[uts(112,97,114,97,109,115)];
      }
      
      public function get recParams() : Object
      {
         return §̆§[uts(114,101,99,80,97,114,97,109,115)];
      }
      
      public function get loading() : *
      {
         return §̆§[uts(108,111,97,100,105,110,103)];
      }
      
      public function get forceSH() : Boolean
      {
         return §̆§[uts(102,111,114,99,101,83,72)];
      }
      
      public function get forceSHCheck() : Boolean
      {
         return §̆§[uts(102,111,114,99,101,83,72,67,104,101,99,107)];
      }
      
      public function get publishDate() : Date
      {
         var _loc1_:Date = null;
         var _loc2_:* = §̆§[uts(112,117,98,108,105,115,104,68,97,116,101)];
         if(_loc2_ is Number)
         {
            return new Date(_loc2_);
         }
         if(_loc2_ is String)
         {
            _loc1_ = new Date(_loc2_.replace(/-/g,"/"));
            if(isNaN(_loc1_.getTime()))
            {
               _loc1_.setTime(0);
            }
            return _loc1_;
         }
         return new Date(0);
      }
      
      public function get latency() : Number
      {
         var _loc12_:String = null;
         var _loc6_:Number = NaN;
         var _loc5_:Array = null;
         var _loc9_:int = 0;
         var _loc7_:Array = null;
         var _loc11_:int = 0;
         var _loc10_:String = null;
         var _loc4_:Array = null;
         var _loc1_:Number = NaN;
         var _loc2_:String = null;
         var _loc3_:* = §̈§[uts(108,97,116,101,110,99,121)];
         var _loc8_:Number = 0;
         if(_loc3_ is Number)
         {
            _loc8_ = _loc3_;
         }
         else if(_loc3_ is String)
         {
            _loc12_ = _loc3_;
            _loc12_ = _loc12_.replace(/\s+/g,"");
            if(/^\d+$/.test(_loc12_))
            {
               _loc8_ = parseFloat(_loc12_);
            }
            else if(/^(\d+\:){0,2}\d+(\.\d+)?$/.test(_loc12_))
            {
               _loc6_ = 0;
               _loc5_ = _loc12_.split(":");
               _loc9_ = 0;
               while(_loc9_ < _loc4_.length)
               {
                  _loc6_ += parseInt(_loc4_[_loc4_.length - 1 - _loc9_]) * Math.pow(60,_loc9_);
                  _loc9_++;
               }
               _loc8_ = _loc6_ * 1000;
            }
            else if(/^(\d+[a-z]+)+$/.test(_loc12_))
            {
               _loc7_ = _loc12_.match(/\d+[a-z]+/g);
               _loc11_ = 0;
               for(; _loc11_ < _loc7_.length; _loc11_++)
               {
                  _loc10_ = _loc7_[_loc11_];
                  _loc4_ = _loc10_.match(/\d+|[a-z]+/g);
                  _loc1_ = parseFloat(_loc4_[0]);
                  _loc2_ = _loc4_[1];
                  if(_loc1_ <= 0)
                  {
                     continue;
                  }
                  switch(_loc2_)
                  {
                     case "year":
                     case "years":
                        _loc8_ += _loc1_ * 365 * 24 * 3600 * 1000;
                        break;
                     case "month":
                     case "months":
                        _loc8_ += _loc1_ * 30 * 24 * 3600 * 1000;
                        break;
                     case "day":
                     case "days":
                        _loc8_ += _loc1_ * 24 * 3600 * 1000;
                        break;
                     case "hour":
                     case "hours":
                        _loc8_ += _loc1_ * 3600 * 1000;
                        break;
                     case "minute":
                     case "minutes":
                        _loc8_ += _loc1_ * 60 * 1000;
                        break;
                     case "second":
                     case "seconds":
                        _loc8_ += _loc1_ * 1000;
                        break;
                     case "ms":
                        _loc8_ += _loc1_;
                  }
               }
            }
         }
         return _loc8_;
      }
   }
}

