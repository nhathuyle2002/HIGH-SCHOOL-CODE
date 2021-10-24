const   ginp='ss.inp';
        gout='ss.out';

var     gi,go:text;
        n,m:longint;
        x,y,w,pa:array[0..1000000] of longint;
        sum:int64;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n,m);
        for i:=1 to m  do readln(gi,x[i],y[i],w[i]);
end;

procedure swap(var xx,yy:longint);
var     tmp:longint;
begin
        tmp:=xx;
        xx:=yy;
        yy:=tmp;
end;

procedure sort(l,r:longint);
var     i,j,xx:longint;
begin
        i:=l;j:=r;
        xx:=w[random(r-l+1)+l];
        repeat
                while w[i]<xx do inc(i);
                while w[j]>xx do dec(j);
                if i<=j then
                begin
                        swap(x[i],x[j]);
                        swap(y[i],y[j]);
                        swap(w[i],w[j]);
                        inc(i);dec(j);
                end;
        until i>j;
        if l<j then sort(l,j);
        if i<r then sort(i,r);
end;

function root(k:longint):longint;
begin
        while pa[k]<>k do k:=pa[k];
        root:=k;
end;

procedure process;
var     i,dem,x0,y0:longint;
begin
        sum:=0;dem:=0;
        for i:=1 to n do pa[i]:=i;
        for i:=1 to m do
        begin
                if dem>=n-1 then break;
                x0:=root(x[i]);
                y0:=root(y[i]);
                if x0<>y0 then
                begin
                        pa[y0]:=x0;
                        inc(dem);
                        sum:=w[i];
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
        process;
        output;
end.
