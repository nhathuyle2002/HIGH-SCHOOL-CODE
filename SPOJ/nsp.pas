const   ginp='ss.inp';
        gout='ss.out';

var     gi,go:text;
        n,k,q:longint;
        a,vi,vj,r:array[0..1000001] of longint;

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
        t:=a[random(r-l+1)+l];
        repeat
                while a[i]<t do inc(i);
                while a[j]>t do dec(j);
                if i<=j then
                begin
                        swap(a[i],a[j]);
                        swap(vi[i],vi[j]);
                        swap(vj[i],vj[j]);
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j);sort(i,r);
end;

procedure bina_se(x:longint);
var     d,c,m:longint;
begin
        d:=1;c:=k+1;
        while d<>c do
        begin
                m:=(d+c) shr 1;
                if a[m]<=x then d:=m+1 else c:=m;
        end;
        writeln(go,vi[r[d]],' ',vj[r[d]]);
        dec(r[d]);
end;

procedure main;
var     i,j,x:longint;
begin
        readln(gi,n,q);
        k:=0;
        for i:=1 to n do
        begin
                for j:=1 to n do
                begin
                        inc(k);read(gi,a[k]);
                        vi[k]:=i;vj[k]:=j;
                        r[k]:=k-1;
                end;
                readln(gi);
        end;
        sort(1,k);a[k+1]:=maxlongint;
        for i:=1 to q do
        begin
                readln(gi,x);
                bina_se(x);
        end;
end;

begin
        assign(gi,ginp);reset(gi);
        assign(go,gout);rewrite(go);
        main;
        close(gi);close(go);
end.
