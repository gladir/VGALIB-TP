{ @author: Sylvain Maltais (support@gladir.com)
  @created: 2023
  @website(https://www.gladir.com/CODER/VGALIB-TP)
  @abstract(Target: Turbo Pascal 7)
}

Unit VGA;

INTERFACE

Const
 VGA_IS_TANDY=$02;
 VGA_IS_HGC=$04;
 VGA_IS_MCGA=$08;
 VGA_IS_VGA=$10;
 VGA_IS_EGA=$20;
 VGA_IS_CGA=$40;
 VGA_IS_MDA=$80;
 VGA_IS_AMSTRAD=$100;
 VGA_IS_PCJR=$200;

  (* Index du contr“leur d'attribut, ou avec index pour r‚activer la palette *)
 VGA_AC_ENABLE=$20;

  (* Registres de contr“leur graphiques *)
 VGA_GC_DATA_ROTATE_OP_NONE=(0 shl 3);
 VGA_GC_DATA_ROTATE_OP_AND=(1 shl 3);
 VGA_GC_DATA_ROTATE_OP_OR=(2 shl 3);
 VGA_GC_DATA_ROTATE_OP_XOR=(3 shl 3);

  (* Variables de manipulation de police de caractŠres *)
 VGA_EGA_BYTES_PER_CHAR_BITMAP=32;
 VGA_EGA_BYTES_PER_CHAR_BITMAP_SHIFT=5;

  (* Cartographie des bits de m‚moire EGA et VGA *)
 VGA_MEMMAP_A0000_128K=$00;
 VGA_MEMMAP_A0000_64K=$01;
 VGA_MEMMAP_B0000_32K=$02;
 VGA_MEMMAP_B8000_32K=$03;

  (* Octet de mode CGA *)
 VGA_CGA_MODE_40WIDE=$00;
 VGA_CGA_MODE_80WIDE=$01;
 VGA_CGA_MODE_GRAPHICS=$02;
 VGA_CGA_MODE_BW=$04;
 VGA_CGA_MODE_VIDEO_ENABLE=$08;
 VGA_CGA_MODE_VIDEO_640=$10;
 VGA_CGA_MODE_NO_BLINKING=$20;

  (* Registres CRTC du VGA *)
 VGA_CRTC_HORIZONTAL_TOTAL=$00;
 VGA_CRTC_HORIZONTAL_DISPLAY_END=$01;
 VGA_CRTC_HORIZONTAL_BLANK_START=$02;
 VGA_CRTC_HORIZONTAL_BLANK_END=$03;
 VGA_CRTC_HORIZONTAL_RETRACE_START=$04;
 VGA_CRTC_HORIZONTAL_RETRACE_END=$05;
 VGA_CRTC_VERTICAL_TOTAL=$06;
 VGA_CRTC_OVERFLOW_REGISTER=$07;
 VGA_CRTC_PRESET_ROW_SCAN=$08;
 VGA_CRTC_MAXIMUM_SCAN_LINE=$09;
 VGA_CRTC_CURSOR_START=$0A;
 VGA_CRTC_CURSOR_END=$0B;
 VGA_CRTC_START_ADDRESS_HIGH=$0C;
 VGA_CRTC_START_ADDRESS_LOW=$0D;
 VGA_CRTC_CURSOR_LOCATION_HIGH=$0E;
 VGA_CRTC_CURSOR_LOCATION_LOW=$0F;
 VGA_CRTC_VERTICAL_RETRACE_START=$10;
 VGA_CRTC_VERTICAL_RETRACE_END=$11;
 VGA_CRTC_VERTICAL_DISPLAY_END=$12;
 VGA_CRTC_OFFSET=$13;
 VGA_CRTC_UNDERLINE_LOCATION=$14;
 VGA_CRTC_VERTICAL_BLANK_START=$15;
 VGA_CRTC_VERTICAL_BLANK_END=$16;
 VGA_CRTC_MODE_CONTROL=$17;
 VGA_CRTC_LINE_COMPARE=$18;

  (* Registres de contr“leur d'attribut *)
 VGA_AC_PALETTE_0=$00;
 VGA_AC_PALETTE_1=$01;
 VGA_AC_PALETTE_2=$02;
 VGA_AC_PALETTE_3=$03;
 VGA_AC_PALETTE_4=$04;
 VGA_AC_PALETTE_5=$05;
 VGA_AC_PALETTE_6=$06;
 VGA_AC_PALETTE_7=$07;
 VGA_AC_PALETTE_8=$08;
 VGA_AC_PALETTE_9=$09;
 VGA_AC_PALETTE_A=$0A;
 VGA_AC_PALETTE_B=$0B;
 VGA_AC_PALETTE_C=$0C;
 VGA_AC_PALETTE_D=$0D;
 VGA_AC_PALETTE_E=$0E;
 VGA_AC_PALETTE_F=$0F;
 VGA_AC_MODE_CONTROL=$10;
 VGA_AC_OVERSCAN_COLOR=$11;
 VGA_AC_COLOR_PLANE_ENABLE=$12;
 VGA_AC_HORIZONTAL_PIXEL_PANNING=$13;
 VGA_AC_COLOR_SELECT=$14;

  (* Registres de s‚quenceur *)
 VGA_SC_RESET=$00;
 VGA_SC_CLOCK_MODE=$01;
 VGA_SC_MAP_MASK=$02;
 VGA_SC_CHARMAP_SELECT=$03;
 VGA_SC_MEM_MODE=$04;

  (* graphics controller registers *)
 VGA_GC_SET_RESET=$00;
 VGA_GC_ENABLE_SET_RESET=$01;
 VGA_GC_COLOR_COMPARE=$02;
 VGA_GC_DATA_ROTATE=$03;
 VGA_GC_READ_MAP_SELECT=$04;
 VGA_GC_MODE=$05;
 VGA_GC_MISC_GRAPHICS=$06;
 VGA_GC_COLOR_DONT_CARE=$07;
 VGA_GC_BIT_MASK=$08;

  (* S‚lection de palette CGA (320x200x4) *)
 VGA_CGA_PALETTE_GR_BR_RD=0;
 VGA_CGA_PALETTE_CY_MA_WH=1;

  (* S‚lecteur de couleur
     (texte=couleur de bord
      320x200=arriŠre plan
      640x200=premier plan *)
 VGA_CGA_PALETTE_CS_BLUE=(1 shl 0);
 VGA_CGA_PALETTE_CS_GREEN=(1 shl 1);
 VGA_CGA_PALETTE_CS_RED=(1 shl 2);
 VGA_CGA_PALETTE_CS_INTENSITY=(1 shl 3);
 VGA_CGA_PALETTE_CS_ALT_INTENSITY=(1 shl 4);

 VGA_WRITE_CRTC_MODE_NO_CLEAR_SYNC=$0001;

Type
 TByte=Array[0..767]of Byte;

Var
 Vga_Clock_Rates:Array[0..3]of LongInt;

Function  Int10_GetMode:Byte;
Procedure Int10_SetMode(X:Byte);
Function  VGA_AC_PALETTE(x:Word):Word;
Procedure VGA_AC_Reenable_Screen;
Function  VGA_AC_RGB_To_Code(R,G,B:Byte):Byte;
Procedure VGA_BIOS_Set_80x50_Text;
Procedure VGA_Enable_256color_ModeX;
Function  VGA_Get_Start_Location:Word;
Function  VGA_In_VSync:Byte;
Procedure VGA_Palette_LSeek(I:Word);
Procedure VGA_Palette_Write(R,G,B:Byte);
Function  VGA_Read_CRTC(I:Byte):Byte;
Function  VGA_Read_GC(I:Byte):Byte;
Function  VGA_Read_Sequencer(I:Byte):Byte;
Procedure VGA_Relocate_CRTC(Color:Byte);
Procedure VGA_Set_Stride(Stride:Word);
Procedure VGA_Set_XPan(C:Byte);
Procedure VGA_Set_YPan_Sub(C:Byte);
Procedure VGA_Tandy_SetPalette(I,C:Byte);
Function  VGA_Read_AC(I:Byte):Byte;
Procedure VGA_Read_PAL(I:Byte;Var P:TByte;Count:Word);
Procedure VGA_Restore_RM0WM0;
Procedure VGA_Select_CharSet_A_B(A,B:Word);
Procedure VGA_Setup_WM1_Block_Copy;
Procedure VGA_Set_CGA_Mode(B:Byte);
Procedure VGA_Set_CGA_Palette_And_Background(Pal,Color:Byte);
Procedure VGA_Set_Start_Location(Offset:Word);
Procedure VGA_SplitScreen(V:Word);
Procedure VGA_Switch_To_Color;
Procedure VGA_Turn_Off_HGC;
Procedure VGA_Turn_On_HGC;
Procedure VGA_Wait_For_HSync;
Procedure VGA_Wait_For_HSync_End;
Procedure VGA_Wait_For_VSync;
Procedure VGA_Wait_For_VSync_End;
Procedure VGA_Write_AC(I,C:Byte);
Procedure VGA_Write_Color(C:Byte);
Procedure VGA_Write_PAL(I:Byte;Var P:TByte;Count:Word);
Procedure VGA_Write_CRTC(I,C:Byte);
Procedure VGA_Write_GC(I,C:Byte);
Procedure VGA_Write_Sequencer(I,C:Byte);

IMPLEMENTATION

Uses DOS;

Const
 HGC_Graphics_Crtc:Array[0..11]of Byte=(
   $35,$2D,$2E,$07,
   $5B,$02,$57,$57,
   $02,$03,$00,$00
 );

 HGC_Text_Crtc:Array[0..11]of Byte=(
   $61,$50,$52,$0F,
   $19,$06,$19,$19,
   $02,$0D,$0D,$0C
 );


Var
 Vga_State:Record
  VGA_Pos_X,Vga_Pos_Y:Byte;
  VGA_HGC_Type:Byte;
  VGA_Stride:Byte;
  VGA_Width,VGA_Height:Word;
  VGA_Base_3x0:Word;
  VGA_Flags:Word;
  VGA_RAM_Base:LongInt;
  VGA_RAM_Size:LongInt;
  VGA_Graphics_RAM:Pointer;
  VGA_Graphics_RAM_Fence:Pointer;
  VGA_Alpha_RAM:Pointer;
  VGA_Alpha_RAM_Fence:Pointer;
  VGA_Color:Byte;
  VGA_Draw_Stride:Byte;
  VGA_Draw_Stride_Limit:Byte;
  VGA_Alpha_Mode:Byte;
  VGA_9Wide:Byte;
 End;

Function Int10_GetMode:Byte;
Var
 Regs:Registers;
Begin
 {$IFDEF FPC}
  Int10_GetMode:=3;
 {$ELSE}
  Regs.AH:=$0F;
  Intr($10,Regs);
  Int10_GetMode:=Regs.AL;
 {$ENDIF}
End;

Procedure Int10_SetMode(X:Byte);
Var
 Regs:Registers;
Begin
 Regs.AH:=$00;
 Regs.AL:=X;
 Intr($10,Regs);
End;

Function Get_PCJR_Mem:Pointer;
Var
 S:Word;
 B:Byte;
Begin
 If((VGA_State.VGA_Flags and (VGA_IS_PCJR))<>0)Then Begin
  (* PC Junior : doit localiser la zone de m‚moire systŠme car
     l'alias de la m‚moire vid‚o est limit‚ … 16 Ko *)
  B:=Mem[$0040:$008A];
  S:=((B shr 3) and 7) shl 10;
  If(S = 0)Then S:=$B800;
 End
  Else
 Begin
  S:=$B800;
 End;
 Get_PCJR_Mem:=Ptr(S,0);
End;


Procedure VGA_MoveTo(X,Y:Byte);Begin
 VGA_State.VGA_Pos_X:=X;
 VGA_state.VGA_Pos_Y:=Y;
End;

Function VGA_AC_PALETTE(x:Word):Word;Begin
 VGA_AC_PALETTE:=((x)and $0F);
End;

Function VGA_Read_CRTC(I:Byte):Byte;Begin
 Port[VGA_State.VGA_Base_3x0+4]:=I;
 VGA_Read_CRTC:=Port[VGA_State.VGA_Base_3x0+5];
End;

Function VGA_Read_GC(I:Byte):Byte;Begin
 Port[$3CE]:=I;
 VGA_Read_GC:=Port[$3CF];
End;

Procedure VGA_Tandy_SetPalette(I,C:Byte);
Var
 X:Byte;
Begin
 X:=Port[$3DA];
 If(Vga_State.Vga_Flags and VGA_IS_PCJR<>0)Then Begin
  Port[$3DA]:=$10+I;
  Port[$3DA]:=C;
   (* L'‚mulation DOSBox machine=pcjr semble impliquer que
     l'‚criture des registres de palette vide l'affichage. Effectuez
     une ‚criture factice pour effacer l'‚cran. *)
  Port[$3DA]:=$00;
 End
  Else
 Begin
  Port[$3DA]:=$10+I;
  Port[$3DE]:=C; (* Cela fonctionne correctement sur Tandy (au moins DOSBox) *)
 End;
End;

Function VGA_Read_Sequencer(I:Byte):Byte;Begin
 Port[$3C4]:=I;
 VGA_Read_Sequencer:=Port[$3C5];
End;

Procedure VGA_Write_Sequencer(I,C:Byte);Begin
 Port[$3C4]:=I;
 Port[$3C5]:=C;
End;

Procedure VGA_Write_GC(I,C:Byte);Begin
 Port[$3CE]:=I;
 Port[$3CF]:=C;
End;

Procedure VGA_Write_CRTC(I,C:Byte);Begin
 Port[VGA_State.VGA_Base_3x0+4]:=I;
 Port[VGA_State.VGA_Base_3x0+5]:=C;
End;

Procedure VGA_Set_YPan_Sub(C:Byte);Begin
 VGA_Write_CRTC($08,C);
End;

Procedure VGA_Write_Color(C:Byte);Begin
 VGA_State.VGA_Color:=C;
End;

Procedure VGA_Read_PAL(I:Byte;Var P:TByte;Count:Word);
Var
 J:Word;
Begin
 Count:=Count*3;
 Port[$3C7]:=I;
 J:=0;
 While(Count>0)do Begin
  Dec(Count);
  P[J]:=Port[$3C9];
  Inc(J);
 End;
End;

Procedure VGA_Write_PAL(I:Byte;Var P:TByte;Count:Word);
Var
 J:Word;
Begin
 Count:=Count*3;
 Port[$3C8]:=I;
 J:=0;
 While(Count>0)do Begin
  Dec(Count);
  Port[$3C9]:=P[J];
  Inc(J);
 End;
End;

Procedure VGA_Set_CGA_Palette_And_Background(Pal,Color:Byte);Begin
 Port[$3D9]:=(pal shl 5) or Color;
End;

Procedure VGA_Set_CGA_Mode(B:Byte);Begin
 Port[$3D8]:=B;
End;

Procedure VGA_Write_AC(I,C:Byte);
Var
 X:Byte;
Begin
 X:=Port[VGA_State.VGA_Base_3x0+$0A];
 Port[$3C0]:=I;
 Port[$3C0]:=C;
 X:=Port[vga_state.vga_base_3x0+$0A];
End;

Procedure VGA_Set_XPan(C:Byte);Begin
 VGA_Write_AC($13 or VGA_AC_ENABLE,C);
End;

Function VGA_Read_AC(I:Byte):Byte;
Var
 X,C:Byte;
Begin
 (* La lecture des registres de palette doit se faire de cette
    fa‡on car les anciennes carte S3 Virge DX lise mal les valeurs
    lorsque PAS=1 sinon. *)
 X:=Port[VGA_State.VGA_Base_3x0+$0A]; (* r‚initialiser le loquet *)
 Port[$3C0]:=I and (Not $20);	      (* index avec PAS=0 *)
 C:=Port[$3C1];
 X:=Port[VGA_State.VGA_Base_3x0+$0A]; (* r‚initialiser le loquet *)
 Port[$3C0]:=I or $20;		      (* index avec PAS=1 *)
 X:=Port[VGA_State.VGA_Base_3x0+$0A]; (* r‚initialiser le loquet *)
 VGA_Read_AC:=C;
End;

Procedure VGA_Set_Stride(Stride:Word);Begin
 Stride:=Stride shr (2+1);
 VGA_Write_CRTC($13,stride);
End;

Procedure VGA_AC_Reenable_Screen;
Var
 X:Byte;
Begin
 X:=Port[VGA_State.VGA_Base_3x0+$0A];
 Port[$3C0]:=$20;
 X:=Port[VGA_State.VGA_Base_3x0+$0A];
End;

Procedure VGA_Palette_LSeek(I:Word);Begin
 Port[$3C8]:=I;
End;

Procedure VGA_Palette_Write(R,G,B:Byte);Begin
 Port[$3C9]:=R;
 Port[$3C9]:=G;
 Port[$3C9]:=B;
End;

Function VGA_In_VSync:Byte;Begin
 VGA_In_VSync:=(Port[VGA_State.VGA_Base_3x0+$0A] and $08);
End;

Procedure VGA_Wait_For_HSync;Begin
 While((Port[VGA_State.VGA_Base_3x0+$0A] and $01)=0)do;
End;

Procedure VGA_Wait_For_HSync_End;Begin
 While((Port[VGA_State.VGA_Base_3x0+$0A] and $01)<>0)do;
End;

Procedure VGA_Wait_For_VSync;Begin
 While((Port[VGA_State.VGA_Base_3x0+$0A] and $08)=0)do;
End;

Procedure VGA_Wait_For_VSync_End;Begin
 While((Port[VGA_State.VGA_Base_3x0+$0A] and $08)<>0)do;
End;

Function VGA_AC_RGB_To_Code(R,G,B:Byte):Byte;Begin
 VGA_AC_RGB_To_Code:=(((B shr 1)and 1)shl 0)or(((G shr 1)and 1)shl 1)or(((R shr 1)and 1)shl 2)or
		     (((B shr 0)and 1)shl 3)or(((G shr 0)and 1)shl 4)or(((R shr 0)and 1)shl 5);
End;

Procedure VGA_Turn_On_HGC;
Var
 C:Byte;
Begin
 Port[$3B8]:=$00; (* D‚sactive la vid‚o *)
 Port[$3BF]:=$01; (* Active les ajustements mode graphique *)
 Port[$3B8]:=$02; (* Active les graphiques *)
 For C:=0 to 11 do Begin
  Port[$3B4]:=C;
  Port[$3B5]:=HGC_Graphics_Crtc[c];
 End;
 Port[$3B8]:=$0A; (* Active les graphiques + vid‚o *)
End;

Procedure VGA_Turn_Off_HGC;
Var
 C:Byte;
Begin
 Port[$3B8]:=$00; (* D‚sactive la vid‚o *)
 Port[$3BF]:=$00; (* D‚sactive les ajustements de mode graphiques *)
 For C:=0 to 11 do Begin
  Port[$3B4]:=C;
  Port[$3B5]:=HGC_Text_CrtC[C];
 End;
 Port[$3B8]:=$28; (* Active la vid‚o et le texte *)
End;

Procedure VGA_Enable_256color_ModeX;Begin
 VGA_Write_Sequencer(4,$06);
 VGA_Write_Sequencer(0,$01);
 VGA_Write_CRTC($17,$E3);
 VGA_Write_CRTC($14,$00);
 VGA_Write_Sequencer(0,$03);
 VGA_Write_Sequencer(VGA_SC_MAP_MASK,$0F);
End;

Procedure VGA_Relocate_CRTC(Color:Byte);
Const
 Moc:Byte=0;
Begin
 If Color<>0 Then Color:=1;
 If((VGA_State.Vga_Flags and VGA_IS_VGA)<>0)Then Begin
  Moc:=Port[$3CC];
  Moc:=Moc and $FE; (* Efface le bit 0, r‚ponse … 3Bh *)
  Port[$3C2]:=Moc or Color;
 End
  Else
 If(Vga_State.Vga_Flags and VGA_IS_EGA<>0)Then Begin
  If Color<>0 Then Begin
   Port[$3C2]:=$02 or 1;
  End
   Else
  Port[$3C2]:=$02 or 0;
 End;
 If(Color<>0)Then Vga_State.Vga_Base_3x0:=$3D0
             Else Vga_State.Vga_Base_3x0:=$3B0;
End;

Procedure VGA_SplitScreen(V:Word);
Var
 C:Byte;
Begin
 VGA_Write_CRTC($18,V);
 If((VGA_State.VGA_Flags and VGA_IS_VGA)<>0)Then Begin
  C:=VGA_Read_CRTC($07);
  VGA_Write_CRTC($07,(C and(Not $10)) or (((V shr 8) and 1) shl 4));
  C:=VGA_Read_CRTC($09);
  VGA_Write_CRTC($09,(C and (Not $40)) or (((V shr 9) and 1) shl 6));
 End
  Else
 Begin
  C:=$1F;
  VGA_Write_CRTC($07,(C and (Not $10)) or (((V shr 8) and 1) shl 4));
 End;
End;

Function VGA_Get_Start_Location:Word;
Var
 R:Word;
Begin
 R:=VGA_Read_CRTC($0D);
 R:=R+(VGA_Read_CRTC($0C) shl 8);
 VGA_Get_Start_Location:=R;
End;

Procedure VGA_Set_Start_Location(Offset:Word);Begin
 VGA_Write_CRTC($0C,Offset shr 8);
 VGA_Write_CRTC($0D,Offset);
End;

Procedure VGA_BIOS_Set_80x50_Text;
Var
 Regs:Registers;
Begin
 Regs.AX:=$1112;
 Regs.BX:=0;
 Intr($10,Regs);
 VGA_State.VGA_Height:=50;
End;

Procedure VGA_Setup_WM1_Block_Copy;Begin
 VGA_Write_GC(VGA_GC_MODE,$40 (*Mode 256 couleurs *) or 1 (* Mode ‚criture 1*));
 VGA_Write_Sequencer($02 (* Masque de cartographie*),$0F); (* Tous les plans activ‚s *)
End;

Procedure VGA_Restore_RM0WM0;Begin
 VGA_Write_GC(VGA_GC_MODE,$40 (* Mode 256 couleurs*)); (* Mode lecture 0, Mode ‚criture 0 *)
End;

Procedure VGA_Switch_To_Color;
Var
 Moc:Byte;
Begin
 Moc:=0;
 If((VGA_State.VGA_Flags and VGA_IS_VGA)<>0)Then Begin
  Moc:=Port[$3CC];
  Moc:=Moc or $01; (* Fixe le bit 0, r‚pond … 3Dxh *)
  Port[$3C2]:=Moc;
  Moc:=VGA_Read_GC(6);
  Moc:=Moc and $F3; (* Efface les bits 2 et 3 *)
  Moc:=Moc or $0C;  (* Bits 2 … 3 = 11 = B8000 *)
  VGA_Write_GC(6,Moc);
 End
  Else
 If((VGA_State.VGA_Flags and VGA_IS_EGA)<>0)Then Begin
  Moc:=$02 or 1; (* Pos VSYNC/HSYNC, bas de page paire/impaire, 25MHz horloge, RAM activ‚ *)
  Port[$3C2]:=Moc;
  VGA_Write_GC(6,$0C or $02); (* B8000 avec paire/impaire *)
 End
  Else
 Exit;
 Mem[$0040:$49]:=$03; (* mode 3 *)
 Mem[$0040:$63]:=$D4;
 Mem[$0040:$10]:=Mem[$0040:$10] and $30; (* Mode vid‚o initiale INT 11 *)
 Mem[$0040:$10]:=Mem[$0040:$10] or $20; (* -> change … 80x25 en couleur *)
 Mem[$0040:$65]:=Mem[$0040:$65] or $04; (* Op‚ration couleur *)
End;

Procedure VGA_Select_CharSet_A_B(A,B:Word);
Var
 C:Byte;
Begin
 C:=A shr 14;
 C:=C or((B shr 14) shl 2);
 C:=C or(((A shr 13) and 1) shl 4);
 C:=C or(((B shr 13) and 1) shl 5);
 VGA_Write_Sequencer(3,C);
End;

END.