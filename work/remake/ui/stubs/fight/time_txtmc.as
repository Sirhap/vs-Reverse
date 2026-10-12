package
{
   import flash.display.MovieClip;

   /**
    * Empty remake stub for UI SymbolClass export.
    * UI=fight DefineBinaryData id=226 charId=24 export=time_txtmc
    * Purpose: give JPEXS/ASC a named MovieClip subclass so engine scripts can type
    * `:time_txtmc` (or keep `:*`). Does NOT embed artwork — nest SWF SymbolClass still owns pixels.
    * Cross-pool: if engine pool != home SWF, resolve via loading (see CROSS-POOL.md).
    */
   public class time_txtmc extends MovieClip
   {
      public function time_txtmc()
      {
         super();
      }
   }
}
