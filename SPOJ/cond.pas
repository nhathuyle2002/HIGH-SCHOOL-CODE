const   ginp='ss.inp';
        gout='ss.out';

var     gi,go:text;
        n:longint;
        sum:array[0..11] of longint;
        f:array[0..11,0..11] of longint;

procedure main;
var     i,j:longint;
begin
        f[1,1]:=1;
        for i:=2 to 10 do
                for j:=1 to i do
                        f[i,j]:=j*(f[i-1,j]+f[i-1,j-1]);
        for i:=1 to 10 do
                for j:=1 to i do inc(sum[i],f[i,j]);
        readln(gi,n);
        while n>-1 do
        begin
                writeln(go,sum[n]);
                readln(gi,n);
        end;
end;

begin
        assign(gi,ginp);reset(gi);
        assign(go,gout);rewrite(go);
        main;
        close(gi);close(go);
end.
