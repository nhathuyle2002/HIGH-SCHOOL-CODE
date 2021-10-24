const   ginp='frog.inp';
        gout='frog.out';

var     gi,go:text;
        m,n,k:longint;
        d:array[0..100010] of longint;

procedure sort(l,r:longint);
var     i,j,t,tm:longint;
begin
        if l>=r then exit;
        i:=l;j:=r;
        t:=d[random(r-l+1)+l];
        repeat
                while d[i]>t do inc(i);
                while d[j]<t do dec(j);
                if i<=j then
                begin
                        tm:=d[i];d[i]:=d[j];d[j]:=tm;
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j);sort(i,r);
end;

procedure main;
var     i,j,x,res:longint;
begin
        readln(gi,m,n,k);
        for i:=1 to m do
        begin
                for j:=1 to n do
                begin
                        read(gi,x);inc(d[x]);
                end;
                readln(gi);
        end;
        sort(1,100010);
        if k>100010 then k:=100010;
        res:=0;
        for i:=1 to k do inc(res,d[i]);
        write(go,res);
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        main;
        close(gi);close(go);
end.