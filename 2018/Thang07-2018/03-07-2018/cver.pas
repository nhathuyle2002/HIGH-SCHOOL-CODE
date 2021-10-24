const   ginp='cver.inp';
        gout='cver.out';

var     n,q:longint;
        x,y,w,ww,p,v,d,pa,h,ou:array[0..100010] of longint;

procedure swap(var xx,yy:longint); inline;
var     tm:longint;
begin
        tm:=xx;xx:=yy;yy:=tm;
end;

procedure sort(l,r:longint; var a,b,c:array of longint); inline;
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
                        swap(b[i],b[j]);
                        swap(c[i],c[j]);
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j,a,b,c);sort(i,r,a,b,c);
end;

procedure enter;
var     i:longint;
begin
        readln(n,q);
        for i:=1 to n-1 do readln(x[i],y[i],w[i]);
        sort(1,n-1,w,x,y);
        for i:=1 to q do
        begin
                readln(ww[i],p[i]);
                v[i]:=i;
        end;
        sort(1,q,ww,p,v);
end;

function max(xx,yy:longint):longint; inline;
begin
        if xx>yy then exit(xx) else exit(yy);
end;

function root(u:longint):longint; inline;
begin
        while u<>pa[u] do u:=pa[u];
        root:=u;
end;

procedure push(u,v:longint); inline;
var     u0,v0:longint;
begin
        u0:=root(u);v0:=root(v);
        if u0<>v0 then
        begin
                if h[u0]>h[v0] then
                begin
                        pa[v0]:=u0;
                        d[u0]:=d[u0]+d[v0];
                end else
                begin
                        pa[u0]:=v0;
                        h[v0]:=max(h[v0],h[u0]+1);
                        d[v0]:=d[v0]+d[u0];
                end;
        end;
end;

procedure process;
var     i,j:longint;
begin
        for i:=1 to n do
        begin
                pa[i]:=i;
                d[i]:=1;
                h[i]:=1;
        end;
        j:=n-1;
        for i:=q downto 1 do
        begin
                while (j>0) and (w[j]>=ww[i]) do
                begin
                        push(x[j],y[j]);
                        dec(j);
                end;
                ou[v[i]]:=d[root(p[i])]-1;
        end;
        for i:=1 to q do writeln(ou[i]);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        process;
        close(input);close(output);
end.
