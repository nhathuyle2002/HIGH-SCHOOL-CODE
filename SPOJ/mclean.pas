const   ginp='ss.inp';
        gout='ss.out';
        di:array[1..4] of longint =(-1,1,0,0);
        dj:array[1..4] of longint =(0,0,-1,1);
        oo=trunc(1e5);

type    toado=record i,j:longint;end;

var     gi,go:text;
        m,n,k,r,l,res:longint;
        a:array[0..21] of string;
        b:array[0..11] of toado;
        d:array[0..21,0..21] of longint;
        c:array[0..11,0..11] of longint;
        q:array[0..410] of toado;
        f:array[0..11,0..1 shl 10] of longint;

procedure input;
var     i,j:longint;
begin
        for i:=1 to m do
        begin
                readln(gi,a[i]);
                for j:=1 to n do
                        if a[i,j]='o' then
                        begin
                                b[0].i:=i;
                                b[0].j:=j;
                        end;
        end;
        k:=0;
        for i:=1 to m do
                for j:=1 to n do
                        if a[i,j]='*' then
                        begin
                                inc(k);
                                b[k].i:=i;
                                b[k].j:=j;
                        end;
end;

procedure push(u:toado;x:longint);
begin
        inc(r);
        q[r].i:=u.i;
        q[r].j:=u.j;
        d[u.i,u.j]:=x;
end;

function cdt(i,j:longint):boolean;
begin
        if (i<1) or (j<1) or (i>m) or (j>n) then exit(false);
        if (d[i,j]<>0) or (a[i,j]='x') then exit(false);
        exit(true);
end;

procedure bfs(vt:longint);
var     p,i,j:longint;
        v,u:toado;
begin
        for i:=1 to m do
                for j:=1 to n do d[i,j]:=0;
        l:=0;r:=0;
        push(b[vt],1);
        repeat
                inc(l);u:=q[l];
                for p:=1 to 4 do
                begin
                        v.i:=u.i+di[p];
                        v.j:=u.j+dj[p];
                        if cdt(v.i,v.j) then push(v,d[u.i,u.j]+1);
                end;
        until l>=r;
        for p:=0 to k do
        begin
                c[vt,p]:=d[b[p].i,b[p].j]-1;
                if c[vt,p]<0 then c[vt,p]:=oo;
        end;
end;

function get(i,x:longint):longint;
begin
        get:=(x shr (i-1)) and 1;
end;

function setb(t,i,x:longint):longint;
begin
        if t=1 then setb:=x or (1 shl (i-1))
        else setb:=x xor (1 shl (i-1));
end;

function min(x,y:longint):longint;
begin
        if x<y then exit(x) else exit(y);
end;

procedure process;
var     i,j,u,p:longint;
begin
        for i:=0 to k do bfs(i);
        for j:=1 to 1 shl k-1 do
                for i:=1 to k do
                if get(i,j)=1 then
                begin
                        u:=setb(0,i,j);
                        if u=0 then f[i,j]:=c[0,i] else
                        begin
                                f[i,j]:=oo;
                                for p:=1 to k do
                                if get(p,u)=1 then f[i,j]:=min(f[i,j],f[p,u]+c[p,i]);
                        end;
                end;
        res:=oo;
        for i:=1 to k do
                res:=min(res,f[i,1 shl k-1]);
end;

begin
        assign(gi,ginp);reset(gi);
        assign(go,gout);rewrite(go);
        repeat
                readln(gi,n,m);
                if (m=0) and (n=0) then break;
                input;
                process;
                if res=oo then writeln(go,-1) else writeln(go,res);
        until false;
        close(gi);close(go);
end.
