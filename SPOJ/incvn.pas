const   ginp='ss.inp';
        gout='ss.out';
        kk=5000000;

var     gi,go:text;
        n,k,cou,res:longint;
        a,v,f,q:array[0..10011] of longint;
        s:array[0..50,0..10011] of longint;

procedure sort(l,r:longint);
var     i,j,tt,t,tm:longint;
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
                q[i]:=a[i];v[i]:=i;
        end;
        sort(1,n);
        cou:=0;
        a[0]:=0;
        for i:=1 to n do
        begin
                if q[i]>q[i-1] then inc(cou);
                a[v[i]]:=cou+10;
        end;
end;

procedure update(ii,i,x:longint);
begin
        while i<=cou do
        begin
                inc(s[ii,i],x);
                if s[ii,i]>=kk then dec(s[ii,i],kk);
                i:=i+i and (-i);
        end;
end;

function getsum(ii,i:longint):longint;
var     sum:longint;
begin
        sum:=0;
        while i>0 do
        begin
                inc(sum,s[ii,i]);
                if sum>=kk then dec(sum,kk);
                i:=i-i and (-i);
        end;
        exit(sum);
end;

procedure process;
var     i,j:longint;
begin
        for i:=1 to n do f[i]:=1;
        for j:=2 to k do
        begin
                for i:=1 to n do
                begin
                        update(j-1,a[i],f[i]);
                        f[i]:=getsum(j-1,a[i]-1);
                end;
        end;
        res:=0;
        for i:=1 to n do
        begin
                res:=res+f[i];
                if res>=kk then dec(res,kk);
        end;
        write(go,res);
end;

begin
        assign(gi,ginp);reset(gi);
        assign(go,gout);rewrite(go);
        input;
        process;
        close(gi);close(go);
end.
