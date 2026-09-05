package com.sh
{
   import flash.events.Event;
   
   public class ȇ extends Event
   {
      
      public static const LOGIN:String = "login";
      
      public static const LOGOUT:String = "logout";
      
      private var data:Object;
      
      public function ȇ(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         data = param2;
         super(param1,param3,param4);
      }
      
      public function get uid() : String
      {
         return data.uid;
      }
      
      public function get name() : String
      {
         return data.name;
      }
      
      public function get nickName() : String
      {
         return data.nickName;
      }
      
      private function get §̺§() : String
      {
         return name || nickName;
      }
   }
}

