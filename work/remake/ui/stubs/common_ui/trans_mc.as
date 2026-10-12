package
{
   import flash.display.MovieClip;

   /**
    * Empty remake stub for UI SymbolClass export.
    * UI=common_ui DefineBinaryData id=225 charId=5 export=trans_mc
    * Purpose: give JPEXS/ASC a named MovieClip subclass so engine scripts can type
    * `:trans_mc` (or keep `:*`). Does NOT embed artwork — nest SWF SymbolClass still owns pixels.
    * Cross-pool: if engine pool != home SWF, resolve via loading (see CROSS-POOL.md).
    */
   public class trans_mc extends MovieClip
   {
      public function trans_mc()
      {
         super();
      }
   }
}
