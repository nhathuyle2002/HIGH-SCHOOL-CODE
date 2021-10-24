const   ginp='cakes.inp';
        gout='cakes.out';

var     gi,go:text;
        n,s:longint;
        t,x:array[0..1000000] of longint;
        a:array[0..100] of longint;
        gt:longint;
        f:array[0..1001,0..1001] of int64;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n,s);
        for i:=1 to n do readln(gi,x[i],t[i]);
end;

function max(a,b:int64):int64;
begin
        if a>b then exit(a) else exit(b);
end;

procedure qhd;
var     i,j:longint;
begin
        for i:=1 to n do
                for j:=1 to s do
                        if (j-(x[i]-x[i-1]+t[i])>=0) then f[i,j]:=max(f[i-1,j],f[i-1,j-(x[i]-x[i-1]+t[i])]+1)
                        else f[i,j]:=f[i-1,j];
        gt:=f[n,s];
end;

procedure check;
var     i,dem,j:longint;
        sum:int64;
begin
        dem:=0;
        sum:=0;
        for i:=1 to n do
                if a[i]=1 then
                begin
                        inc(dem);
                        sum:=sum+t[i];
                        for j:=i-1 downto 0 do
                                if a[j]=1 then
                                begin
                                        sum:=sum+(x[i]-x[j]);
                                        break;
                                end;
                end;
        if sum<=s then gt:=max(gt,dem);
end;

procedure try(i:longint);
var     j:longint;
begin
        for j:=0 to 1 do
        begin
                a[i]:=j;
                if i=n then check else try(i+1);
        end;
end;

procedure process;
begin
        gt:=0;
        if n<=22 then try(1) else qhd;
end;

procedure output;
begin
        write(go,gt);
        close(gi);close(go);
end;

begin
        input;
        process;
        output;
end.