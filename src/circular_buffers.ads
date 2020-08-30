generic
   type T is private;
   Max_Size : Positive;
package Circular_Buffers is

   type Circular_Buffer is private;

   function Read (C : Circular_Buffer) return T;

   procedure Write (C : in out Circular_Buffer; Item : T);

   procedure Next_Read (C : in out Circular_Buffer);

   procedure Next_Write (C : in out Circular_Buffer);

private

   type Buffer_Array is array (Positive range <>) of T;

   Min_Size : constant := 1;

   type Circular_Buffer is record
      Buffer              : Buffer_Array (Min_Size .. Max_Size);
      Read_Idx, Write_Idx : Positive := Min_Size;
   end record;

end Circular_Buffers;
