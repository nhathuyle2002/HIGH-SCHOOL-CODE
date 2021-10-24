Const   ginp='wp.inp';
        gout='wp.out';
        maxx=4010;
        xx=1005;
        yy=2005;

type    matrix=array[0..maxx,0..maxx] of longint;

Var     f,g,a:matrix;

Procedure Updatef(x,y,w:longint);
Var     j:longint;
Begin
        x:=x+xx; y:=y+yy;
        while x<=maxx do
        begin
                j:=y;
                while j<=maxx do
                begin
                        f[x,j]:=f[x,j]+w;
                        j:=j+j and (-j);
                end;
                x:=x+x and (-x);
        end;
End;

Procedure Updateg(x,y,w:longint);
Var     j:longint;
Begin
        x:=x+xx; y:=y+yy;
        while x<=maxx do
        begin
                j:=y;
                while j<=maxx do
                begin
                        g[x,j]:=g[x,j]+w;
                        j:=j+j and (-j);
                end;
                x:=x+x and (-x);
        end;
End;

Function Quecef(x,y:longint):longint;
Var     j:longint;
Begin
        quecef:=0;
        while x>0 do
        begin
                j:=y;
                while j>0 do
                begin
                        quecef:=quecef+f[x,j];
                        j:=j-j and (-j);
                end;
                x:=x-x and (-x);
        end;
End;

Function Queceg(x,y:longint):longint;
Var     j:longint;
Begin
        queceg:=0;
        while x>0 do
        begin
                j:=y;
                while j>0 do
                begin
                        queceg:=queceg+g[x,j];
                        j:=j-j and (-j);
                end;
                x:=x-x and (-x);
        end;
End;

Function Answerf(x,y,x0,y0:longint):longint;
Begin
        x:=x+xx; y:=y+yy; x0:=x0+xx; y0:=y0+yy;
        answerf:=quecef(x,y)-quecef(x,y0)-quecef(x0,y)+quecef(x0,y0);
End;

Function Answerg(x,y,x0,y0:longint):longint;
Begin
        x:=x+xx; y:=y+yy; x0:=x0+xx; y0:=y0+yy;
        answerg:=queceg(x,y)-queceg(x,y0)-queceg(x0,y)+queceg(x0,y0);
End;

Procedure Process;
Var     i,st,x,y,d:longint;
        ms:string[1];
Begin
        readln(st);
        for i:=1 to st do
        begin
                readln(ms,x,y,d);
                if ms='S' then
                begin
                        if (x+y) mod 2=0 then updatef(x+y,x-y,d-a[x,y])
                        else updateg(x+y,x-y,d-a[x,y]);
                        a[x,y]:=d;
                end
                else
                begin
                        if (x+d+y) mod 2=0 then
                                writeln(answerf(x+d+y,x+d-y,x-d+y-2,x-y-d-2)+
                                        answerg(x+d+y-1,x+d-y-1,x-d+y-1,x-d-y-1))
                        else    writeln(answerg(x+d+y,x+d-y,x-d+y-2,x-y-d-2)+
                                        answerf(x+d+y-1,x+d-y-1,x-d+y-1,x-d-y-1));
                end;
        end;
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Process;
        Close(input); Close(output);
End.
