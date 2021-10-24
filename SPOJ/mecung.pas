const   ginp='ss.inp';
        gout='ss.out';

var     gi,go:text;
        n,m,k:longint;
        link,x,y,w:array[-200100..200100] of longint;
        head,ou:array[0..100100] of longint;
        d:array[1..2,0..100100] of longint;
        ok:array[0..100100] of boolean;

procedure add(i:longint);
begin
        link[i]:=head[x[i]];
        head[x[i]]:=i;
end;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n,m);
        for i:=1 to m do readln(gi,x[i],y[i],w[i]);
end;

procedure swap(var xx,yy:longint);
var     tm:longint;
begin
        tm:=xx;xx:=yy;yy:=tm;
end;

procedure sort(l,r:longint);
var     i,j,t:longint;
begin
        if l>=r then exit;
        i:=l;j:=r;
        t:=w[random(r-l+1)+l];
        repeat
                while w[i]<t do inc(i);
                while w[j]>t do dec(j);
                if i<=j then
                begin
                        swap(x[i],x[j]);
                        swap(y[i],y[j]);
                        swap(w[i],w[j]);
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j);sort(i,r);
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
        sort(1,m);
        for i:=m downto 1 do
        begin
                add(i);
                x[-i]:=y[i];
                y[-i]:=x[i];
                w[-i]:=w[i];
                add(-i);
        end;
        bfs(1,n,d[1]);
        bfs(n,1,d[2]);
end;

procedure solve;
var     i,gmin,l,r,u,v,l0,sb:longint;
        q,g:array[0..100100] of longint;
        dd:array[0..100100] of boolean;
begin
        fillchar(ok,sizeof(ok),false);
        for i:=1 to n do
                if (d[1,i]<>-1) and (d[2,i]<>-1) then
                        if d[1,i]+d[2,i]=d[1,n] then ok[i]:=true;
        fillchar(g,sizeof(g),0);
        sb:=0;
        q[1]:=1;l:=0;r:=1;
        fillchar(dd,sizeof(dd),true);dd[1]:=false;
        gmin:=0;
        repeat
                l0:=r;inc(sb);
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
                                        end;
                                        i:=link[i];
                                end;
                        end;
                until l>=l0;
                gmin:=maxlongint;
                for i:=l0+1 to r do
                        if g[q[i]]<gmin then gmin:=g[q[i]];
                ou[sb]:=gmin;
        until l>=r;
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





