generic
   type T is private;
   Max_Size : Positive;
package Circular_Buffers is

   pragma Assertion_Policy (Check);

   type Circular_Buffer is private;

   function Read (CB : Circular_Buffer) return T;

   procedure Write (CB : in out Circular_Buffer; Item : T);

   procedure Next_Read (CB : in out Circular_Buffer)
     with Pre => not Reader_Matches_Writer (CB);

   procedure Next_Write (CB : in out Circular_Buffer);

   function Reader_Matches_Writer (CB : Circular_Buffer) return Boolean;

private

   type Buffer_Array is array (Positive range <>) of T;

   Min_Size : constant := 1;

   type Circular_Buffer is record
      Buffer              : Buffer_Array (Min_Size .. Max_Size);
      Read_Idx, Write_Idx : Positive := Min_Size;
   end record;

end Circular_Buffers;
