package com.sh
{
   import flash.events.Event;
   
   public class Ȉ extends Event
   {
      
      public static const RENDER_TIME:String = "render_time";
      
      private var d:Date;
      
      private var §̻§:Boolean;
      
      public function Ȉ(param1:String, param2:Boolean = false, param3:Boolean = false, param4:String = null)
      {
         var _loc7_:Array = null;
         var _loc6_:String = null;
         var _loc5_:String = null;
         super(param1,param2,param3);
         d = new Date();
         if(param4)
         {
            try
            {
               §̻§ = true;
               _loc7_ = param4.split(" ");
               _loc6_ = _loc7_[0];
               _loc5_ = _loc7_[1];
               _loc7_ = _loc6_.split("-");
               d.fullYear = parseFloat(_loc7_[0]);
               d.month = parseFloat(_loc7_[1]) - 1;
               d.date = parseFloat(_loc7_[2]);
               _loc7_ = _loc5_.split(":");
               d.hours = parseFloat(_loc7_[0]);
               d.minutes = parseFloat(_loc7_[1]);
               d.seconds = parseFloat(_loc7_[2]);
            }
            catch(e:Error)
            {
            }
         }
      }
      
      public function get §̼§() : Boolean
      {
         return §̻§;
      }
      
      public function get §̽§() : Boolean
      {
         return !§̻§;
      }
      
      public function get date() : Date
      {
         return d;
      }
   }
}

