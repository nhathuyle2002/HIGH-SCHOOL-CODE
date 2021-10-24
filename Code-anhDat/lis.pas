const   ginp='lis.inp';
        gout='lis.out';

var     n,q,top:longint;
        a,b,p,d,v,f,re,db,mb:array[0..300010] of longint;
        ds:array[0..300010] of boolean;

procedure swap(var x,y:longint); inline;
var     tm:longint;
begin
        tm:=x;x:=y;y:=tm;
end;

procedure sort(l,r:longint);
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
                        swap(v[i],v[j]);
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j);sort(i,r);
end;

procedure enter;
var     i:longint;
begin
        readln(n,q);
        for i:=1 to n do read(a[i]);readln;
        for i:=1 to q do
        begin
                readln(p[i],b[i]);
                v[i]:=i;
        end;
        sort(1,q);
end;

function cnp1(x:longint):longint;
var     l,r,m:longint;
begin
        if x>d[top] then exit(top+1);
        l:=1;r:=top;
        while l<r do
        begin
                m:=(l+r) shr 1;
                if d[m]<x then l:=m+1 else r:=m;
        end;
        cnp1:=l;
end;

function cnp2(x:longint):longint;
var     l,r,m:longint;
begin
        if x<d[top] then exit(top+1);
        l:=1;r:=top;
        while l<r do
        begin
                m:=(l+r) shr 1;
                if d[m]>x then l:=m+1 else r:=m;
        end;
        cnp2:=l;
end;

function max(x,y:longint):longint;
begin
        if x>y then exit(x) else exit(y);
end;

procedure process;
var     i,ii,vv:longint;
begin
        top:=0;d[0]:=0;
        ii:=1;
        for i:=1 to n do
        begin
                while (ii<=q) and (p[ii]=i) do
                begin
                        re[v[ii]]:=cnp1(b[ii]);
                        inc(ii);
                end;
                if a[i]>d[top] then
                begin
                        inc(top);
                        d[top]:=a[i];
                        f[i]:=top;
                end else
                begin
                        vv:=cnp1(a[i]);
                        if a[i]<d[vv] then d[vv]:=a[i];
                        f[i]:=vv;
                end;
        end;
        top:=0;d[0]:=trunc(1e9)+100;
        ii:=q;
        for i:=n downto 1 do
        begin
                while (ii>=1) and (p[ii]=i) do
                begin
                        re[v[ii]]:=re[v[ii]]+cnp2(b[ii]);
                        dec(ii);
                end;
                if a[i]<d[top] then
                begin
                        inc(top);
                        d[top]:=a[i];
                end else
                begin
                        vv:=cnp2(a[i]);
                        if a[i]>d[vv] then d[vv]:=a[i];
                end;
        end;
        fillchar(ds,sizeof(ds),false);
        for i:=n downto 1 do
                if f[i]=top then
                begin
                        ds[i]:=true;
                        inc(db[top]);
                        mb[top]:=max(mb[top],a[i]);
                end else
                if a[i]<mb[f[i]+1] then
                begin
                        ds[i]:=true;
                        inc(db[f[i]]);
                        mb[f[i]]:=max(mb[f[i]],a[i]);
                end;
        for i:=1 to q do
                if (ds[p[i]]=false) or (db[f[p[i]]]>1) then re[v[i]]:=max(re[v[i]]-1,top)
                else re[v[i]]:=max(re[v[i]]-1,top-1);
        for i:=1 to q do writeln(re[i]);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        process;
        close(input);close(output);
end.
