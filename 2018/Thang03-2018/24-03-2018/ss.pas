const   ginp='highway.inp';
        gout='highway.out';

var     gi,go:text;
        n,m,ans:longint;
        x,y:array[0..10001] of longint;
        w:array[0..10001] of real;
        d:array[0..751,0..751] of boolean;
        pa:array[0..751] of longint;

procedure input;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
end;

procedure create;
var     dx,dy:array[0..751] of real;
        i,u,v,j,dem:longint;
begin
        readln(gi,n);
        for i:=1 to n do readln(gi,dx[i],dy[i]);
        readln(gi,m);
        fillchar(d,sizeof(d),false);
        for i:=1 to m do
        begin
                readln(gi,u,v);
                d[u,v]:=true;
                d[v,u]:=true;
        end;
        dem:=0;
        for i:=1 to n-1 do
                for j:=i+1 to n do
                begin
                        inc(dem);
                        x[dem]:=i;
                        y[dem]:=j;
                        if d[i,j] then w[dem]:=0 else w[dem]:=sqrt(sqr(dx[i]-dx[j])+sqr(dy[i]-dy[j]));
                end;
        m:=dem;
end;

procedure swap(var xx,yy:longint);
var     tmp:longint;
begin
        tmp:=xx;
        xx:=yy;
        yy:=tmp;
end;

procedure sort(l,r:longint);
var     i,j:longint;
        tmp,tg:real;
begin
        if l>=r then exit;
        i:=l;j:=r;
        tmp:=w[random(r-l+1)+l];
        repeat
                while w[i]<tmp do inc(i);
                while w[j]>tmp do dec(j);
                if i<=j then
                begin
                        swap(x[i],x[j]);
                        swap(y[i],y[j]);
                        tg:=w[i];w[i]:=w[j];w[j]:=tg;
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j);sort(i,r);
end;

function root(k:longint):longint;
begin
        while pa[k]<>k do k:=pa[k];
        root:=k;
end;

procedure process;
var     i,dem,x0,y0:longint;
begin
        for i:=1 to n do pa[i]:=i;
        dem:=0;ans:=0;
        for i:=1 to m do
        begin
                if dem=n-1 then break;
                x0:=root(x[i]);
                y0:=root(y[i]);
                if x0<>y0 then
                begin
                        inc(dem);
                        pa[y0]:=x0;
                        pa[y[i]]:=x0;
                        if d[x[i],y[i]]=false then inc(ans);
                end;
        end;
end;

procedure output;
begin
        write(go,ans);
        close(gi);close(go);
end;

begin
        input;
        create;
        sort(1,m);
        process;
        output;
end.



























