const   ginp='ss.inp';
        gout='ss.out';

var     gi,go:text;
        m,n:longint;
        ans:int64;
        a,f:array[0..5001,0..5001] of longint;

procedure input;
var     i,j:longint;
        s:ansistring;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,m,n);
        for i:=1 to m do
        begin
                readln(gi,s);
                for j:=1 to n do a[i,j]:=ord(s[j])-48;
        end;
end;

function min(x,y,z:longint):longint;
begin
        min:=x;
        if min>y then min:=y;
        if min>z then min:=z;
end;

procedure process;
var     i,j:longint;
begin
        ans:=0;
        for i:=1 to m do
                for j:=1 to n do
                begin
                        if a[i,j]=1 then f[i,j]:=0
                        else f[i,j]:=min(f[i-1,j],f[i,j-1],f[i-1,j-1])+1;
                        ans:=ans+f[i,j];
                end;
end;

procedure output;
begin
        write(go,ans);
        close(gi);close(go);
end;

begin
        input;
        process;
        output;
end.
