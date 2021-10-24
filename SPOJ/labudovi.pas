const   ginp='ss.inp';
        gout='ss.out';
        maxn=1501;
        di:array[1..4] of longint= (-1,1,0,0);
        dj:array[1..4] of longint= (0,0,-1,1);

var     gi,go:text;
        m,n,ans,l,r,cou,sm:longint;
        xx,yy:array[0..maxn*maxn] of longint;
        a:array[0..maxn] of ansistring;
        d,dd:array[0..maxn,0..maxn] of longint;
        qi,qj:array[0..maxn*maxn] of longint;
        x,y,link,w:array[-maxn*maxn..maxn*maxn] of longint;
        head,h,vt:array[0..maxn*maxn] of longint;
        f:array[0..maxn*maxn] of longint;
        nh:longint;

procedure input;
var     i,j:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,m,n);
        for i:=1 to m do readln(gi,a[i]);
        cou:=0;
        for i:=1 to m do
                for j:=1 to n do
                        if a[i,j]='L' then
                        begin
                                inc(cou);
                                xx[cou]:=i;yy[cou]:=j;
                        end;
        for i:=1 to m do
                for j:=1 to n do
                        if a[i,j]='.' then
                        begin
                                inc(cou);
                                xx[cou]:=i;yy[cou]:=j;
                        end;
end;

function cdt(i,j,gt:longint):longint;
begin
        if (i<1) or (j<1) or (i>m) or (j>n) then exit(0);
        if d[i,j]=gt then exit(0);
        exit(1);
end;

procedure push(i,j,gt:longint);
begin
        inc(r);
        qi[r]:=i;qj[r]:=j;
        d[i,j]:=gt;
end;

procedure dfs0(i,j,gt:longint);
var     k,i0,j0:longint;
begin
        for k:=1 to 4 do
        begin
                i0:=i+di[k];
                j0:=j+dj[k];
                if (cdt(i0,j0,gt)=1) and (a[i0,j0]<>'X') then
                begin
                        push(i0,j0,gt);
                        dfs0(i0,j0,gt);
                end;
        end;
end;

procedure add(i,u,v,c:longint);
begin
        x[i]:=u;y[i]:=v;w[i]:=c;
        link[i]:=head[u];
        head[u]:=i;
end;

function max(aa,bb:longint):longint;
begin
        if aa>bb then exit(aa) else exit(bb);
end;

procedure dfs(i,j,gt,tt,sn:longint);
var     i0,j0,k,tm:longint;
begin
        for k:=1 to 4 do
        begin
                i0:=i+di[k];
                j0:=j+dj[k];
                if cdt(i0,j0,gt)=1 then
                begin
                        if (d[i0,j0]=0) and (a[i0,j0]<>'X') then
                        begin
                                push(i0,j0,gt);
                                dd[i0,j0]:=sn+1;
                                dfs(i0,j0,gt,tt,sn);
                        end else
                        if (d[i0,j0]=0) and (tt=1) and (a[i0,j0]='X') then
                        begin
                                push(i0,j0,gt);
                                dd[i0,j0]:=sn+1;
                                dfs(i0,j0,gt,tt+1,sn);
                        end else
                        if (d[i0,j0]<>0) then
                        begin
                                inc(sm);
                                add(sm,d[i,j],d[i0,j0],max(sn,dd[i0,j0]));
                                add(-sm,d[i0,j0],d[i,j],max(sn,dd[i0,j0]));
                        end;
                end;
        end;
end;

procedure swap(var aa,bb:longint);
var     tm:longint;
begin
        tm:=aa;aa:=bb;bb:=tm;
end;

procedure uph(i:longint);
var     j:longint;
begin
        if i<=1 then exit;
        j:=i div 2;
        if f[h[i]]<f[h[j]] then
        begin
                swap(h[i],h[j]);
                swap(vt[h[i]],vt[h[j]]);
                uph(j);
        end;
end;

procedure downh(i:longint);
var     j:longint;
begin
        j:=i*2;
        if j>nh then exit;
        if (j<nh) and (f[h[j]]>f[h[j+1]]) then inc(j);
        if f[h[i]]>f[h[j]] then
        begin
                swap(h[i],h[j]);
                swap(vt[h[i]],vt[h[j]]);
                downh(j);
        end;
end;

function pop:longint;
begin
        pop:=h[1];
        swap(h[1],h[nh]);
        swap(vt[h[1]],vt[h[nh]]);
        dec(nh);
        downh(1);
end;

procedure update(i:longint);
begin
        if vt[i]=0 then
        begin
                inc(nh);
                h[nh]:=i;
                vt[i]:=nh;
        end;
        uph(vt[i]);
end;

procedure dijkstra;
var     i,u,v:longint;
        put:array[0..maxn*maxn] of boolean;
begin
        fillchar(put,sizeof(put),true);
        for i:=0 to maxn*maxn do f[i]:=trunc(1e9);
        f[1]:=0;update(1);
        repeat
                u:=pop;
                if u=2 then break;
                put[u]:=false;
                i:=head[u];
                while i<>0 do
                begin
                        v:=y[i];
                        if (put[v]) and (f[u]+w[i]<f[v]) then
                        begin
                                f[v]:=f[u]+w[i];
                                update(v);
                        end;
                        i:=link[i];
                end;
        until false;
        ans:=f[2];
end;

procedure process;
var     i,j,r0:longint;
begin
        fillchar(d,sizeof(d),0);
        fillchar(dd,sizeof(dd),0);
        l:=0;r:=0;ans:=0;
        for i:=1 to cou do
                if d[xx[i],yy[i]]=0 then
                begin
                        push(xx[i],yy[i],i);
                        dfs0(xx[i],yy[i],i);
                end;
        if d[xx[2],yy[2]]=1 then exit;
        repeat
                inc(ans);
                r0:=r;
                while l<=r0 do
                begin
                        dfs(qi[l],qj[l],d[qi[l],qj[l]],1,dd[qi[l],qj[l]]);
                        inc(l);
                end;
        until l>r;
        dijkstra;
end;

procedure output;
begin
        write(go,ans);
        close(gi);close(go);
end;

begin
        input;
        process;
        output;
end.
