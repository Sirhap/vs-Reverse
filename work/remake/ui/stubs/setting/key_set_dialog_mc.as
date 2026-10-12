package
{
   import flash.display.MovieClip;

   /**
    * Empty remake stub for UI SymbolClass export.
    * UI=setting DefineBinaryData id=2211 charId=44 export=key_set_dialog_mc
    * Purpose: give JPEXS/ASC a named MovieClip subclass so engine scripts can type
    * `:key_set_dialog_mc` (or keep `:*`). Does NOT embed artwork — nest SWF SymbolClass still owns pixels.
    * Cross-pool: if engine pool != home SWF, resolve via loading (see CROSS-POOL.md).
    */
   public class key_set_dialog_mc extends MovieClip
   {
      public function key_set_dialog_mc()
      {
         super();
      }
   }
}
