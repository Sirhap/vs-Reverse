package Ȋ
{
   import com.green.net.ǽ;
   import Ȑ.ȏ;
   
   public class ȉ
   {
      
      private var start:Function;
      
      private var open:Function;
      
      private var progress:Function;
      
      private var complete:Function;
      
      private var error:Function;
      
      private var fail:Function;
      
      private var §̾§:ǽ;
      
      public function ȉ(param1:ǽ)
      {
         super();
         this.§̾§ = param1;
      }
      
      public function set onEvent(param1:Function) : void
      {
         start = open = progress = complete = error = fail = param1;
      }
      
      public function set onStart(param1:Function) : void
      {
         start = param1;
      }
      
      public function set onOpen(param1:Function) : void
      {
         open = param1;
      }
      
      public function set onProgress(param1:Function) : void
      {
         progress = param1;
      }
      
      public function set onComplete(param1:Function) : void
      {
         complete = param1;
      }
      
      public function set onError(param1:Function) : void
      {
         error = param1;
      }
      
      public function set onFail(param1:Function) : void
      {
         fail = param1;
      }
      
      public function get onStart() : Function
      {
         return start;
      }
      
      public function get onOpen() : Function
      {
         return open;
      }
      
      public function get onProgress() : Function
      {
         return progress;
      }
      
      public function get onComplete() : Function
      {
         return complete;
      }
      
      public function get onError() : Function
      {
         return error;
      }
      
      public function get onFail() : Function
      {
         return fail;
      }
      
      public function exec(param1:String) : void
      {
         switch(param1)
         {
            case "load_start":
               start && start(§̾§);
               break;
            case "load_open":
               open && open(§̾§);
               break;
            case "load_progress":
               progress && progress(§̾§);
               break;
            case "load_complete":
               complete && complete(§̾§);
               break;
            case "load_fail":
               fail && fail(§̾§);
               break;
            case "load_deal_error":
            case "load_security_error":
            case "load_io_error":
               error && error(§̾§);
         }
         if(§̾§.willTrigger(param1))
         {
            §̾§.dispatchEvent(new ȏ(param1));
         }
      }
   }
}

