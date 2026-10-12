package
{
   import flash.display.MovieClip;

   /**
    * Empty remake stub for UI SymbolClass export.
    * UI=fight DefineBinaryData id=226 charId=30 export=hits_mc
    * Purpose: give JPEXS/ASC a named MovieClip subclass so engine scripts can type
    * `:hits_mc` (or keep `:*`). Does NOT embed artwork — nest SWF SymbolClass still owns pixels.
    * Cross-pool: if engine pool != home SWF, resolve via loading (see CROSS-POOL.md).
    */
   public class hits_mc extends MovieClip
   {
      public function hits_mc()
      {
         super();
      }
   }
}
