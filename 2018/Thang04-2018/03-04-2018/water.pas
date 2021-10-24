const   ginp='water.inp';
        gout='water.out';

var     gi,go:text;
        n,m:longint;
        sum:int64;
        x,y,w:array[0..10001001] of longint;
        pa:array[0..301] of longint;

procedure input;
var     i,c,j:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n);
        for i:=1 to n do
        begin
                inc(m);
                x[m]:=0;
                y[m]:=i;
                readln(gi,w[m]);
        end;
        for i:=1 to n do
        begin
                for j:=1 to n do
                begin
                        read(gi,c);
                        if i<j then
                        begin
                                inc(m);
                                x[m]:=i;y[m]:=j;
                                w[m]:=c;
                        end;
                end;
                readln(gi);
        end;
end;

procedure swap(var xx,yy:longint);
var     tm:longint;
begin
        tm:=xx;
        xx:=yy;
        yy:=tm;
end;

procedure sort(l,r:longint);
var     i,j,tm:longint;
begin
        if l>=r then exit;
        i:=l;j:=r;
        tm:=w[random(r-l+1)+l];
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
        while pa[a]<>a do a:=pa[a];
        exit(a);
end;

procedure kruscal;
var     i,dem,x0,y0:longint;
begin
        for i:=1 to n do pa[i]:=i;
        dem:=0;
        for i:=1 to m do
        begin
                if dem=n then exit;
                x0:=root(x[i]);
                y0:=root(y[i]);
                if x0<>y0 then
                begin
                        pa[y0]:=x0;
                        pa[y[i]]:=x0;
                        inc(dem);
                        sum:=sum+w[i];
                end;
        end;
end;

procedure output;
begin
        write(go,sum);
        close(gi);close(go);
end;

begin
        input;
        sort(1,m);
        kruscal;
        output;
end.






