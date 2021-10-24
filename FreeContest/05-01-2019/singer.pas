Uses    Math;

Const   ginp='singer.inp';
        gout='singer.out';
        maxn=500;//6421;
        base=998244353;

Var     n,d,t,res:longint;
        x:array[0..maxn] of longint;
        f:array[0..maxn,0..maxn,0..maxn,0..1] of longint;//array of array of array of array of longint;

Procedure Enter;
Begin
        read(n,d,t);
End;

Procedure Try(i,im,cou:longint);
Var     j,im2:longint;
Begin
        if cou>t then exit;
        if i>n then
        begin
                if cou=t then inc(res);
                exit;
        end;
        for j:=0 to 1 do
        begin
                x[i]:=j;
                if x[i]=x[i-1] then im2:=i-1 else im2:=im;
                if i-im2>=d-1 then try(i+1,im2,cou+1) else try(i+1,im2,cou);
        end;
End;

Procedure Process1;
Begin
        res:=0;
        try(1,0,0);
        writeln(res);
End;

Procedure Process2;
Var     i,j,j2,k:longint;
Begin
        {setlength(f,n+1);
        for i:=1 to n do
        begin
                setlength(f[i],t+1);
                for j:=0 to t do
                begin
                        setlength(f[i,j],n+1);
                        for j2:=0 to n do
                                setlength(f[i,j,j2],2);
                end;
        end;}
        if d=2 then
        begin
                f[1,1,1,0]:=1; f[1,1,1,1]:=1;
        end else
        begin
                f[1,0,1,0]:=1; f[1,0,1,1]:=1;
        end;
        for i:=2 to n do
        for j:=0 to min(i,t) do
        begin
                for j2:=1 to i-1 do
                        for k:=0 to 1 do
                                if (d=2) and (j>0) then f[i,j,1,k]:=(f[i,j,1,k]+f[i-1,j-1,j2,k]) mod base else
                                if (d>2) then f[i,j,1,k]:=(f[i,j,1,k]+f[i-1,j,j2,k]) mod base;
                for j2:=2 to i do
                        for k:=0 to 1 do
                                if (j2<d-1) then f[i,j,j2,k]:=f[i-1,j,j2-1,1-k] else
                                if (j2>=d-1) and (j>0) then f[i,j,j2,k]:=f[i-1,j-1,j2-1,1-k];
        end;
        res:=0;
        for j2:=1 to n do
                for k:=0 to 1 do
                        res:=(res+f[n,t,j2,k]) mod base;
        writeln(res);
End;

Procedure Sinh;
Var     i,j:longint;
        Function R(x:longint):longint;
        Begin
                r:=random(x);
        End;
Begin
        Assign(output,ginp); Rewrite(output);
        randomize;
        n:=r(20)+1; d:=r(n-1)+2; t:=r(5)+1;
        write(n,' ',d,' ',t);
        Close(output);
End;

Begin
        //Sinh;
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        //Process1;
        Process2;
        Close(input); Close(output);
End.
