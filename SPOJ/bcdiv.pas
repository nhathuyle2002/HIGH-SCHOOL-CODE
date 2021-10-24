const   ginp='ss.inp';
        gout='ss.out';

var     gi,go:text;
        n,k:longint;
        f:array[0..30,0..30] of int64;

procedure process;
var     i,j:longint;
begin
        fillchar(f,sizeof(f),0);
        f[0,0]:=1;
        for i:=1 to n do
                for j:=1 to k do
                        f[i,j]:=f[i-1,j]*j+f[i-1,j-1];
end;

procedure main;
var     i,t:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,t);
        for i:=1 to t do
        begin
                readln(gi,n,k);
                process;
                writeln(go,f[n,k]);
        end;
        close(gi);close(go);
end;

begin
        main;
end.