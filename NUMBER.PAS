program palindromic;
uses CRT;
var number,i,value1,z,value2:integer;
    stroka:string;
    v:boolean;

procedure Frame;
Var i:byte;
Begin
   TextColor(15);
   gotoxy(2,1);
   write('�');
   For i:=1 to 36 do write('�');write('�');
   For i:=2 to 25 do Begin GoToXY(39,i);Write('�');End;
   For i:=2 to 25 do Begin GoToXY(2,i);Write('�');End;
   GoToXY(2,25);Write('�');
   For i:=2 to 37 do Write('�');Write('�');
   gotoxy(4,1);write('palindromic');
end;

function extent(power:integer):integer;
var i,k:integer;
begin
    k:=1;
    for i:=1 to power-1 do k:=k*10;
    extent:=k;
end;

begin
    textmode(co40);textbackground(1);textcolor(10);clrscr;
    frame;textcolor(12);
    gotoxy(5,5);write('����������� ����������');
    textcolor(14);
    gotoxy(5,8);write('������ �᫮: ');readln(number);
    gotoxy(5,10);textcolor(13);
    str(number,stroka);
    z:=extent(trunc(ln(number)/ ln(10)+1));
    value1:=1;
    value2:=z;
    v:=true;
    for i:=1 to z div 2 do
    begin
       if((number div value1)mod 10)<>((number div value2)mod 10)then
                                                                 begin
                                                                 v:=false;
                                                                 textcolor(9);
                                                                 gotoxy(5,10);
                                                                 write('��᫮ ',number,' �� ���������');
                                                                 break;
                                                                 end;
    end;
    if v then begin
              gotoxy(5,10);
              textcolor(13);
              write('��᫮ ',number,' ���������');
              end;
    gotoxy(5,15);textcolor(2);write('���쬠 ��������� �� �ਮ��⥭��');
    gotoxy(5,16);write('�⮩ 㬭�� � �祭� �������� �');
    gotoxy(5,17);write('���ᥤ������ ����� �ணࠬ��.');
    gotoxy(5,18);write('業� �� ');
    textcolor(128+12);
    write('500$');
    textcolor(2);
    write(' (�ࠢ��⥫쭮 ��襢�)');
    textcolor(128+10);
    gotoxy(5,20);write('(C) 2000 ��� �ணࠬ�� ᤫ�� �');
    readkey;
end.