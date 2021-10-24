const   ginp='salary.inp';
        gout='salary.out';
        maxn=300010;
        mlog=19;

var     n,cou:longint;
        a,link,head,vl,vr:array[0..maxn] of longint;
        pa:array[0..maxn,0..mlog] of longint;
        f:array[0..4*maxn] of longint;

procedure enter;
var     i,u:longint;
begin
        readln(n);
        inc(n);
        readln(a[1]);
        for i:=2 to n do
        begin
                readln(a[i],u);
                link[i]:=head[u+1];
                head[u+1]:=i;
                pa[i,0]:=u+1;
        end;
end;

procedure dfs(u:longint);
var     v,k:longint;
begin
        for k:=1 to mlog do pa[u,k]:=pa[pa[u,k-1],k-1];
        inc(cou);vl[u]:=cou;vr[u]:=cou;
        v:=head[u];
        while v<>0 do
        begin
                dfs(v);
                vr[u]:=vr[v];
                v:=link[v];
        end;
end;

function max(x,y:longint):longint;
begin
        if x>y then exit(x) else exit(y);
end;

procedure update(id,l,r,v,x:longint);
var     m:longint;
begin
        if (v<l) or (v>r) then exit;
        if (l=v) and (v=r) then
        begin
                f[id]:=x;
                exit;
        end;
        m:=(l+r) shr 1;
        update(id*2,l,m,v,x);
        update(id*2+1,m+1,r,v,x);
        f[id]:=max(f[id*2],f[id*2+1]);
end;

function quece(id,l,r,d,c:longint):longint;
var     m:longint;
begin
        if (l>c) or (r<d) then exit(0);
        if (d<=l) and (r<=c) then exit(f[id]);
        m:=(l+r) shr 1;
        quece:=max(quece(id*2,l,m,d,c),quece(id*2+1,m+1,r,d,c));
end;

procedure process;
var     i,k,res,p:longint;
begin
        dfs(1);
        update(1,1,cou,vl[1],a[1]);
        for i:=2 to n do
        begin
                res:=0;p:=i;
                for k:=mlog downto 0 do
                        if (pa[p,k]<>0) and (quece(1,1,cou,vl[pa[p,k]],vr[pa[p,k]])<a[i]) then
                        begin
                                res:=res+1 shl k;
                                p:=pa[p,k];
                        end;
                writeln(res);
                update(1,1,cou,vl[i],a[i]);
        end;
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        process;
        close(input);close(output);
end.
