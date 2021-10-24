const   ginp='three.inp';
        gout='three.out';
        maxn=200100;
        oo=high(int64)-1;

var     gi,go:text;
        n,k:longint;
        a,b:array[0..maxn] of int64;

procedure sort(l,r:longint;var q:array of int64;var v:array of longint);
var     i,j,tmp:longint;
        t,tm:int64;
begin
        if l>=r then exit;
        i:=l; j:=r;
        t:=q[random(r-l+1)+l];
        repeat
                while q[i]<t do inc(i);
                while q[j]>t do dec(j);
                if i<=j then
                begin
                        tm:=q[i]; q[i]:=q[j]; q[j]:=tm;
                        tmp:=v[i]; v[i]:=v[j]; v[j]:=tmp;
                        inc(i); dec(j);
                end;
        until i>j;
        sort(l,j,q,v); sort(i,r,q,v);
end;

procedure input;
var     i,cou:longint;
        q:array[0..2*maxn] of int64;
        v:array[0..2*maxn] of longint;
begin
        readln(gi,n,k);
        for i:=1 to n do
        begin
                read(gi,a[i]); q[i]:=a[i]; v[i]:=i;
                if a[i] mod k=0 then b[i]:=a[i] div k else b[i]:=oo;
                q[i+n]:=b[i]; v[i+n]:=i+n;
        end;
        sort(1,2*n,q,v);
        q[0]:=-oo; cou:=0;
        for i:=1 to 2*n do
        begin
                if q[i]=oo then break;
                if q[i]>q[i-1] then inc(cou);
                if v[i]<=n then a[v[i]]:=cou else
                b[v[i]-n]:=cou;
        end;
end;

procedure main;
var     i:longint;
        res:int64;
        d,f:array[0..2*maxn] of int64;
begin
        res:=0;
        fillchar(d,sizeof(d),0);
        fillchar(f,sizeof(f),0);
        for i:=1 to n do
        begin
                if b[i]<>oo then
                begin
                        res:=res+f[b[i]];
                        f[a[i]]:=f[a[i]]+d[b[i]];
                end;
                inc(d[a[i]]);
        end;
        write(go,res);
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        input;
        main;
        close(gi);close(go);
end.
