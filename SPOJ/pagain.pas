const   ginp='ss.inp';
        gout='ss.out';
        maxn=4294967296;
        maxnt=trunc(sqrt(maxn));

var     gi,go:text;
        n,ans:int64;
        nt:array[0..100000] of longint;
        nnt:longint;

procedure sangnt;
var     i,j,tm:longint;
        d:array[1..maxnt] of boolean;
begin
        fillchar(d,sizeof(d),true);
        for i:=2 to maxnt do
                if d[i] then
                begin
                        inc(nnt);
                        nt[nnt]:=i;
                        for j:=2 to maxnt div i do d[i*j]:=false;
                end;
end;

function check(x:int64):boolean;
var     i:longint;
begin
        for i:=1 to nnt do
                if x mod nt[i]=0 then exit(false) else
                if nt[i]>sqrt(x) then exit(true);
        exit(true);
end;

procedure input;
var     i,t,j:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,t);
        for j:=1 to t do
        begin
                readln(gi,n);
                for i:=1 to 1000000 do
                        if check(n-i) then
                        begin
                                ans:=n-i;
                                break;
                        end;
                writeln(go,ans);
        end;
        close(gi);close(go);
end;

begin
        sangnt;
        input;
end.
