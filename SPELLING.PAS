Program Spelling;
uses CRT;
type TWord=string;
var FVar:File of TWord;
    Word_:tWord;

Procedure Opening_of_the_dictionary;
begin
  Assign(FVar,'SpBase.dic');
  {$I-}
  Reset(FVar);
  {$I+}
  if IOResult<>0 then begin
    Writeln('�� ������ 䠩� ᫮��� - SpBase.dic');
    Writeln('��� ࠡ��� �ணࠬ�� �㦭� ��������');
    Writeln('��� 䠩� � ⥪�騩 ��⠫��.');
    Readln;
    Halt;
  end;
end;

Function Mistake(Words:string):boolean;
var Letter,WordDic:string;
begin
  Seek(FVar,0);
  While WordDic<>Words do begin
    WordDic:='';
    Letter:='';
    Repeat
      if Letter='.'then begin Mistake:=True;Exit;end;
      WordDic:=WordDic+Letter;
      Read(FVar,Letter);
    Until Letter=',';
  end;
  Mistake:=False;
end;

Procedure Check_of_words;
Var Words:String;

begin
  WriteLn('�஢�ઠ ��䮣�䨨');
  Repeat
    Write('������ ���������� ᫮��: ');
    ReadLn(Words);
    if Mistake(Words) then WriteLn('����� ���ࠢ��쭮 ����ᠭ�')
                      else WriteLn('����� �ࠢ��쭮 ����ᠭ�');
    WriteLn;
  Until(Words='��室')or(Words='��室')or(Words='�����')
end;


begin
Writeln;
Opening_of_the_dictionary;
Check_of_words;
Close(FVar);
End.