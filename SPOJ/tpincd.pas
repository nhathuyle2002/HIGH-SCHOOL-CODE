const   ginp='ss.inp';
        gout='ss.out';
        kk=15111992;

var     gi,go:text;
        n,k,cou,res:longint;
        a,v,q:array[0..10001] of longint;
        f,s:array[0..10001,0..50] of longint;

procedure swap(var x,y:longint);
var     tm:longint;
begin
        tm:=x;x:=y;y:=tm;
end;

procedure sort(l,r:longint);
var     i,j,t:longint;
begin
        if l>=r then exit;
        i:=l;j:=r;
        t:=q[random(r-l+1)+l];
        repeat
                while q[i]<t do inc(i);
                while q[j]>t do dec(j);
                if i<=j then
                begin
                        swap(q[i],q[j]);
                        swap(v[i],v[j]);
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
                readln(gi,a[i]);
                q[i]:=a[i];v[i]:=i;
        end;
        sort(1,n);
        cou:=1;a[v[1]]:=1;
        for i:=2 to n do
        begin
                if q[i]>q[i-1] then inc(cou);
                a[v[i]]:=cou;
        end;
end;

procedure update(j,i,x:longint);
begin
        if i>cou then exit;
        s[i,j]:=s[i,j]+x;
        if s[i,j]>=kk then dec(s[i,j],kk);
        update(j,i+i and (-i),x);
end;

function quece(j,i:longint):longint;
begin
        if i<=0 then exit(0);
        quece:=quece(j,i-i and (-i))+s[i,j];
        if quece>=kk then dec(quece,kk);
end;

procedure process;
var     i,j,tm:longint;
begin
        for i:=1 to n do
        begin
                if f[a[i],1]=0 then
                begin
                        f[a[i],1]:=1;
                        update(1,a[i],1);
                end;
                for j:=2 to k do
                begin
                        tm:=quece(j-1,a[i]-1);
                        update(j,a[i],tm-f[a[i],j]);
                        f[a[i],j]:=tm;
                end;
        end;
        write(go,quece(k,cou));
end;

begin
        assign(gi,ginp);reset(gi);
        assign(go,gout);rewrite(go);
        input;
        process;
        close(gi);close(go);
end.
