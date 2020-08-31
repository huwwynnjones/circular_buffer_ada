package body Circular_Buffers is

   type Idx_Type is (Read, Write);

   procedure Increment_Idx (C : in out Circular_Buffer; I : Idx_Type) is
   begin
      case I is
         when Read =>
               C.Read_Idx := C.Read_Idx + 1;
         when Write =>
               C.Write_Idx := C.Write_Idx + 1;
      end case;
   end Increment_Idx;

   function Wrap_Around(C : Circular_Buffer; Idx : Positive) return Positive is
      Remainder : constant Natural := Idx rem C.Buffer'Last;
   begin
      if Remainder = 0 then
         return Positive (C.Buffer'Last);
      else
         return Positive (Remainder);
      end if;
   end Wrap_Around;

   ----------
   -- Read --
   ----------

   function Read (C : Circular_Buffer) return T is
   begin
      return C.Buffer (Wrap_Around(C, C.Read_Idx));
   end Read;

   -----------
   -- Write --
   -----------

   procedure Write (C : in out Circular_Buffer; Item : T) is
   begin
      C.Buffer (Wrap_Around(C, C.Write_Idx)) := Item;
   end Write;

   procedure Next_Read (C : in out Circular_Buffer) is
   begin
      Increment_Idx (C, Read);
   end Next_Read;

   procedure Next_Write (C : in out Circular_Buffer) is
   begin
      Increment_Idx (C, Write);
   end Next_Write;

   function Reader_Matches_Writer (C : Circular_Buffer) return Boolean is
   begin
      return C.Read_Idx = C.Write_Idx;
   end Reader_Matches_Writer;

end Circular_Buffers;
