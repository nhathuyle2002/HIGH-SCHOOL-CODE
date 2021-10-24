const   ginp='ford.inp';
        gout='ford.out';

var     gi,go:text;
        n,m,s,t:longint;
        y,w,link:array[0..10001001] of longint;
        head:array[0..100100] of longint;
        d:array[0..1001001] of int64;

procedure ad(i,u,v,c:longint);
begin
        y[i]:=v;
        link[i]:=head[u];
        head[u]:=i;
        w[i]:=c;
end;

procedure input;
var     i,u,v,c:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n,m,s,t);
        for i:=1 to n do
        begin
                readln(gi,u,v,c);
                ad(i,u,v,c);
        end;
end;

procedure fordbellman;
var     u,v,i:longint;
        put:array[0..100100] of boolean;
begin
        for i:=0 to n do d[i]:=maxlongint;
        fillchar(put,sizeof(put),true);
        d[s]:=0;
        repeat
                u:=0;
                for i:=1 to n do
                        if (put[i]) and (d[i]<d[u]) then u:=i;
                if (u=0) then exit;
                put[u]:=false;
                i:=head[u];
                while i<>0 do
                begin
                        v:=y[i];
                        if (d[v]>d[u]+w[i]) and (put[v]) then d[v]:=d[u]+w[i];
                        i:=link[i];
                end;
        until false;
end;

procedure output;
begin
        if d[t]=maxlongint then write(go,'NO') else
        begin
                writeln(go,'YES');
                write(go,d[t]);
        end;
        close(gi);close(go);
end;

begin
        input;
        fordbellman;
        output;
end.



