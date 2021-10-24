const   ginp='segcover.inp';
        gout='segcover.out';

var     gi,go:text;
        n,ans:longint;
        a,b:array[0..1000001] of longint;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n);
        for i:=1 to n do readln(gi,a[i],b[i]);
end;

procedure swap(var x,y:longint);
var     tm:longint;
begin
        tm:=x;
        x:=y;
        y:=tm;
end;

procedure sort(l,r:longint);
var     i,j,tm:longint;
begin
        if l>=r then exit;
        tm:=b[random(r-l+1)+l];
        i:=l;j:=r;
        repeat
                while b[i]<tm do inc(i);
                while b[j]>tm do dec(j);
                if i<=j then
                begin
                        swap(a[i],a[j]);
                        swap(b[i],b[j]);
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j);sort(i,r);
end;

function max(x,y:longint):longint;
begin
        if x>y then exit(x) else exit(y);
end;

procedure process;
var     i,j:longint;
begin
        j:=0;ans:=0;
        b[0]:=-maxlongint;
        for i:=1 to n do
                if a[i]<b[j] then inc(ans) else j:=i;
end;

procedure output;
begin
        write(go,ans);
        close(gi);close(go);
end;

begin
        input;
        sort(1,n);
        process;
        output;
end.















