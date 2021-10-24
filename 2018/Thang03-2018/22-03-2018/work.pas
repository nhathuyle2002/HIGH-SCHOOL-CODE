const   ginp='work.inp';
        gout='work.out';

var     gi,go:text;
        n:longint;
        ans:int64;
        a,b,f:array[0..100001] of int64;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n);
        for i:=1 to n do readln(gi,a[i],b[i]);
end;

procedure swap(var x,y:int64);
var     tmp:int64;
begin
        tmp:=x;
        x:=y;
        y:=tmp;
end;

procedure sort(l,r:longint);
var     i,j,tmp:longint;
begin
        if l>=r then exit;
        tmp:=random(r-l+1)+l;
        i:=l;j:=r;
        repeat
                while (b[i]<b[tmp]) or ((b[i]=b[tmp]) and (a[i]<a[tmp])) do inc(i);
                while (b[j]>b[tmp]) or ((b[j]=b[tmp]) and (a[j]>a[tmp])) do dec(j);
                if i<=j then
                begin
                        swap(a[i],a[j]);
                        swap(b[i],b[j]);
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j);sort(i,r);
end;

function max(x,y:int64):int64;
begin
        if x>y then exit(x) else exit(y);
end;

procedure process;
var     i,j:longint;
        tg,tmp:int64;
begin
        for i:=1 to n do
        begin
                tmp:=b[i]-a[i];
                f[i]:=tmp;
                for j:=i-1 downto 1 do
                begin
                        if a[i]>=b[j] then tg:=0 else tg:=b[j]-a[i];
                        f[i]:=max(f[i],f[j]+b[i]-a[i]-2*tg);
                end;
                ans:=max(f[i],ans);
        end;
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


