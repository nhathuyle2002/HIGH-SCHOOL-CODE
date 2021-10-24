const   ginp='lamps.inp';
        gout='lamps.out';
        maxbit=1 shl 21-1;

var     gi,go:text;
        n,t,maxb,l,r:longint;
        q,d,ou:array[0..maxbit] of longint;
        link,y:array[-21..21] of longint;
        head:array[0..21] of longint;
        a:array[0..21,0..21] of longint;

procedure add(i,u,v:longint);
begin
        y[i]:=v;link[i]:=head[u];
        head[u]:=i;
end;

procedure input;
var     i,j,u,v:longint;
begin
        readln(gi,n,t);
        maxb:=1 shl n-1;
        for i:=1 to n do
        begin
                readln(gi,u,v);
                add(i,u,v);
                add(-i,v,u);
        end;
        for i:=1 to t do
        begin
                for j:=1 to n do read(gi,a[i,j]);
                readln(gi);
        end;
end;

procedure push(v,u,x:longint);
begin
        d[v]:=u;ou[v]:=x;
        inc(r);q[r]:=v;
end;

procedure db(i:longint;var x:longint);
var     t:longint;
begin
        t:=(x shr (i-1)) and 1;
        if t=0 then x:=x or (1 shl (i-1))
        else x:=x and (not (1 shl (i-1)));
end;

procedure bfs(s:longint);
var     i,v,u,vt,x:longint;
begin
        for i:=0 to maxb do d[i]:=-2;
        l:=0;r:=0;push(s,-1,0);
        repeat
                inc(l);u:=q[l];
                for vt:=1 to n do
                begin
                        x:=u;i:=head[vt];
                        db(vt,x);
                        while i<>0 do
                        begin
                                v:=y[i];
                                db(v,x);
                                i:=link[i];
                        end;
                        if d[x]=-2 then push(x,u,vt);
                        if d[maxb]<>-2 then exit;
                end;
        until l>=r;
end;

procedure process;
var     i,j,s,cou:longint;
        wri:array[0..maxbit] of longint;
begin
        for i:=1 to t do
        begin
                s:=0;
                for j:=1 to n do
                        if a[i,j]=1 then
                                s:=s+1 shl (j-1);
                bfs(s);
                s:=maxb;cou:=0;
                while d[s]<>-1 do
                begin
                        inc(cou);
                        wri[cou]:=ou[s];
                        s:=d[s];
                end;
                write(go,cou,' ');
                for j:=1 to cou do write(go,wri[j],' ');
                writeln(go);
        end;
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        input;
        process;
        close(gi);close(go);
end.