const   ginp='sqrnum.inp';
        gout='sqrnum.out';
        maxn=1000000;

var     n,cou:longint;
        d,nt:array[0..maxn] of longint;

procedure create;
var     i,j:longint;
begin
        for i:=2 to maxn do
                if nt[i]=0 then
                begin
                        nt[i]:=i;
                        for j:=i to maxn div i do nt[i*j]:=i;
                end;
end;

procedure process;
var     i,x:longint;
begin
        readln(n);
        cou:=0;
        for i:=1 to n do
        begin
                readln(x);
                while x>1 do
                begin
                        inc(d[nt[x]]);
                        if d[nt[x]] and 1=0 then dec(cou) else inc(cou);
                        x:=x div nt[x];
                end;
                if cou=0 then writeln('YES') else writeln('NO');
        end;
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        create;
        process;
        close(input);close(output);
end.
