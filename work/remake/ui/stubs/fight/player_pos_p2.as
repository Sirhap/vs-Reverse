package
{
   import flash.display.MovieClip;

   /**
    * Empty remake stub for UI SymbolClass export.
    * UI=fight DefineBinaryData id=226 charId=219 export=player_pos_p2
    * Purpose: give JPEXS/ASC a named MovieClip subclass so engine scripts can type
    * `:player_pos_p2` (or keep `:*`). Does NOT embed artwork — nest SWF SymbolClass still owns pixels.
    * Cross-pool: if engine pool != home SWF, resolve via loading (see CROSS-POOL.md).
    */
   public class player_pos_p2 extends MovieClip
   {
      public function player_pos_p2()
      {
         super();
      }
   }
}
