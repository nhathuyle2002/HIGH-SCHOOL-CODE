const   ginp='seqgame.inp';
        gout='seqgame.out';

var     gi,go:text;
        n,m,k,s:longint;
        a,b:array[0..1000001] of int64;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,m,n,k);
        for i:=1 to m do read(gi,a[i]);
        readln(gi);
        for i:=1 to n do read(gi,b[i]);
        readln(gi);
end;

procedure sort(l,r:longint;var d:array of int64);
var     i,j:longint;
        x,tm:int64;
begin
        if l>=r then exit;
        i:=l;j:=r;
        x:=d[random(r-l+1)+l];
        repeat
                while d[i]<x do inc(i);
                while d[j]>x do dec(j);
                if i<=j then
                begin
                        tm:=d[i];
                        d[i]:=d[j];
                        d[j]:=tm;
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j,d);sort(i,r,d);
end;

function min(x,y:int64):int64;
begin
        if x<y then exit(x) else exit(y);
end;

function abs(x:int64):int64;
begin
        if x>=0 then exit(x) else exit(-x);
end;

procedure output;
var     i,t,j:longint;
        tm,ans:int64;
begin
        sort(1,m,a);sort(1,n,b);
        b[0]:=-100000000000000;b[n+1]:=1000000000000000;
        for t:=1 to k do
        begin
                ans:=1000000000000000;
                read(gi,s);
                j:=0;
                for i:=m downto 1 do
                begin
                        while (a[i]+b[j+1]<s) and (j<n) do inc(j);
                        tm:=min(abs(s-a[i]-b[j]),abs(s-a[i]-b[j+1]));
                        ans:=min(ans,tm);
                end;
                writeln(go,ans);
        end;
        close(gi);close(go);
end;

begin
        input;
        output;
end.









