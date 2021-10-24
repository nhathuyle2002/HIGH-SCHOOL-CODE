const   ginp='ss.inp';
        gout='ss.out';

var     gi,go:text;
        n,m,ans:longint;
        a,d:array[0..1001,0..1001] of longint;
        f:array[0..1001] of longint;

procedure input;
var     i,j:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n,m);
        for i:=1 to m do
        begin
                for j:=1 to n do
                begin
                        read(gi,a[i,j]);
                        d[i,a[i,j]]:=j;
                end;
                readln(gi);
        end;
end;

function max(x,y:longint):longint;
begin
        if x>y then exit(x) else exit(y);
end;

function ccl(i,j:longint):longint;
var     k:longint;
begin
        for k:=2 to m do
                if d[k,a[1,i]]<d[k,a[1,j]] then exit(0);
        exit(f[j]+1);
end;

procedure process;
var     i,j,k:longint;
begin
        ans:=0;
        for i:=1 to n do
        begin
                f[i]:=1;
                for j:=i-1 downto 1 do
                        f[i]:=max(f[i],ccl(i,j));
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
        process;
        output;
end.
