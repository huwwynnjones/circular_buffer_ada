pragma Ada_2012;
package body Circular_Buffers is

   type Idx_Type is (Read, Write);

   procedure Increment_Idx (C : in out Circular_Buffer; I : Idx_Type) is
   begin
      case I is
         when Read =>
            if C.Read_Idx = C.Buffer'Last then
               C.Read_Idx := Min_Size;
            else
               C.Read_Idx := C.Read_Idx + 1;
            end if;
         when Write =>
            if C.Write_Idx = C.Buffer'Last then
               C.Write_Idx := Min_Size;
            else
               C.Write_Idx := C.Write_Idx + 1;
            end if;
      end case;
   end Increment_Idx;

   ----------
   -- Read --
   ----------

   function Read (C : Circular_Buffer) return T is
   begin
      return C.Buffer (C.Read_Idx);
   end Read;

   -----------
   -- Write --
   -----------

   procedure Write (C : in out Circular_Buffer; Item : T) is
   begin
      C.Buffer (C.Write_Idx) := Item;
   end Write;

   procedure Next_Read (C : in out Circular_Buffer) is
   begin
      Increment_Idx (C, Read);
   end Next_Read;

   procedure Next_Write (C : in out Circular_Buffer) is
   begin
      Increment_Idx (C, Write);
   end Next_Write;

end Circular_Buffers;
