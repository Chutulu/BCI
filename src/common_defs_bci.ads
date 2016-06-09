with Ada.Strings.Bounded;
with Ada.Strings.Fixed;
with Ada.Strings.Unbounded;

package Common_Defs_BCI is

   pragma Assertion_Policy (Check);

--     V_String_Length  : constant :=  64;
--
--     package V_String is new
--       Ada.Strings.Bounded.Generic_Bounded_Length (V_String_Length);
--
--     function "+" (Right : V_String.Bounded_String) return String
--                   renames V_String.To_String;
--
--     function "+" (Right : String) return V_String.Bounded_String
--     is (V_String.To_Bounded_String (Right))
--     with Pre => Right'Length <= V_String_Length;
--
--     function Trim (Right : String) return V_String.Bounded_String is
--       (V_String.To_Bounded_String (Ada.Strings.Fixed.Trim (Right, Ada.Strings.Both)))
--     with Pre => Right'Length <= V_String_Length;

   package U_B renames Ada.Strings.Unbounded;
   subtype Ub_S is U_B.Unbounded_String;

   function "+" (Right : U_B.Unbounded_String) return String
                 renames U_B.To_String;

   function "+" (Right : String) return U_B.Unbounded_String
   is (U_B.To_Unbounded_String (Right));

end Common_Defs_BCI;
