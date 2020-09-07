package body Circular_Buffers is

   type Idx_Type is (Read, Write);

   procedure Increment_Idx (CB : in out Circular_Buffer; I : Idx_Type) is
   begin
      case I is
         when Read =>
               CB.Read_Idx := CB.Read_Idx + 1;
         when Write =>
               CB.Write_Idx := CB.Write_Idx + 1;
      end case;
   end Increment_Idx;

   function Wrap_Around(CB : Circular_Buffer; Idx : Positive) return Positive is
      Remainder : constant Natural := Idx rem CB.Buffer'Last;
   begin
      if Remainder = 0 then
         return Positive (CB.Buffer'Last);
      else
         return Positive (Remainder);
      end if;
   end Wrap_Around;

   ----------
   -- Read --
   ----------

   function Read (CB : Circular_Buffer) return T is
   begin
      return CB.Buffer (Wrap_Around(CB, CB.Read_Idx));
   end Read;

   -----------
   -- Write --
   -----------

   procedure Write (CB : in out Circular_Buffer; Item : T) is
   begin
      CB.Buffer (Wrap_Around(CB, CB.Write_Idx)) := Item;
   end Write;

   procedure Next_Read (CB : in out Circular_Buffer) is
   begin
      Increment_Idx (CB, Read);
   end Next_Read;

   procedure Next_Write (CB : in out Circular_Buffer) is
   begin
      Increment_Idx (CB, Write);
   end Next_Write;

   function Reader_Matches_Writer (CB : Circular_Buffer) return Boolean is
   begin
      return CB.Read_Idx = CB.Write_Idx;
   end Reader_Matches_Writer;

end Circular_Buffers;
