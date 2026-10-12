package
{
   import flash.display.MovieClip;

   /**
    * Empty remake stub for UI SymbolClass export.
    * UI=fight DefineBinaryData id=226 charId=195 export=ui_fight
    * Purpose: give JPEXS/ASC a named MovieClip subclass so engine scripts can type
    * `:ui_fight` (or keep `:*`). Does NOT embed artwork — nest SWF SymbolClass still owns pixels.
    * Cross-pool: if engine pool != home SWF, resolve via loading (see CROSS-POOL.md).
    */
   public class ui_fight extends MovieClip
   {
      public function ui_fight()
      {
         super();
      }
   }
}
