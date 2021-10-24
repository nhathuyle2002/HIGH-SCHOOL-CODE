const   ginp='tunnel.inp';
        gout='tunnel.out';

var     gi,go:text;
        n,m,s,t:longint;
        x,y,w,h,link:array[-100001..100001] of longint;
        fh,fd:array[0..111] of int64;
        head:array[0..111] of longint;

procedure ad(i,u,v,c,cc:longint);
begin
        x[i]:=u;y[i]:=v;
        h[i]:=c;w[i]:=cc;
        link[i]:=head[u];
        head[u]:=i;
end;

procedure input;
var     i,u,v,c,cc:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n,s,t);
        readln(gi,m);
        for i:=1 to m do
        begin
                readln(gi,u,v,c,cc);
                ad(i,u,v,c,cc);
                ad(-i,v,u,c,cc);
        end;
end;

function max(xx,yy:int64):int64;
begin
        if xx>yy then exit(xx) else exit(yy);
end;

function min(xx,yy:int64):int64;
begin
        if xx<yy then exit(xx) else exit(yy);
end;

procedure dijkstra;
var     i,v,u:longint;
        put:array[0..111] of boolean;
begin
        fillchar(put,sizeof(put),true);
        for i:=0 to n do fd[i]:=maxlongint;
        fd[s]:=0;fh[s]:=maxlongint;
        repeat
                u:=0;
                for i:=1 to n do
                        if (put[i]) and (fh[i]>fh[u]) then u:=i;
                if (u=0) then exit;
                put[u]:=false;
                i:=head[u];
                while i<>0 do
                begin
                        v:=y[i];
                        if put[v] then
                        begin
                                if min(fh[u],h[i])>fh[v] then
                                begin
                                        fh[v]:=min(fh[u],h[i]);
                                        fd[v]:=fd[u]+w[i];
                                end
                                else if min(fh[u],h[i])=fh[v] then
                                        if fd[v]>fd[u]+w[i] then fd[v]:=fd[u]+w[i];
                        end;
                        i:=link[i];
                end;
        until false;
end;

procedure output;
var     i,nn,v,u,vtm:longint;
        gm,hmax:int64;
        ou:array[0..111] of longint;
        put:array[0..111] of boolean;
begin
        nn:=1;ou[1]:=t;
        fillchar(put,sizeof(put),true);
        u:=t;hmax:=fh[t];
        while u<>s do
        begin
                put[u]:=false;
                gm:=maxlongint;
                i:=head[u];
                while i<>0 do
                begin
                        v:=y[i];
                        if put[v] then
                                if (hmax<=min(fh[v],h[i])) and (fd[v]+w[i]<=gm) then
                                begin
                                        vtm:=v;
                                        gm:=fd[v]+w[i];
                                end;
                        i:=link[i];
                end;
                u:=vtm;
                inc(nn);
                ou[nn]:=u;
        end;
        writeln(go,nn);
        for i:=nn downto 1 do write(go,ou[i],' ');
        close(gi);close(go);
end;

begin
        input;
        dijkstra;
        output;
end.








