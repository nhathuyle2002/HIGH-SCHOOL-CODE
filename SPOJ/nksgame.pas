const   ginp='ss.inp';
        gout='ss.out';
        vc=trunc(1e15);

var     gi,go:text;
        n:longint;
        ans:int64;
        b,c:array[0..100001] of int64;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n);
        for i:=1 to n do read(gi,b[i]);readln(gi);
        for i:=1 to n do read(gi,c[i]);
end;

procedure sort(l,r:longint;var d:array of int64);
var     i,j:longint;
        t,tm:int64;
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
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j,d);sort(i,r,d);
end;

function min(x,y,z:int64):int64;
begin
        min:=x;
        if y<min then min:=y;
        if z<min then min:=z;
end;

procedure cnp(x:int64);
var     l,r,m:longint;
begin
        l:=0;r:=n+1;
        while l<>r do
        begin
                m:=(l+r) div 2;
                if c[m]<=x then l:=m+1 else r:=m;
        end;
        ans:=min(ans,abs(c[l]-x),abs(c[l-1]-x));
end;

procedure process;
var     i:longint;
begin
        sort(1,n,b);sort(1,n,c);
        c[0]:=-vc;c[n+1]:=vc;
        ans:=maxlongint;
        for i:=1 to n do cnp(-b[i]);
end;

procedure output;
begin
        write(go,ans);
        close(gi);close(go);
end;

begin
        input;
        process;
        output;
end.
