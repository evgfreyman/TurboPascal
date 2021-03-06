unit MOUSE;
interface
uses CRT,DOS;
var regs:registers;

procedure Init(var ButtonCount,ErrorCode:byte);
{���樠������ ���}

procedure MouseOn;
{����祭�� ����� ���}

procedure MouseOff;
{�몫�祭�� ����� ���}

procedure GetMouseXY(var x,y:word;var LeftButton,RightButton,ThirdButton:boolean);
{�����頥� ���न���� ����� � ���ﭨ� ������,
����⮩ ������ ᮮ⢥����� TRUE, �� ����⮩ - FALSE}
procedure SetMouseXY(x,y:word);
{��⠭���� ����� � �������� �窥 ��࠭�}

procedure GetMouseXYOnDown(var x,y:word;ButtonNumber:byte;
var Count:byte;LeftButton,RightButton,ThirdButton:boolean);
{�����頥� ���न���� x,y ����� ��� �� ������ ������ ������,
�������� ����� ButtonNumber 0- �����, 1- �ࠢ��, 2- �����;
�����頥� LeftButton, RightButton, ThirdButton - ���ﭨ� ������ �� ����� ������.
Count - �᫮ ����⨩ �������� ������ ��᫥ ��᫥����� ��뢠
�㭪樨 GetMouseXYOnDown}

procedure GetMouseXYOnUp(var x,y:word;ButtonNumber:byte;
var Count:byte;var LeftButton,RightButton,ThirdButton:boolean);
{�����頥� ���न���� ����� x, y ����� ��� �� ������ ���᪠��� ������}

procedure SetXRange(XMin,XMax:word);
{��⠭�������� ��࠭�祭�� ��६�饭�� ����� ��� �� ��ਧ��⠫�}

procedure SetYRange(YMin,YMax:word);
{��⠭�������� ��࠭�祭�� ��६�饭�� ����� ��� �� ���⨪���}

procedure SetExptionRegion(x1,y1,x2,y2:word);
{��⠭�������� ��אַ㣮���� �������, � ���ன ����� �� �⮡ࠦ�����}

procedure SetCursorForm(xPointer,yPointer:shortint;Form:Pointer);
{��⠭���� ����� ��� ����� � ����᪮� ०���}

procedure SetTextCursorSize(FirstLine,LastLine:word);
{��⠭�������� ����� � ��᫥���� ����� ��� ��אַ㣮�쭮��
⥪�⮢��� �����}

procedure SetTextCursorForm(AndMask,XorMask:byte);
{��⠭���� ��� ����� � ⥪�⮢�� ०���}
implementation

procedure Init(var ButtonCount,ErrorCode:byte);
begin
  ClrScr;
  with regs do begin
    ax:=$0000;
    intr($33,regs);
    if ax=$FFFF then ErrorCode:=0 else ErrorCode:=1;
    ButtonCount:=bx
  end
end;

procedure MouseOn;
begin
  regs.ax:=$0001;
  intr($33,regs);
end;

procedure MouseOff;
begin
  regs.ax:=$0002;
  intr($33,regs);
end;

procedure GetMouseXY(var x,y:word;var LeftButton,RightButton,ThirdButton:boolean);
var ButtonCount:byte;
begin
  with regs do begin
    ax:=$0003;
    intr($33,regs);
    X:=CX;
    Y:=DX;
    ButtonCount:=bx
  end;
  LeftButton:=(ButtonCount and 1)=1;
  RightButton:=(ButtonCount and 2)=2;
  ThirdButton:=(ButtonCount and 4)=4;
end;

procedure SetMouseXY(x,y:word);
begin
  with regs do begin
    ax:=$0004;
    cx:=x;
    dx:=y;
    intr($33,regs);
  end
end;

procedure GetMouseXYOnDown(var x,y:word;ButtonNumber:byte;
var Count:byte;LeftButton,RightButton,ThirdButton:boolean);
var ButtonCount:byte;
begin
  with regs do begin
    ax:=$0005;
    bx:=ButtonNumber;
    intr($33,regs);
    ButtonCount:=ax;
    Count:=bx;
    x:=cx;
    y:=dx
  end;
  LeftButton:=(ButtonCount and 1)=1;
  RightButton:=(ButtonCount and 2)=2;
  ThirdButton:=(ButtonCount and 4)=4;
end;

procedure GetMouseXYOnUp(var x,y:word;ButtonNumber:byte;
var Count:byte;var LeftButton,RightButton,ThirdButton:boolean);
var ButtonCount:byte;
begin
  with regs do begin
    ax:=$0006;
    bx:=ButtonNumber;
    intr($33,regs);
    ButtonCount:=ax;
    Count:=bx;
    x:=cx;
    y:=dx
  end;
  LeftButton:=(ButtonCount and 1)=1;
  RightButton:=(ButtonCount and 2)=2;
  ThirdButton:=(ButtonCount and 4)=4;
end;

procedure SetXRange(XMin,XMax:word);
begin
  with regs do begin
    ax:=$0007;
    cx:=XMin;
    dx:=XMax;
    intr($33,regs);
  end
end;

procedure SetYRange(YMin,YMax:word);
begin
  with regs do begin
    ax:=$0008;
    cx:=YMin;
    dx:=YMax;
    intr($33,regs);
  end
end;

procedure SetExptionRegion(x1,y1,x2,y2:word);
begin
  with regs do begin
    ax:=$0010;
    cx:=x1;dx:=y1;
    si:=x2;di:=y2;
    intr($33,regs)
  end
end;

procedure SetCursorForm(xPointer,yPointer:shortint;Form:Pointer);
begin
  MouseOff;
  With regs do begin
    ax:=$0009;
    bx:=xPointer;
    cx:=yPointer;
    es:=seg(Form^);
    dx:=ofs(Form^);
    intr($33,regs);
    MouseOn;
  end
end;

procedure SetTextCursorSize(FirstLine,LastLine:word);
begin
  with regs do begin
    ax:=$000A;
    bx:=0001;
    cx:=FirstLine;
    dx:=LastLine;
    intr($33,regs);
  end
end;

procedure SetTextCursorForm(AndMask,XorMask:byte);
begin
  with regs do begin
    ax:=$000A;
    bx:=0;
    cx:=AndMask;
    dx:=XorMask;
    intr($33,regs);
  end
end;

End.
 o \             A *.FRM                                        *.MAC                                                           <�         A *.FRM  �������������������� 