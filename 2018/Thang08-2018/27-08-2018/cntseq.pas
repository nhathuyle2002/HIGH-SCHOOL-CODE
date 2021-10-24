const   ginp='cntseq.inp';
        gout='cntseq.out';
        maxn=1000010;

var     n,m,cou,top:longint;
        a,vl,vr,vt,vs,q:array[0..maxn] of longint;
        d,v:array[0..3*maxn] of longint;
        f:array[0..3*maxn] of int64;
        res:int64;

procedure sort(l,r:longint);
var     i,j,t,tm:longint;
begin
        if l>=r then exit;
        i:=l;j:=r;
        t:=d[random(r-l+1)+l];
        repeat
                while d[i]<t do inc(i);
                while d[j]>t do dec(j);
                if i<=j then
                begin
                        tm:=d[i];d[i]:=d[j];d[j]:=tm;
                        tm:=v[i];v[i]:=v[j];v[j]:=tm;
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j);sort(i,r);
end;

procedure enter;
var     i:longint;
begin
        readln(n);
        for i:=1 to n do
        begin
                read(a[i]);
                d[i]:=a[i];v[i]:=i;
        end;
        readln;readln(m);
        for i:=1 to m do
        begin
                readln(vl[i],vr[i]);
                d[n+i]:=vl[i];v[n+i]:=n+i;
                d[n+m+i]:=vr[i];v[n+m+i]:=n+m+i;
        end;
        sort(1,n+2*m);
        cou:=0;
        for i:=1 to n+2*m do
        begin
                if d[i]>d[i-1] then inc(cou);
                if v[i]<=n then a[v[i]]:=cou else
                if v[i]<=n+m then vl[v[i]-n]:=cou else
                vr[v[i]-n-m]:=cou;
        end;
end;

function quece(i:longint):int64;
begin
        if i<1 then exit(0);
        quece:=f[i]+quece(i-i and (-i));
end;

procedure update(i:longint;x:int64);
begin
        if i>cou then exit;
        f[i]:=f[i]+x;
        update(i+i and (-i),x);
end;

procedure process;
var     i:longint;
begin
        top:=0;q[0]:=0;
        for i:=1 to n do
        begin
                vs[i]:=n+1;
                while (top>0) and (a[q[top]]<=a[i]) do
                begin
                        vs[q[top]]:=i;
                        dec(top);
                end;
                vt[i]:=q[top];
                inc(top);q[top]:=i;
        end;
        for i:=1 to n do
                update(a[i],int64(i-vt[i])*(vs[i]-i));
        for i:=1 to m do
                writeln(quece(vr[i])-quece(vl[i]-1));
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        process;
        close(input);close(output);
end.
