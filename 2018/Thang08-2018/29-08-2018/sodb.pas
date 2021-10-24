const   ginp='sodb.inp';
        gout='sodb.out';
        maxn=100010;

var     gi,go:text;
        n:longint;
        nt,s:array[0.. maxn] of longint;

function tcs(x:longint):longint;
begin
        tcs:=0;
        while x<>0 do
        begin
                inc(tcs,x mod 10);
                x:=x div 10;
        end;
end;

procedure sangnt;
var     i,j:longint;
        d:array[0..maxn] of boolean;
begin
        fillchar(d,sizeof(d),true);
        for i:=2 to maxn do
                if d[i] then
                begin
                        inc(n);nt[n]:=i;s[n]:=tcs(i);
                        for j:=i to maxn div i do d[i*j]:=false;
                end;
end;

function pt(x:longint):longint;
var     i:longint;
begin
        pt:=0;
        for i:=1 to n do
        begin
                if nt[i]>sqrt(x) then break;
                while x mod nt[i]=0 do
                begin
                        pt:=pt+s[i];
                        x:=x div nt[i];
                end;
        end;
        if pt=0 then exit(0);
        if x>1 then pt:=pt+tcs(x);
end;

procedure main;
var     x:longint;
begin
        read(gi,x);
        inc(x);
        while pt(x)<>tcs(x) do inc(x);
        write(go,x);
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        sangnt;
        main;
        close(gi);close(go);
end.
