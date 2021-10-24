const   ginp='xaydung.inp';
        gout='xaydung.out';

var     gi,go:text;
        n,m,ans:longint;
        x,y,pa,w:array[0..1000001] of longint;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n,m);
        for i:=1 to m do readln(gi,x[i],y[i],w[i]);
end;

procedure swap(var a,b:longint);
var     tm:longint;
begin
        tm:=a;
        a:=b;
        b:=tm;
end;

procedure sort(l,r:longint);
var     i,j,tm:longint;
begin
        if l>=r then exit;
        tm:=w[random(r-l+1)+l];
        i:=l;j:=r;
        repeat
                while w[i]<tm do inc(i);
                while w[j]>tm do dec(j);
                if i<=j then
                begin
                        swap(x[i],x[j]);
                        swap(y[i],y[j]);
                        swap(w[i],w[j]);
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j);sort(i,r);
end;

function root(a:longint):longint;
begin
        while a<>pa[a] do a:=pa[a];
        exit(a);
end;

procedure kruskal;
var     i,x0,y0,dem:longint;
begin
        for i:=1 to n do pa[i]:=i;
        i:=0;
        repeat
                inc(i);
                x0:=root(x[i]);
                y0:=root(y[i]);
                if x0<>y0 then
                begin
                        pa[y0]:=x0;
                        pa[y[i]]:=x0;
                        inc(dem);
                        ans:=w[i];
                end;
        until (i>=m) or (dem=n-1);
end;

procedure output;
begin
        write(go,ans);
        close(gi);close(go);
end;

begin
        input;
        sort(1,m);
        kruskal;
        output;
end.



