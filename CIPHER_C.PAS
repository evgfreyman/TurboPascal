Program Cipher_C;
uses CRT,DOS;
var F_Original,F_New:Text;
    Code,ASCII,Coder:integer;
    S,S_Original,S_New,FileName_Original,FileName_New:string;
    Key:char;

Procedure Cipher;
Begin
  While not EOF(F_Original)do
  BEGIN
    S_New:='';
    ReadLn(F_Original,S_Original);
    Repeat
        Str(Ord(S_Original[1])+Coder,S);
        S_New:=S_New+S;
      Delete(S_Original,1,1);
    Until S_Original='';
  TextColor(13);
  Write('.');
  WriteLn(F_New,S_New);
  END;
End;

Procedure Decipher;
Begin
  While not EOF(F_Original)do
  BEGIN
    S_New:='';
    ReadLn(F_Original,S_Original);
    Repeat
      val(Copy(S_Original,1,3),ASCII,Code);
      S_New:=S_New+Chr(ASCII-Coder);
      Delete(S_Original,1,3);
    Until S_Original='';
  TextColor(13);
  Write('.');
  WriteLn(F_New,S_New);
  END;
End;

Procedure OpenFiles;
var FileName:PathStr;
    Dir:DirStr;
    Name:NameStr;
    Ext:ExtStr;
begin
  Assign(F_Original,FileName_Original);
  Assign(F_New,FileName_New);
  {$I-}
  Reset(F_Original);
  {$I+}
  if IOResult<>0 then begin
    TextColor(12);
    Writeln('�� ������ 䠩� - ',FileName_Original);
    Readln;
    Halt;
  end;
  FSplit(FileName_New,Dir,Name,Ext);
  FileName:=Name+'.'+Ext;
  if FSearch(FileName,Dir)<>'' then
  begin
    Writeln;
    TextColor(12);
    Writeln('���� ',FileName_New,' ������� !');
    Writeln('�� ����� �� ������ ��� ���ଠ�� ����� �뫠 � ��� !');
    TextColor(14);
    Writeln('�த������ ? [Y/N]');
    Key:=ReadKey;
    if(Key='N')or(Key='n')then Halt;
  end;
  Rewrite(F_New)
end;

Begin
TextBackGround(0);
ClrScr;
Writeln;
TextColor(10);
Writeln('"Cipher_C" - ��஢騪 䠩���');
TextColor(15);
Writeln('"������� �� 䠩� !"');
Writeln;
TextColor(14);
Repeat
 Write('������ ��� ��室���� 䠩�� � ���� � ����: ');Readln(FileName_Original);
Until FileName_Original<>'';
Repeat
 Write('������ ��� ᮧ��������� 䠩�� � ���� � ����: ');Readln(FileName_New);
Until(FileName_New<>'')and(FileName_Original<>FileName_New);
  OpenFiles;
Repeat
 Write('������ ����業� ����஢���� (�� 100 �� 700): ');ReadLn(Coder);
Until(Coder>99)and(Coder<701);
Repeat
  Writeln;
  TextColor(13);
  Writeln('1 -  ����஢���');
  Writeln('2 - �����஢���');
  Writeln('����������������');
  Key:=ReadKey;
  if Key='1' then Cipher
    else if Key='2' then Decipher
      else begin
        TextColor(12);
        Writeln('������ ��ࠬ��� - ',Key);
        Key:=' ';
      end;
Until Key<>' ';
Close(F_Original);
Close(F_New);
Writeln;
TextColor(14);
Writeln('��⮢� !');
Writeln;
TextColor(10);
Writeln('��������� �� ���짮�����');
TextColor(10);
Writeln('27.06.2000     �३��� �������');
Writeln;
TextColor(7);
Writeln('������ ���� �������');
Writeln;
ReadKey;
End.