const   ginp='divseq.inp';
        gout='divseq.out';

var     st,n,kk,res:longint;
        a:array[0..50010] of longint;
        d:array[0..1000010] of longint;

procedure main;
var     i:longint;
begin
        readln(kk,n);
        for i:=1 to n do
        begin
                read(a[i]);
                a[i]:=(a[i-1]+a[i]) mod kk;
        end;
        readln;
        res:=0;
        fillchar(d,sizeof(d),0);
        d[0]:=1;
        for i:=1 to n do
        begin
                res:=res+d[a[i]];
                inc(d[a[i]]);
        end;
        writeln(res);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        readln(st);
        while st>0 do
        begin
                main;
                dec(st);
        end;
        close(input);close(output);
end.
