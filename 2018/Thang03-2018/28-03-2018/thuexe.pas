const   ginp='thuexe.inp';
        gout='thuexe.out';

var     gi,go:text;
        n,ans:longint;
        a,b,c,f:array[0..10001] of longint;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n);
        for i:=1 to n do read(gi,a[i],b[i],c[i]);
end;

procedure swap(var x,y:longint);
var     tmp:longint;
begin
        tmp:=x;
        x:=y;
        y:=tmp;
end;

procedure sort(l,r:longint);
var     i,j,tmp1,tmp2:longint;
begin
        if l>=r then exit;
        i:=random(r-l+1)+l;
        tmp1:=a[i];
        tmp2:=b[i];
        i:=l;j:=r;
        repeat
                while (b[i]<tmp2) or ((b[i]=tmp2) and (a[i]<tmp1)) do inc(i);
                while (b[j]>tmp2) or ((b[j]=tmp2) and (a[j]>tmp1)) do dec(j);
                if i<=j then
                begin
                        swap(a[i],a[j]);
                        swap(b[i],b[j]);
                        swap(c[i],c[j]);
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
        for i:=1 to n do
        begin
                for j:=i-1 downto 0 do
                        if a[i]>=b[j] then f[i]:=max(f[i],f[j]+c[i]);
                ans:=max(ans,f[i]);
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






















