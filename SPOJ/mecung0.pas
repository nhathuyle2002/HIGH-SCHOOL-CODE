const   ginp='ss.inp';
        gout='ss.out';

var     gi,go:text;
        n,m,k:longint;
        link,x,y,w:array[-200100..200100] of longint;
        head,ou:array[0..100100] of longint;
        d:array[1..2,0..100100] of longint;

procedure add(i,u,v,c:longint);
begin
        x[i]:=u;y[i]:=v;w[i]:=c;
        link[i]:=head[x[i]];
        head[x[i]]:=i;
end;

procedure input;
var     i,u,v,c:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n,m);
        for i:=1 to m do
        begin
                readln(gi,u,v,c);
                add(i,u,v,c);
                add(-i,v,u,c);
        end;
end;

procedure bfs(s,f:longint;var dd:array of longint);
var     l,r,u,v,i:longint;
        q:array[0..100100] of longint;
begin
        for i:=1 to n do dd[i]:=-1;
        dd[s]:=0;q[1]:=s;
        l:=0;r:=1;
        repeat
                inc(l);u:=q[l];
                i:=head[u];
                while i<>0 do
                begin
                        v:=y[i];
                        if dd[v]=-1 then
                        begin
                                inc(r);
                                q[r]:=v;
                                dd[v]:=dd[u]+1;
                        end;
                        i:=link[i];
                end;
        until (l>=r) or (dd[f]<>-1);
end;

procedure process;
var     i:longint;
begin
        bfs(1,n,d[1]);
        bfs(n,1,d[2]);
end;

function min(xx,yy:longint):longint;
begin
        if xx<yy then exit(xx) else exit(yy);
end;

procedure solve;
var     i,gmin,l,r,u,v,l0,sb:longint;
        q,g:array[0..100100] of longint;
        dd,ok:array[0..100100] of boolean;
begin
        fillchar(ok,sizeof(ok),false);
        for i:=1 to n do
                if (d[1,i]<>-1) and (d[2,i]<>-1) then
                        if d[1,i]+d[2,i]=d[1,n] then ok[i]:=true;
        l:=0;r:=1;sb:=0;l0:=0;
        q[1]:=1;gmin:=maxlongint;
        for i:=1 to n do g[i]:=maxlongint;
        fillchar(dd,sizeof(dd),true);dd[1]:=false;
        repeat
                inc(sb);l0:=r;
                repeat
                        inc(l);u:=q[l];
                        if g[u]=gmin then
                        begin
                                i:=head[u];
                                while i<>0 do
                                begin
                                        v:=y[i];
                                        if (ok[v]) and (d[1,v]=sb) and (dd[v]) then
                                        begin
                                                inc(r);
                                                q[r]:=v;
                                                g[v]:=w[i];
                                                dd[v]:=false;
                                        end else
                                        if (ok[v]) and (d[1,v]=sb) and (dd[v]=false) then
                                                g[v]:=min(g[v],w[i]);
                                        i:=link[i];
                                end;
                        end;
                until l>=l0;
                gmin:=maxlongint;
                for i:=l0+1 to r do gmin:=min(gmin,g[q[i]]);
                ou[sb]:=gmin;
        until (l>=r) or (dd[n]=false);
end;

procedure output;
var     i:longint;
begin
        writeln(go,d[1,n]);
        for i:=1 to d[1,n] do write(go,ou[i],' ');
        close(gi);close(go);
end;

begin
        input;
        process;
        solve;
        output;
end.





