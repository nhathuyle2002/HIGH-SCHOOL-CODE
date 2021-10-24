const   ginp='ss.inp';
        gout='ss.out';
        maxbit=1 shl 20-1;

var     gi,go:text;
        n,maxb:longint;
        a,b,c:array[0..20] of longint;
        f:array[0..maxbit] of longint;

procedure input;
var     i:longint;
begin
        readln(gi,n);
        maxb:=1 shl n-1;
        for i:=1 to n do
        begin
                readln(gi,a[i]);
                if i>1 then b[i]:=b[i-1]+a[i]-a[i-2];
                if i>2 then c[i]:=c[i-1]+a[i]-a[i-3];
        end;
end;

function max(x,y:longint):longint;
begin
end;

procedure process;
var     i,j:longint;
begin

        for i:=maxb-1 downto 0 do
        begin
        end;
end;

begin
        assign(gi,ginp);reset(gi);
        assign(go,gout);rewrite(go);
        input;
        process;
        close(gi);close(go);
end.
