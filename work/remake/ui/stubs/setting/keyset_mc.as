package
{
   import flash.display.MovieClip;

   /**
    * Empty remake stub for UI SymbolClass export.
    * UI=setting DefineBinaryData id=2211 charId=38 export=keyset_mc
    * Purpose: give JPEXS/ASC a named MovieClip subclass so engine scripts can type
    * `:keyset_mc` (or keep `:*`). Does NOT embed artwork — nest SWF SymbolClass still owns pixels.
    * Cross-pool: if engine pool != home SWF, resolve via loading (see CROSS-POOL.md).
    */
   public class keyset_mc extends MovieClip
   {
      public function keyset_mc()
      {
         super();
      }
   }
}
