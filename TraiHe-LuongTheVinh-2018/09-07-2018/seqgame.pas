const   ginp='seqgame.inp';
        gout='seqgame.out';
        oo=trunc(1e10);

var     m,n,k:longint;
        sum,res:int64;
        a,b:array[0..100010] of int64;

procedure swap(var x,y:int64);
var     tm:int64;
begin
        tm:=x;x:=y;y:=tm;
end;

procedure sort(l,r:longint; var d:array of int64);
var     i,j:longint;
        t:int64;
begin
        if l>=r then exit;
        i:=l;j:=r;
        t:=d[random(r-l+1)+l];
        repeat
                while d[i]<t do inc(i);
                while d[j]>t do dec(j);
                if i<=j then
                begin
                        swap(d[i],d[j]);
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j,d);sort(i,r,d);
end;

procedure enter;
var     i:longint;
begin
        readln(m,n,k);
        for i:=1 to m do read(a[i]);readln;
        sort(1,m,a);
        for i:=1 to n do read(b[i]);readln;
        sort(1,n,b);
        for i:=1 to n div 2 do swap(b[i],b[n-i+1]);
        b[0]:=oo;b[n+1]:=-oo;
end;

function min(x,y,z:int64):int64;
begin
        min:=x;
        if min>y then min:=y;
        if min>z then min:=z;
end;

function abs(x:int64):int64;
begin
        if x>0 then exit(x) else exit(-x);
end;

procedure process;
var     i,j:longint;
begin
        res:=oo;
        j:=1;
        for i:=1 to m do
        begin
                while (a[i]+b[j]>sum) do inc(j);
                res:=min(res,abs(a[i]+b[j]-sum),abs(a[i]+b[j-1]-sum));
                if res=0 then break;
        end;
        writeln(res);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        while k>0 do
        begin
                read(sum);
                process;
                dec(k);
        end;
        close(input);close(output);
end.
