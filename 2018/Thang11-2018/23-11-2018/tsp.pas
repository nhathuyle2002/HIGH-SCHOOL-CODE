Uses    Math;

Const   ginp='tsp.inp';
        gout='tsp.out';
        maxn=20;
        oo=trunc(1e8)+1;

Var     n,res:longint;
        w:array[0..maxn,0..maxn] of longint;
        f:array[0..1 shl maxn,0..maxn] of longint;

Procedure Enter;
Var     i,j,m,c:longint;
Begin
        readln(n,m);
        dec(n);
        for i:=0 to n do
                for j:=0 to n do w[i,j]:=oo;
        for m:=1 to m do
        begin
                readln(i,j,c);
                dec(i); dec(j);
                w[i,j]:=min(w[i,j],c);
        end;
End;

Function Getb(x,i:longint):longint;
Begin
        getb:=x shr (i-1) and 1;
End;

Function Setb(x,i,t:longint):longint;
Begin
        if t=1 then setb:=x or (1 shl (i-1))
        else setb:=x and (not (1 shl (i-1)));
End;

Procedure Process;
Var     x,y,i,j:longint;
Begin
        for x:=1 to 1 shl n-1 do
                for i:=1 to n do
                if getb(x,i)=1 then
                begin
                        y:=setb(x,i,0);
                        if y=0 then f[x,i]:=w[0,i] else
                        begin
                                f[x,i]:=oo;
                                for j:=1 to n do
                                        if getb(y,j)=1 then f[x,i]:=min(f[x,i],f[y,j]+w[j,i]);
                        end;
                end;
        res:=oo;
        for i:=1 to n do res:=min(res,f[1 shl n-1,i]+w[i,0]);
        write(res);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
