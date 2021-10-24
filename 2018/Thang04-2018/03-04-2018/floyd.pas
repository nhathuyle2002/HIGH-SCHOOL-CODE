const   ginp='floyd.inp';
        gout='floyd.out';

var     gi,go:text;
        n,m,q:longint;
        f,t:array[0..1010,0..1010] of int64;

procedure input;
var     i,j,u,v,c:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n,m,q);
        for i:=1 to n do
                for j:=1 to n do
                        if i<>j then f[i,j]:=maxlongint;
        for i:=1 to m do
        begin
                readln(gi,u,v,c);
                f[u,v]:=c;t[u,v]:=v;
                f[v,u]:=c;t[v,u]:=u;
        end;
end;

procedure floyd;
var     i,j,k:longint;
begin
        for k:=1 to n do
                for i:=1 to n do
                        for j:=1 to n do
                                if f[i,j]>f[i,k]+f[k,j] then
                                begin
                                        f[i,j]:=f[i,k]+f[k,j];
                                        t[i,j]:=t[i,k];
                                end;
end;

procedure sort(l,r:longint;var d:array of longint);
var     i,j,tm,t:longint;
begin
        if l>=r then exit;
        i:=l;j:=r;
        tm:=d[random(r-l+1)+l];
        repeat
                while d[i]<tm do inc(i);
                while d[j]>tm do dec(j);
                if i<=j then
                begin
                        t:=d[i];d[i]:=d[j];d[j]:=t;
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j,d);sort(i,r,d);
end;

procedure output;
var     i,u,v,cs,sp:longint;
        xu:array[0..1010] of longint;
begin
        for i:=1 to q do
        begin
                readln(gi,cs,u,v);
                if cs=0 then writeln(go,f[u,v]) else
                begin
                        sp:=1;xu[sp]:=u;
                        repeat
                                u:=t[u,v];
                                inc(sp);
                                xu[sp]:=u;
                        until u=v;
                        write(go,sp,' ');
                        sort(1,sp,xu);
                        for v:=1 to sp do write(go,xu[v],' ');
                        writeln(go);
                end;
        end;
        close(gi);close(go);
end;

begin
        input;
        floyd;
        output;
end.
