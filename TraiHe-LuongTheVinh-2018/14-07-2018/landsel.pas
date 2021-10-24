const   ginp='landsel.inp';
        gout='landsel.out';

var     res:int64;
        m,n,k,nh:longint;
        a,v,h:array[0..1000010] of longint;

procedure swap(var x,y:longint);
var     tm:longint;
begin
        tm:=x;x:=y;y:=tm;
end;

procedure sort(l,r:longint);
var     i,j,t,tm:longint;
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
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j);sort(i,r);
end;

procedure enter;
var     i:longint;
begin
        readln(m,n,k);
        for i:=1 to m do
        begin
                for j:=1 to n do read(a[i+(j-1)*m]);
                readln;
        end;
        for i:=1 to n do sort((i-1)*m+1,i*m);
end;

procedure uph(i:longint);
var     j:longint;
begin
        j:=i shr 1;
        if j<1 then exit;
        if h[i]<h[j] then
        begin
                swap(h[i],h[j]);
                swap(v[i],v[j]);
                uph(j);
        end;
end;

procedure downh(i:longint);
var     j:longint;
begin
        j:=i shl 1;
        if j>nh then exit;
        if (j<nh) and (h[j+1]<h[j]) then inc(j);
        if h[i]>h[j] then
        begin
                swap(h[i],h[j]);
                swap(v[i],v[j]);
                downh(j);
        end;
end;

procedure process;
var     i,j:longint;
begin
        nh:=0;
        for i:=1 to n do
        begin
                res:=res+a[(i-1)*m+1];
                inc(nh);h[nh]:=-a[(i-1)*m+2]+a[(i-1)*m+1];
                uph(nh);
        end;

end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        process;
        close(input);close(output);
end.

