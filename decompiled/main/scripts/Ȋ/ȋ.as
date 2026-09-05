package Ȋ
{
   public class ȋ
   {
      
      private var §̿§:uint;
      
      private var §̀§:uint;
      
      public function ȋ(param1:uint = 0, param2:uint = 0)
      {
         super();
         this.ɐ = param1;
         this.§́§ = param2;
      }
      
      public function get §́§() : uint
      {
         return §̿§;
      }
      
      public function set §́§(param1:uint) : void
      {
         §̿§ = param1 == 0 ? 4294967295 : param1;
      }
      
      public function §͂§(param1:uint) : void
      {
         §́§ = param1;
         ɐ = 0;
      }
      
      public function get ɐ() : uint
      {
         return §̀§;
      }
      
      public function set ɐ(param1:uint) : void
      {
         §̀§ = param1;
      }
      
      public function get §˹§() : Boolean
      {
         return ɐ >= §́§;
      }
      
      public function get progress() : Number
      {
         return ɐ / §́§;
      }
   }
}

