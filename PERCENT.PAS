Program Percent;
uses CRT;
type TMasWord=array[1..50]of string[30];
var Find,All:word;
    CountKey,CountWord,i,j:byte;
    P:real;
    TextFN,WordFN:string[12];
    S:string;
    TextFV,WordFV:Text;
    MasWord,MasKey:TMasWord;

  procedure OpenFile(TextFN,WordFN:string);
  begin
    Assign(TextFV,TextFN);
    Assign(WordFV,WordFN);

    {$I-}
    Reset(TextFV);
    Reset(WordFV);
    {$I+}

    if IOResult<>0 then begin
      TextColor(3);
      WriteLn('���� �� ��� 䠩��� �� �������!');
      TextColor(7);
      WriteLn('������ ���� �������');
      ReadKey;
      Halt;
    end;
  end;{OpenFile}

  function UpCaseStr(S:string):string;
  const ABC_1:string='���������������������������������';
        abc_2:string='������񦧨�����������������������';
  var i,P:byte;
      Result:string;
  begin
    Result:='';
    for i:=1 to Length(S) do
    begin
      P:=Pos(S[i],abc_2);
      if P>0 then Result:=Result+ABC_1[P]
             else Result:=Result+S[i];
    end;
    UpCaseStr:=Result;
  end;{UpCaseStr}

  function StrToMas(S:string;var MasWord:TMasWord):byte;

    function PosSeveral(SubStr,S:string):byte;
    var i,j:byte;
    begin
      for i:=1 to Length(S) do
        for j:=1 to Length(SubStr) do
          if S[i]=SubStr[j] then
          begin
            PosSeveral:=i;
            Exit;
          end;
      PosSeveral:=0;
    end;{PosSeveral}

  const Sign:string=' .,:;!?"-*()';
  var i:byte;
  begin
    i:=0;
    while Pos(S[1],Sign)>0 do Delete(S,1,1);
    while PosSeveral(Sign,S)>0 do
    begin
      Inc(i);
      MasWord[i]:=Copy(S,1,PosSeveral(Sign,S)-1);
      Delete(S,1,PosSeveral(Sign,S));
      while (Pos(S[1],Sign)>0)and(S<>'') do Delete(S,1,1);
    end;
    if S<>'' then begin Inc(i);MasWord[i]:=S;end;
    StrToMas:=i;
  end;{StrToMas}


  function ReadWord(var MasKey:TMasWord):byte;
  var i,Count:byte;
      S:string;
  begin
    Count:=0;
    for i:=1 to 50 do
      MasKey[i]:='';
    while not EOF(WordFV) do
    begin
      ReadLn(WordFV,S);
      Inc(Count,StrToMas(S,MasKey));
    end;
    ReadWord:=Count;
  end;{ReadWord}

Begin
  ClrScr;
  TextColor(14);
  WriteLn;WriteLn;
  WriteLn('%%% "Percent" - "��業�" %%%');
  WriteLn('%%% ��।������ ��業� ���稢�� ᫮� �� �� ��饣� ������⢠ %%%');
  WriteLn;
  TextColor(15);
  Write('������ ��� 䠩�� � �஢��塞� ⥪�⮬: ');ReadLn(TextFN);
  Write('������ ��� 䠩�� � ���祢묨 ᫮����: ');ReadLn(WordFN);

{��砫� ࠡ�祩 ���}
  OpenFile(TextFN,WordFN);
  All:=0;Find:=0;

  CountKey:=ReadWord(MasKey);{���뢠��� ���祢�� ᫮�}
  WriteLn;
  while not EOF(TextFV) do
  begin
    ReadLn(TextFV,S);
    CountWord:=StrToMas(S,MasWord);

    for i:=1 to CountWord do
      for j:=1 to CountKey do
        if UpCaseStr(MasKey[j])=UpCaseStr(MasWord[i]) then Inc(Find);

    Inc(All,CountWord);
    TextColor(7);
    Write('.');

  end;
  WriteLn;

  P:=Find/All;
{����� ࠡ�祩 ���}

  TextColor(10);
  WriteLn('���祢� ᫮�� ��⠢���� ',P:0:3,' %');

  TextColor(14);
  WriteLn;
  WriteLn('%%% �ᥣ� ������襣� %%%');
  TextColor(7);
  WriteLn('������ ���� �������');
  Close(TextFV);
  Close(WordFV);
  ReadKey;
End.{�.�. �३���  15.09.2002}
