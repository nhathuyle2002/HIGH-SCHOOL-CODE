const   ginp='dcdn.inp';
        gout='dcdn.out';

var     gi,go:text;
        n,h,ans:longint;
        a,f:array[0..10001] of longint;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n,h);
        for i:=1 to n do read(gi,a[i]);
end;

function max(x,y:longint):longint;
begin
        if x>y then exit(x) else exit(y);
end;

procedure process;
var     i,j:longint;
begin
        f[1]:=1;ans:=1;
        for i:=2 to n do
        begin
                f[i]:=1;
                for j:=i-2 downto 1 do
                        if abs(a[i]-a[j])<=h then f[i]:=max(f[i],f[j]+1);
                ans:=max(ans,f[i]);
        end;
end;

procedure output;
begin
        if ans<=1 then write(go,0) else write(go,ans);
        close(gi);close(go);
end;

begin
        input;
        process;
        output;
end.
