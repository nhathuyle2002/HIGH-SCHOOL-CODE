const   ginp='coffee.inp';
        gout='coffee.out';

var     gi,go:text;
        n,h,m:Longint;
        dem:int64;
        a:array[0..2000] of int64;

function tinh:longint;
begin
        tinh:=60*h+m;
end;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n);
        for i:=1 to n do
        begin
                readln(gi,h,m);
                inc(a[tinh]);
        end;
end;

procedure output;
var     i:longint;
begin
        dem:=1;
        for i:=0 to 2000 do
                if a[i]>dem then dem:=a[i];
        write(go,dem);
        close(gi);close(go);
end;

begin
        input;
        output;
end.
