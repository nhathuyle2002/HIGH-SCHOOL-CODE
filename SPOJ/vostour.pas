const   ginp='ss.inp';
        gout='ss.out';
        maxch=1 shl 8-1;
        oo=trunc(1e7);

type    edge=record x,y,link:longint;end;

var     n,m,sl,mch,res:longint;
        e:array[0..100010] of edge;
        head,dd:array[0..5010] of longint;
        d:array[0..10,0..10] of longint;
        f:array[0..10,0..maxch] of longint;

procedure enter;
var     i:longint;
begin
        readln(n,sl,m);
        for i:=1 to m do
        begin
                readln(e[i].x,e[i].y);
                e[i].link:=head[e[i].x];
                head[e[i].x]:=i;
        end;
end;

procedure bfs(s:longint);
var     i,u,v,l,r:longint;
        q:array[0..5010] of longint;
begin
        for i:=0 to n-1 do dd[i]:=-1;
        l:=0;r:=1;q[1]:=s;dd[s]:=0;
        repeat
                inc(l);u:=q[l];
                i:=head[u];
                while i<>0 do
                begin
                        v:=e[i].y;
                        if dd[e[i].y]=-1 then
                        begin
                                inc(r);q[r]:=v;
                                dd[v]:=dd[u]+1;
                        end;
                        i:=e[i].link;
                end;
        until l>=r;
end;

function min(x,y:longint):longint;
begin
        if x<y then exit(x) else exit(y);
end;

function getb(x,i:longint):longint;
begin
        getb:=(x shr (i-1)) and 1;
end;

function setb(i,x,tt:longint):longint;
begin
        if tt=1 then setb:=x or (1 shl (i-1))
        else setb:=x and (not (1 shl (i-1)));
end;

procedure process;
var     u,v,i,k,cou,kk:longint;
begin
        for u:=0 to sl-1 do
        begin
                bfs(u);
                for v:=0 to sl-1 do
                        if dd[v]<>-1 then d[u,v]:=dd[v] else d[u,v]:=oo;
        end;
        mch:=1 shl (sl-1)-1;
        for i:=1 to mch do
        begin
                cou:=0;
                for k:=1 to sl-1 do
                        if getb(i,k)=1 then inc(cou);
                if cou=1 then
                begin
                for k:=1 to sl-1 do
                        if getb(i,k)=1 then f[k,i]:=d[0,k];
                end else
                for k:=1 to sl-1 do
                if getb(i,k)=1 then
                begin
                        u:=setb(k,i,0);
                        f[k,i]:=oo;
                        for kk:=1 to sl-1 do
                                if getb(u,kk)=1 then f[k,i]:=min(f[k,i],f[kk,u]+d[kk,k]);
                end;
        end;
        res:=oo;
        for k:=1 to sl-1 do
                res:=min(res,f[k,mch]+d[k,0]);
        write(res);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        process;
        close(input);close(output);
end.
