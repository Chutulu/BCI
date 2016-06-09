package body BCI_Messages is

   ----------
   -- Make --
   ----------
   function Make (Dossier : Dossiers.Object) return Object is

      Item : Object;

   begin -- Make

      Item.Dossier := Dossier;

      return Item;

   end Make;

end BCI_Messages;
