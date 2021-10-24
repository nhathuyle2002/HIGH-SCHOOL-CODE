const   ginp='nzero.inp';
        gout='nzero.out';
        maxn=1000001;

var     gi,go:text;
        tnt,tc:array[0..maxn] of int64;
        d:array[0..maxn] of boolean;

procedure create;
var     i,j:longint;
        tm:int64;
begin
        fillchar(d,sizeof(d),true);
        d[1]:=false;tnt[1]:=1;tc[1]:=1;
        for i:=2 to trunc(sqrt(maxn)) do
                if d[i] then
                begin
                        for j:=2 to maxn div i do d[i*j]:=false;
                        tm:=i;
                        while tm<maxn do
                        begin
                                tnt[tm]:=i;
                                tm:=tm*i;
                        end;
                end;
        for i:=trunc(sqrt(maxn))+1 to maxn do
                if d[i] then tnt[i]:=i;
        for i:=2 to maxn do
                if tnt[i]=0 then tc[i]:=tc[i-1]
                else if tnt[i]=5 then tc[i]:=tc[i-1] div 2
                else tc[i]:=tc[i-1]*tnt[i];
end;

procedure main;
var     i,x:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,x);
        while x<>0 do
        begin
                writeln(go,tc[x] mod 10);
                readln(gi,x);
        end;
        close(gi);close(go);
end;

begin
        create;
        main;
end.
