Uses    Math;

Const   ginp='wordgame.inp';
        gout='wordgame.out';
        oo=trunc(1e5);

Var     n,m,res:longint;
        s:string[50];
        a:array[0..101] of string[10];
        f:array[0..50,'a'..'z'] of longint;

Procedure Enter;
Var     i:longint;
Begin
        readln(s); n:=length(s);
        readln(m);
        for i:=1 to m do readln(a[i]);
End;

Function Same(x,y:string):longint;
Var     i,j:longint;
Begin
        same:=0; j:=length(y);
        for i:=length(x) downto 1 do
                if (j>0) and (x[i]=y[j]) then
                begin
                        inc(same);
                        dec(j);
                end;
End;

Procedure Process;
Var     i,j,k:longint;
        x:char;
Begin
        for x:='a' to 'z' do f[0,x]:=0;
        for i:=1 to n do
        begin
                for x:='a' to 'z' do f[i,x]:=oo;
                for j:=1 to m do
                        for k:=1 to same(a[j],copy(s,1,i)) do
                                f[i,a[j,length(a[j])]]:=min(f[i,a[j,length(a[j])]],f[i-k,a[j,1]]+length(a[j]));
        end;
        res:=oo;
        for x:='a' to 'z' do res:=min(res,f[n,x]);
        if res=oo then write(-1) else write(res);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
