const   ginp='ss.inp';
        gout='ss.out';

type    que=record l,r,k,c:longint;end;

var     gi,go:text;
        n,nq:longint;
        q:array[0..200001] of que;
        res:array[0..200001] of longint;
        a,ca,f:array[0..30001] of longint;

procedure swap(var x,y:longint);
var     tm:longint;
begin
        tm:=x;x:=y;y:=tm;
end;

procedure sort1(l,r:longint);
var     i,j,t:longint;
begin
        if l>=r then exit;
        i:=l;j:=r;
        t:=a[random(r-l+1)+l];
        repeat
                while a[i]<t do inc(i);
                while a[j]>t do dec(j);
                if i<=j then
                begin
                        swap(a[i],a[j]);
                        swap(ca[i],ca[j]);
                        inc(i);dec(j);
                end;
        until i>j;
        sort1(l,j);sort1(i,r);
end;

procedure sort2(l,r:longint);
var     i,j:longint;
        t,tm:que;
begin
        if l>=r then exit;
        i:=l;j:=r;
        t:=q[random(r-l+1)+l];
        repeat
                while q[i].k<t.k do inc(i);
                while q[j].k>t.k do dec(j);
                if i<=j then
                begin
                        tm:=q[i];q[i]:=q[j];q[j]:=tm;
                        inc(i);dec(j);
                end;
        until i>j;
        sort2(l,j);sort2(i,r);
end;

procedure input;
var     i:longint;
begin
        readln(gi,n);
        for i:=1 to n do
        begin
                read(gi,a[i]);
                ca[i]:=i;
        end;
        sort1(1,n);
        readln(gi);
        readln(gi,nq);
        for i:=1 to nq do
        begin
                readln(gi,q[i].l,q[i].r,q[i].k);
                q[i].c:=i;
        end;
        sort2(1,nq);
end;

function quece(i:longint):longint;
begin
        if i<=0 then exit(0);
        quece:=f[i]+quece(i-i and (-i));
end;

procedure update(i:longint);
begin
        if i>n then exit;
        inc(f[i]);
        update(i+i and (-i));
end;

procedure process;
var     i,j:longint;
begin
        i:=n;
        for j:=nq downto 1 do
        begin
                while (i>0) and (a[i]>q[j].k) do
                begin
                        update(ca[i]);
                        dec(i);
                end;
                res[q[j].c]:=quece(q[j].r)-quece(q[j].l-1);
        end;
        for i:=1 to nq do writeln(go,res[i]);
end;

begin
        assign(gi,ginp);reset(gi);
        assign(go,gout);rewrite(go);
        input;
        process;
        close(gi);close(go);
end.
