with Ada.Text_IO;
with Common_IO; use Common_IO;
with Dossiers; with Dossiers.IO;

package BCI_Messages is

   type Object is private;

   ----------
   -- Make --
   ----------
   function Make (Dossier : Dossiers.Object) return Object;
   -- Pre: Dossier is defined
   -- Post: Makes a Message in BCI format

private

   type Object is record

      Dossier : Dossiers.Object;

   end record;

end BCI_Messages;
