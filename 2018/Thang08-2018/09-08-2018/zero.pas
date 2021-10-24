const   ginp='zero.inp';
        gout='zero.out';
        maxn=1000000;

var     q,n:longint;
        d:array[0..maxn+1] of longint;

function min(x,y:longint):longint;
begin
        if x<y then exit(x) else exit(y);
end;

procedure create;
var     i,j:longint;
begin
        for i:=1 to maxn do d[i]:=i;
        for i:=1 to maxn do
        begin
                d[i+1]:=min(d[i+1],d[i]+1);
                for j:=2 to min(i,maxn div i) do
                        d[i*j]:=min(d[i*j],d[i]+1);
        end;
end;

procedure process;
var     i:longint;
begin
        readln(q);
        for i:=1 to q do
        begin
                readln(n);
                writeln(d[n]);
        end;
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        create;
        process;
        close(input);close(output);
end.
