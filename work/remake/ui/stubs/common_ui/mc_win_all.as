package
{
   import flash.display.MovieClip;

   /**
    * Empty remake stub for UI SymbolClass export.
    * UI=common_ui DefineBinaryData id=225 charId=20 export=mc_win_all
    * Purpose: give JPEXS/ASC a named MovieClip subclass so engine scripts can type
    * `:mc_win_all` (or keep `:*`). Does NOT embed artwork — nest SWF SymbolClass still owns pixels.
    * Cross-pool: if engine pool != home SWF, resolve via loading (see CROSS-POOL.md).
    */
   public class mc_win_all extends MovieClip
   {
      public function mc_win_all()
      {
         super();
      }
   }
}
