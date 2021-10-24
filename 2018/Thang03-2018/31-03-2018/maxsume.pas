const   ginp='maxsume.inp';
        gout='maxsume.out';

var     gi,go:text;
        m,n:longint;
        a,f:array[0..1001,0..1001] of int64;

procedure input;
var     i,j:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,m,n);
        for i:=1 to m do
        begin
                for j:=1 to n do read(gi,a[i,j]);
                readln(gi);
        end;
end;

procedure tgt(i,j:longint);
begin
        if a[i,j] mod 2=0 then f[i,j]:=a[i,j] else f[i,j]:=0;
        if f[i-1,j]>f[i,j-1] then f[i,j]:=f[i,j]+f[i-1,j] else f[i,j]:=f[i,j]+f[i,j-1];
end;

procedure process;
var     i,j:longint;
begin
        for i:=1 to m do
                for j:=1 to n do tgt(i,j);
end;

procedure output;
begin
        write(go,f[m,n]);
        close(gi);close(go);
end;

begin
        input;
        process;
        output;
end.

