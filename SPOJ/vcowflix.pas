const   ginp='ss.inp';
        gout='ss.out';

var     gi,go:text;
        n,m:longint;
        w:array[0..20] of longint;
        f:array[0..20,0..5000] of longint;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,m,n);
        for i:=1 to n do readln(gi,w[i]);
end;

procedure output;
var     i,j:longint;
begin
        for i:=1 to n do
                for j:=1 to m do
                begin
                        f[i,j]:=f[i-1,j];
                        if j-w[i]>=0 then
                                if f[i-1,j-w[i]]+w[i]>f[i-1,j] then f[i,j]:=f[i-1,j-w[i]]+w[i];
                end;
        write(go,f[n,m]);
        close(gi);close(go);
end;

begin
        input;
        output;
end.