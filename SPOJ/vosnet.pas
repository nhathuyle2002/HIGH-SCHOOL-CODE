type    edge=record x,y,k:longint;end;

const   ginp='ss.inp';
        gout='ss.out';

var     n,m:longint;
        d,head,res,dd:array[0..3010] of longint;
        e:array[-6010..6010] of edge;

procedure add(i,u,v:longint);
begin
        with e[i] do
        begin
                x:=u;y:=v;
                k:=head[u];
        end;
        head[u]:=i;
end;

procedure enter;
var     i,u,v:longint;
begin
        readln(n,m);
        for i:=1 to m do
        begin
                readln(u,v);
                add(i,u,v);
                add(-i,v,u);
        end;
end;

procedure bfs(s:longint);
var     i,u,v,l,r:longint;
        q:array[0..3010] of longint;
begin
        for i:=1 to n do d[i]:=-1;
        d[s]:=0;l:=0;r:=1;q[1]:=s;
        repeat
                inc(l);u:=q[l];
                i:=head[u];
                while i<>0 do
                begin
                        v:=e[i].y;
                        if d[v]=-1 then
                        begin
                                inc(r);q[r]:=v;
                                d[v]:=d[u]+1;
                        end;
                        i:=e[i].k;
                end;
        until l>=r;
end;

procedure process;
var     tm,cou,u,v,i:longint;
begin
        cou:=1;tm:=2;
        for i:=2 to n do
        begin
                if i>tm then
                begin
                        inc(cou);
                        tm:=tm*2;
                end;
                dd[i]:=cou;
        end;
        for u:=1 to n-1 do
        begin
                bfs(u);
                for v:=u+1 to n do
                        if d[v]>1 then inc(res[dd[d[v]]]);
        end;
        for i:=1 to n do
                if res[i]=0 then break else write(res[i],' ');
        write(0);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        process;
        close(input);close(output);
end.
