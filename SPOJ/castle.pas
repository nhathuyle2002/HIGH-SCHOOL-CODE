const   ginp='ss.inp';
        gout='ss.out';

var     gi,go:text;
        n,n1,n2,n3:longint;
        cou1,cou2,cou3,res2,res3:int64;
        x,y,p,q,a:array[0..5001] of int64;

procedure swap(var x,y:int64); inline;
var     tm:longint;
begin
        tm:=x;x:=y;y:=tm;
end;

procedure sort(l,r:longint); inline;
var     i,j:longint;
        t1,t2:int64;
begin
        if l>=r then exit;
        i:=l;j:=r;
        t1:=random(r-l+1)+l;
        t2:=y[t1];t1:=x[t1];
        repeat
                while (x[i]<t1) or ((x[i]=t1) and (y[i]<t2)) do inc(i);
                while (x[j]>t1) or ((x[j]=t1) and (y[j]>t2)) do dec(j);
                if i<=j then
                begin
                        swap(x[i],x[j]);
                        swap(y[i],y[j]);
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j);sort(i,r);
end;

procedure input;
var     i:longint;
begin
        readln(gi,n);
        for i:=1 to n do readln(gi,x[i],y[i]);
        sort(1,n);
        res2:=0;res3:=high(int64);
end;

procedure check(xx:int64);
var     i,j:longint;
        tm:int64;
begin
        n3:=0;
        j:=1;
        for i:=1 to n1 do
        begin
                while (j<=n2) and (q[j]<=p[i]) do
                begin
                        if p[i]=q[j] then
                        begin
                                inc(n3);a[n3]:=p[i];
                        end;
                        inc(j);
                end;
        end;
        if n3<2 then exit;
        cou1:=cou1+n3*(n3-1) div 2;
        tm:=(a[n3]-a[1])*xx;
        if tm=res2 then inc(cou2) else
        if tm>res2 then
        begin
                cou2:=1;res2:=tm;
        end;
        for i:=2 to n3 do
        begin
                tm:=(a[i]-a[i-1])*xx;
                if tm=res3 then inc(cou3) else
                if tm<res3 then
                begin
                        cou3:=1;res3:=tm;
                end;
        end;
end;

procedure process;
var     i,j,k,t:longint;
begin
        x[n+1]:=maxlongint+100;
        i:=1;
        while i<=n do
        begin
                n1:=1;p[n1]:=y[i];
                for j:=i+1 to n+1 do
                        if x[j]<>x[i] then break else
                        begin
                                inc(n1);p[n1]:=y[j];
                        end;
                k:=j;
                if n1>=2 then
                while k<=n do
                begin
                        n2:=1;q[n2]:=y[k];
                        for t:=k+1 to n+1 do
                                if x[t]<>x[k] then break else
                                begin
                                        inc(n2);q[n2]:=y[t];
                                end;
                        if n2>=2 then check(x[k]-x[i]);
                        k:=t;
                end;
                i:=j;
        end;
        writeln(go,cou1);
        if cou1>0 then
        begin
                writeln(go,res2,' ',cou2);
                write(go,res3,' ',cou3);
        end;
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        input;
        process;
        close(gi);close(go);
end.
