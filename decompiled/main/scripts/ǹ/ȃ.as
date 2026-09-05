package ǹ
{
   import flash.events.Event;
   
   public class ȃ extends Event
   {
      
      public static const §̧§:String = "appInit";
      
      public static const §̨§:String = "appAdded";
      
      public function ȃ(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      override public function clone() : Event
      {
         return new ȃ(type,bubbles,cancelable);
      }
   }
}

