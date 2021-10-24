const   ginp='lis.inp';
        gout='lis.out';

var     n,qq,cou,maxb:longint;
        a,b,p,vb,re,q,mg,f,db:array[0..300010] of longint;
        v,d:array[0..600010] of longint;
        ds:array[0..300010] of boolean;

procedure swap(var x,y:longint); inline;
var     tm:longint;
begin
        tm:=x;x:=y;y:=tm;
end;

procedure sorta(l,r:longint);
var     i,j,t:longint;
begin
        if l>=r then exit;
        i:=l;j:=r;
        t:=d[random(r-l+1)+l];
        repeat
                while d[i]<t do inc(i);
                while d[j]>t do dec(j);
                if i<=j then
                begin
                        swap(d[i],d[j]);
                        swap(v[i],v[j]);
                        inc(i);dec(j);
                end;
        until i>j;
        sorta(l,j);sorta(i,r);
end;

procedure sortb(l,r:longint);
var     i,j,t:longint;
begin
        if l>=r then exit;
        i:=l;j:=r;
        t:=p[random(r-l+1)+l];
        repeat
                while p[i]<t do inc(i);
                while p[j]>t do dec(j);
                if i<=j then
                begin
                        swap(p[i],p[j]);
                        swap(b[i],b[j]);
                        swap(vb[i],vb[j]);
                        inc(i);dec(j);
                end;
        until i>j;
        sortb(l,j);sortb(i,r);
end;

procedure enter;
var     i:longint;
begin
        readln(n,qq);
        for i:=1 to n do
        begin
                read(a[i]);
                v[i]:=i;d[i]:=a[i];
        end;
        readln;
        for i:=1 to qq do
        begin
                readln(p[i],b[i]);
                v[i+n]:=i+n;d[i+n]:=b[i];
                vb[i]:=i;
        end;
        sorta(1,n+qq);
        cou:=0;d[0]:=0;
        for i:=1 to n+qq do
        begin
                if d[i]>d[i-1] then inc(cou);
                if v[i]<=n then a[v[i]]:=cou else b[v[i]-n]:=cou;
        end;
        sortb(1,qq);
end;

function max(x,y:longint):longint;
begin
        if x>y then exit(x) else exit(y);
end;

function quece(i:longint):longint;
begin
        if i<1 then exit(0);
        quece:=max(q[i],quece(i-i and (-i)));
end;

procedure update(i,x:longint);
begin
        if i>cou then exit;
        q[i]:=max(q[i],x);
        update(i+i and (-i),x);
end;

procedure process;
var     i,l:longint;
begin
        fillchar(q,sizeof(q),0);
        maxb:=0;
        l:=1;
        for i:=1 to n do
        begin
                while (l<=qq) and (p[l]=i) do
                begin
                        re[vb[l]]:=quece(b[l]-1)+1;
                        inc(l);
                end;
                f[i]:=quece(a[i]-1)+1;
                maxb:=max(maxb,f[i]);
                update(a[i],f[i]);
        end;
        fillchar(q,sizeof(q),0);
        l:=qq;
        for i:=n downto 1 do
        begin
                while (l>=1) and (p[l]=i) do
                begin
                        re[vb[l]]:=re[vb[l]]+quece(cou-b[l]);
                        dec(l);
                end;
                update(cou-a[i]+1,quece(cou-a[i])+1);
        end;
        fillchar(mg,sizeof(mg),0);
        fillchar(db,sizeof(db),0);
        fillchar(ds,sizeof(ds),false);
        for i:=n downto 1 do
                if f[i]=maxb then
                begin
                        inc(db[maxb]);
                        ds[i]:=true;
                        mg[maxb]:=max(mg[maxb],a[i]);
                end else
                if a[i]<mg[f[i]+1] then
                begin
                        inc(db[f[i]]);
                        ds[i]:=true;
                        mg[f[i]]:=max(mg[f[i]],a[i]);
                end;
        for i:=1 to qq do
                if (ds[p[i]]) and (db[f[p[i]]]=1) then re[vb[i]]:=max(re[vb[i]],maxb-1)
                else re[vb[i]]:=max(re[vb[i]],maxb);
        for i:=1 to qq do writeln(re[i]);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        process;
        close(input);close(output);
end.
