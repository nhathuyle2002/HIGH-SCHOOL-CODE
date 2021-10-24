Uses    Math;

Const   ginp='bonus.inp';
        gout='bonus.out';
        maxn=101;

Var     n:longint;
        res:int64;
        s:array[0..maxn,0..maxn] of int64;

Function Get(i,j,i0,j0:longint):int64;
Begin
        if (i>i0) or (j>j0) then exit(0);
        get:=s[i0,j0]-s[i-1,j0]-s[i0,j-1]+s[i-1,j-1];
End;

Procedure Enter;
Var     i,j:longint;
Begin
        readln(n);
        for i:=1 to n do
        begin
                for j:=1 to n do
                begin
                        read(s[i,j]);
                        s[i,j]:=s[i-1,j]+s[i,j-1]-s[i-1,j-1]+s[i,j];
                end;
                readln;
        end;
End;

Procedure Process;
Var     x,y,z:longint;
        f:array[0..1,0..1] of int64;
Begin
        res:=0;

        for x:=1 to n do
        for y:=1 to n do
        begin
                fillchar(f,sizeof(f),0);
                for z:=0 to n do
                if (x-z<1) or (y-z<1) or (x+z>n) or (y+z>n) then break else
                begin
                        f[1,0]:=f[0,1];
                        f[1,1]:=f[0,0]+get(x-z,y-z,x+z,y+z)-get(x-z+1,y-z+1,x+z-1,y+z-1);
                        f[0]:=f[1];
                        res:=max(res,f[1,1]);
                end;
        end;

        for x:=1 to n do
        for y:=1 to n do
        begin
                fillchar(f,sizeof(f),0);
                for z:=0 to n do
                if (x-z-1<1) or (y-z-1<1) or (x+z>n) or (y+z>n) then break else
                begin
                        f[1,0]:=f[0,1];
                        f[1,1]:=f[0,0]+get(x-z-1,y-z-1,x+z,y+z)-get(x-z,y-z,x+z-1,y+z-1);
                        f[0]:=f[1];
                        res:=max(res,f[1,1]);
                end;
        end;

        write(res);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
