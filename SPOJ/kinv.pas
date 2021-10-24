const   ginp='ss.inp';
        gout='ss.out';
        kk=round(1e9);

var     gi,go:text;
        n,k,cou:longint;
        v:array[0..10001] of longint;
        res:int64;
        a,f,q:array[0..10001] of int64;

procedure sort(l,r:longint);
var     i,j,tt:longint;
        t,tm:int64;
begin
        if l>=r then exit;
        i:=l;j:=r;
        t:=q[random(r-l+1)+l];
        repeat
                while q[i]<t do inc(i);
                while t<q[j] do dec(j);
                if i<=j then
                begin
                        tm:=q[i];q[i]:=q[j];q[j]:=tm;
                        tt:=v[i];v[i]:=v[j];v[j]:=tt;
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j);sort(i,r);
end;

procedure input;
var     i:longint;
begin
        readln(gi,n,k);
        for i:=1 to n do
        begin
                read(gi,a[i]);
                q[i]:=a[i];
                v[i]:=i;
        end;
        sort(1,n);
        cou:=0;
        a[0]:=0;
        for i:=1 to n do
        begin
                if q[i]>q[i-1] then inc(cou);
                a[v[i]]:=cou;
        end;
end;

procedure update(i:longint;x:int64);
begin
        if i>cou then exit;
        q[i]:=(q[i]+x) mod kk;
        update(i+i and (-i),x);
end;

function getsum(i:longint):int64;
begin
        if i<=0 then exit(0);
        getsum:=q[i]+getsum(i-i and (-i));
        getsum:=getsum mod kk;
end;

procedure process;
var     i,j:longint;
begin
        for i:=1 to n do f[i]:=1;
        for j:=2 to k do
        begin
                fillchar(q,sizeof(q),0);
                for i:=1 to n do
                begin
                        update(a[i],f[i]);
                        f[i]:=(getsum(cou)-getsum(a[i])+kk) mod kk;
                end;
        end;
        res:=0;
        for i:=1 to n do res:=(res+f[i]) mod kk;
        write(go,res);
end;

begin
        assign(gi,ginp);reset(gi);
        assign(go,gout);rewrite(go);
        input;
        process;
        close(gi);close(go);
end.
