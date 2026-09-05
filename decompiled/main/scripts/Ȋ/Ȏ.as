package Ȋ
{
   use namespace Ǵ;
   
   public class Ȏ
   {
      
      public static const READY:int = 0;
      
      public static const START:int = 1;
      
      public static const OPEN:int = 2;
      
      public static const PROGRESS:int = 3;
      
      public static const WAITING:int = 4;
      
      public static const ERROR:int = 5;
      
      public static const DEALING:int = 6;
      
      public static const COMPLETE:int = 7;
      
      public static const FAIL:int = 8;
      
      private var §͈§:int;
      
      public function Ȏ(param1:int = 0)
      {
         super();
         §͈§ = param1;
      }
      
      public function get type() : int
      {
         return §͈§;
      }
      
      Ǵ function setType(param1:int) : void
      {
         §͈§ = param1;
      }
      
      public function get §͉§() : Boolean
      {
         return §͊§ || §͌§ || §͍§;
      }
      
      public function get §͊§() : Boolean
      {
         switch(type - 1)
         {
            case 0:
            case 1:
            case 2:
               return true;
            default:
               return false;
         }
      }
      
      public function get §͋§() : Boolean
      {
         switch(type - 2)
         {
            case 0:
            case 1:
               return true;
            default:
               return false;
         }
      }
      
      public function get §͌§() : Boolean
      {
         return type == 4;
      }
      
      public function get §͍§() : Boolean
      {
         return type == 6;
      }
      
      public function get §͎§() : Boolean
      {
         return §͏§ || §͐§;
      }
      
      public function get §͏§() : Boolean
      {
         return type == 7;
      }
      
      public function get isReady() : Boolean
      {
         return type == 0;
      }
      
      public function get §͐§() : Boolean
      {
         return type == 8;
      }
      
      public function toString() : String
      {
         switch(type)
         {
            case 0:
               return "ready";
            case 1:
               return "start";
            case 2:
               return "open";
            case 4:
               return "waiting";
            case 5:
               return "error";
            case 6:
               return "dealing";
            case 7:
               return "complete";
            case 8:
               return "fail";
            default:
               return "unknow";
         }
      }
   }
}

