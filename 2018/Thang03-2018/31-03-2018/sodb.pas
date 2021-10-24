const   ginp='sodb.inp';
        gout='sodb.out';
        maxn=1000000000;

var     gi,go:text;
        ans,nn,sl,n:longint;
        nt,a:array[0..1000001] of longint;

procedure sangnt;
var     i,j,tm:longint;
        d:array[0..1000001] of boolean;
begin
        tm:=trunc(sqrt(2*maxn));
        fillchar(d,sizeof(d),true);
        for i:=2 to trunc(sqrt(tm)) do
                if d[i] then
                for j:=2 to tm div i do d[i*j]:=false;
        sl:=0;
        for i:=2 to tm do
                if d[i] then
                begin
                        inc(sl);
                        nt[sl]:=i;
                end;
end;

procedure input;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        read(gi,nn);
end;

procedure phantich(x:longint);
var     i:longint;
begin
        i:=0;n:=0;
        repeat
                inc(i);
                while x mod nt[i]=0 do
                begin
                        inc(n);
                        a[n]:=nt[i];
                        x:=x div nt[i];
                end;
        until (x=1) or (i=sl);
        if x<>1 then
        begin
                inc(n);
                a[n]:=x;
        end;
end;

function tcs(x:longint):longint;
begin
        tcs:=0;
        repeat
                tcs:=tcs+x mod 10;
                x:=x div 10;
        until x=0;
end;

procedure process;
var     x,i,sum:longint;
begin
        x:=nn;
        repeat
                inc(x);
                sum:=0;
                phantich(x);
                if n>1 then for i:=1 to n do sum:=sum+tcs(a[i]);
                begin
                        if sum=tcs(x) then
                        begin
                                ans:=x;
                                exit;
                        end;
                end;
        until false;
end;

procedure output;
begin
        write(go,ans);
        close(gi);close(go);
end;

begin
        input;
        sangnt;
        process;
        output;
end.























