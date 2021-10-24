const   ginp='ss.inp';
        gout='ss.out';
        maxn=300010;
        maxx=100010;

var     gi,go:text;
        n,k,x1,y1,x2,y2:longint;
        res:int64;
        fx,fy:array[0..maxx] of int64;
        x,y,a:array[0..maxn] of longint;

procedure swap(var xx,yy:longint); inline;
var     tm:longint;
begin
        tm:=xx;xx:=yy;yy:=tm;
end;

procedure sort(l,r:longint);
var     i,j,t1,t2:longint;
begin
        if l>=r then exit;
        i:=l;j:=r;
        t1:=random(r-l+1)+l;
        t2:=y[t1];t1:=x[t1];
        repeat
                while (y[i]<t2) or ((y[i]=t2) and (x[i]<t1)) do inc(i);
                while (y[j]>t2) or ((y[j]=t2) and (x[j]>t1)) do dec(j);
                if i<=j then
                begin
                        swap(a[i],a[j]);
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
        readln(gi,n,k);
        for i:=1 to n do readln(gi,x[i],y[i],a[i]);
        if n=1 then res:=a[1];
        x1:=x[1];y1:=y[1];x2:=x[n];y2:=y[n];
        sort(1,n);
end;

function max(xx,yy:int64):int64; inline;
begin
        if xx>yy then exit(xx) else exit(yy);
end;

procedure process;
var     i:longint;
        tm1,tm2:int64;
begin
        for i:=0 to maxx do
        begin
                fx[i]:=-1;fy[i]:=-1;
        end;
        for i:=1 to n do
        begin
                if (x[i]=x1) and (y[i]=y1) then
                begin
                        fx[x1]:=a[i];fy[y1]:=a[i];
                end else
                if (x[i]=x2) and (y[i]=y2) then
                begin
                        res:=max(fx[x2],fy[y2]);
                        res:=res-k+a[i];exit;
                end else
                begin
                if (fx[x[i]]>=k) then tm1:=fx[x[i]]+a[i]-k else tm1:=-1;
                if (fy[y[i]]>=k) then tm2:=fy[y[i]]+a[i]-k else tm2:=-1;
                fx[x[i]]:=max(fx[x[i]],max(tm1,tm2));fy[y[i]]:=max(fy[y[i]],max(tm1,tm2));
                end;
        end;
end;

begin
        assign(gi,ginp);reset(gi);
        assign(go,gout);rewrite(go);
        input;
        if n<>1 then process;
        write(go,res);
        close(gi);close(go);
end.
