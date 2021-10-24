const   ginp='mgt.inp';
        gout='mgt.out';

var     gi,go:text;
        n,m:longint;
        ans:int64;
        x,y:array[0..100001] of longint;
        w:array[0..100001] of int64;
        d:array[0..101,0..101] of boolean;
        pa:array[0..101] of longint;

procedure swap(var u,v:longint);
var     tmp:longint;
begin
        tmp:=u;
        u:=v;
        v:=tmp;
end;

procedure ad(u,v:longint;c:int64);
begin
        if d[u,v] then c:=0;
        inc(m);
        x[m]:=u;y[m]:=v;w[m]:=c;
end;

procedure input;
var     i,j,k,u,v,c:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        fillchar(d,sizeof(d),false);
        m:=0;
        readln(gi,n,k);
        for i:=1 to k do
        begin
                readln(gi,u,v);
                if u>v then swap(u,v);
                d[u,v]:=true;
        end;
        for i:=1 to n do
        begin
                for j:=1 to n do
                begin
                        read(gi,c);
                        if i<j then ad(i,j,c);
                end;
                readln(gi);
        end;
end;

procedure sort(l,r:longint);
var     i,j:longint;
        tmp,tt:int64;
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
                        tt:=w[i];w[i]:=w[j];w[j]:=tt;
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j);sort(i,r);
end;

function root(k:longint):longint;
begin
        while k<>pa[k] do k:=pa[k];
        root:=k;
end;

procedure prime;
var     i,x0,y0,dem:longint;
begin
        ans:=0;
        dem:=0;
        for i:=1 to n do pa[i]:=i;
        for i:=1 to m do
        begin
                if dem=n-1 then break;
                x0:=root(x[i]);
                y0:=root(y[i]);
                if x0<>y0 then
                begin
                        ans:=ans+w[i];
                        pa[y0]:=x0;
                        pa[y[i]]:=x0;
                        inc(dem);
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
        sort(1,m);
        prime;
        output;
end.
























