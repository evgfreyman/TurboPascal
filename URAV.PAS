Program Calc;
uses CRT;
var a,b,x:integer;
    s:string;
Begin
  ClrScr;
  WriteLn('��������, x- 楫�� �᫮');
  Write('������ A: ');ReadLn(a);
  Write('������ B: ');ReadLn(b);
  Write('�� ���� �⢮���: ');ReadLn(s);
  if s='*' then x:=a*b;
  if s='/' then x:=a div b;
  if s='+' then x:=a+b;
  if s='-' then x:=a-b;
  if (s<>'*')and(s<>'/')and(s<>'+')and(s<>'-') then
    Writeln ( '�� ��?');

  WriteLn('X=',x);
  WriteLn('2002 �३��� �.');
  ReadKey;
End.