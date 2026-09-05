package Ȑ
{
   import flash.events.Event;
   
   public class ȏ extends Event
   {
      
      public static const START:String = "load_start";
      
      public static const OPEN:String = "load_open";
      
      public static const PROGRESS:String = "load_progress";
      
      public static const COMPLETE:String = "load_complete";
      
      public static const FAIL:String = "load_fail";
      
      public static const IO_ERROR:String = "load_io_error";
      
      public static const SECURITY_ERROR:String = "load_security_error";
      
      public static const §͖§:String = "load_deal_error";
      
      public function ȏ(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      override public function clone() : Event
      {
         return new ȏ(type,bubbles,cancelable);
      }
      
      public function get §͑§() : Boolean
      {
         return type == "load_deal_error";
      }
      
      public function get §͒§() : Boolean
      {
         return type == "load_io_error";
      }
      
      public function get §͓§() : Boolean
      {
         return type == "load_security_error";
      }
      
      public function get §͔§() : Boolean
      {
         return §͒§ || §͓§;
      }
      
      public function get §͐§() : Boolean
      {
         return type == "load_fail";
      }
      
      public function get §͕§() : Boolean
      {
         return type == "load_complete";
      }
      
      public function get §͉§() : Boolean
      {
         return type == "load_progress";
      }
   }
}

