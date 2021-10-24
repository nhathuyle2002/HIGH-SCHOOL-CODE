const   ginp='ford.inp';
        gout='ford.out';

var     gi,go:text;
        n,m,s,t:longint;
        y,w,link:array[0..100011] of longint;
        head:array[0..1001] of longint;
        d:array[0..10011] of int64;

procedure ad(i,u,v,c:longint);
begin
        y[i]:=v;
        link[i]:=head[u];
        head[u]:=i;
        w[i]:=c;
        if u=s then d[v]:=c;
end;

procedure input;
var     i,u,v,c:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n,m,s,t);
        for i:=1 to n do d[i]:=maxlongint;
        for i:=1 to n do
        begin
                readln(gi,u,v,c);
                ad(i,u,v,c);
        end;
end;

procedure fordbellman;
var     cou,u,v,i:longint;
        stop:boolean;
begin
        d[s]:=0;
        cou:=0;
        repeat
                inc(cou);stop:=true;
                for u:=1 to n do
                begin
                        i:=head[u];
                        while i<>0 do
                        begin
                                v:=y[i];
                                if d[v]>d[u]+w[i] then
                                begin
                                        stop:=false;
                                        d[v]:=d[u]+w[i];
                                end;
                                i:=link[i];
                        end;
                end;
        until (cou>=n-2) or (stop);
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



