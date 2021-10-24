Const   ginp='triangle.inp';
        gout='triangle.out';

Type    Mang= array[1..12] of boolean;

Var     d:array[1..12] of mang;
        d3:array[1..12,1..12] of mang;
        dd:mang;
        res:longint;

Function Check(x:longint):mang;
Var     c:mang;
Begin
        fillchar(c,sizeof(c),false);
        if x=1 then
        begin
                c[2]:=true; c[3]:=true; c[4]:=true; c[5]:=true; c[8]:=true; c[10]:=true; c[11]:=true; c[12]:=true;
        end;
        if x=2 then
        begin
                c[3]:=true; c[4]:=true; c[5]:=true; c[6]:=true; c[7]:=true; c[9]:=true; c[10]:=true; c[11]:=true; c[12]:=true;
        end;
        if x=3 then
        begin
                c[4]:=true; c[5]:=true; c[8]:=true; c[11]:=true;
        end;
        if x=4 then
        begin
                c[6]:=true; c[7]:=true; c[8]:=true; c[9]:=true; c[10]:=true; c[11]:=true; c[12]:=true;
        end;
        if x=5 then
        begin
                c[6]:=true; c[8]:=true; c[9]:=true; c[11]:=true; c[12]:=true;
        end;
        if x=6 then
        begin
                c[7]:=true; c[8]:=true; c[9]:=true; c[10]:=true; c[12]:=true;
        end;
        if x=7 then
        begin
                c[8]:=true; c[10]:=true; c[11]:=true;
        end;
        if x=8 then
        begin
                c[10]:=true; c[11]:=true;
        end;
        if x=9 then
        begin
                c[11]:=true; c[12]:=true;
        end;
        if x=10 then
        begin
                c[11]:=true; c[12]:=true;
        end;
        if x=11 then
        begin
                c[12]:=true;
        end;
        if x=12 then
        begin

        end;
        check:=c;
End;

Procedure Init;
Var     i:longint;
Begin
        for i:=1 to 12 do d[i]:=check(i);
        fillchar(d3,sizeof(d3),true);
        d3[1,2,10]:=false; d3[1,3,5]:=false; d3[1,3,8]:=false; d3[1,3,11]:=false; d3[1,5,8]:=false; d3[1,5,11]:=false; d3[1,8,11]:=false; d3[1,4,12]:=false;
        d3[2,3,4]:=false; d3[2,5,6]:=false; d3[2,5,9]:=false; d3[2,5,12]:=false; d3[2,6,9]:=false; d3[2,6,12]:=false; d3[2,9,12]:=false; d3[2,7,11]:=false;
        d3[3,5,8]:=false; d3[3,5,11]:=false; d3[3,8,11]:=false;
        d3[4,6,8]:=false; d3[4,6,7]:=false; d3[4,6,10]:=false; d3[4,7,8]:=false; d3[4,8,10]:=false; d3[4,7,10]:=false; d3[4,9,11]:=false;
        d3[5,8,11]:=false; d3[5,6,9]:=false; d3[5,6,12]:=false; d3[5,9,12]:=false;
        d3[6,7,8]:=false; d3[6,7,10]:=false; d3[6,8,10]:=false; d3[6,9,12]:=false;
        d3[7,8,10]:=false;
        d3[10,11,12]:=false;
End;

Procedure Dlt(x:longint);
Begin
        if x=1 then
        begin
                dd[7]:=false;
                d[2,11]:=false;
        end;
        if x=2 then
        begin
                dd[3]:=false;
                d[2,4]:=false;
        end;
        if x=3 then
        begin
                dd[9]:=false;
                d[4,11]:=false;
        end;
End;

Procedure Enter;
Var     i,k,x:longint;
Begin
        fillchar(dd,sizeof(dd),true);
        readln(k);
        for i:=1 to k do
        begin
                read(x);
                dlt(x);
        end;
End;

Procedure Process;
Var     i,j,k:longint;
Begin
        res:=0;
        for i:=1 to 12 do
                if dd[i] then
                for j:=i+1 to 12 do
                        if (dd[j]) and (d[i,j]) then
                        for k:=j+1 to 12 do
                                if (dd[k]) and (d[j,k]) and (d[i,k]) and (d3[i,j,k]) then inc(res);
        write(res);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Init;
        Enter;
        Process;
        Close(input); Close(output);
End.
