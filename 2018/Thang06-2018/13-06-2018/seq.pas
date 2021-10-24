const   ginp='seq.inp';
        gout='seq.out';
        maxn=100010;

var     gi,go:text;
        n,m,sl,res:longint;
        a,d,g,v:array[0..maxn] of longint;

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
        t:=g[random(r-l+1)+l];
        repeat
                while g[i]<t do inc(i);
                while g[j]>t do dec(j);
                if i<=j then
                begin
                        swap(g[i],g[j]);
                        swap(v[i],v[j]);
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j);sort(i,r);
end;

procedure input;
var     i,cou:longint;
begin
        readln(gi,n,m);
        for i:=1 to n do
        begin
                read(gi,a[i]);
                g[i]:=a[i];v[i]:=i;
        end;
        sort(1,n);
        cou:=1;a[v[1]]:=1;
        for i:=2 to n do
        begin
                if g[i]>g[i-1] then inc(cou);
                a[v[i]]:=cou;
        end;
end;

procedure process;
var     i,l:longint;
begin
        res:=0;
        sl:=0;l:=1;
        for i:=1 to n do
        begin
                if d[a[i]]=0 then inc(sl);
                inc(d[a[i]]);
                while sl>m do
                begin
                        dec(d[a[l]]);
                        if d[a[l]]=0 then dec(sl);
                        inc(l);
                end;
                if i-l+1>res then res:=i-l+1;
        end;
        write(go,res);
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        input;
        process;
        close(gi);close(go);
end.

