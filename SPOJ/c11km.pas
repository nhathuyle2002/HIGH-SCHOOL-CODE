const   ginp='ss.inp';
        gout='ss.out';
        oo=trunc(1e7);

var     gi,go:text;
        n:longint;
        a:array[0..1001] of longint;
        f:array[0..1001,0..1001] of longint;

procedure input;
var     i:longint;
begin
        readln(gi,n);
        for i:=1 to n do read(gi,a[i]);
end;

function min(x,y:longint):longint;
begin
        if x<y then exit(x) else exit(y);
end;

procedure process;
var     i,j,res:longint;
begin
        for i:=1 to n+1 do f[0,i]:=oo;
        for i:=1 to n do
        begin
                f[i,0]:=min(f[i-1,0]+a[i],f[i-1,1]);
                for j:=1 to i do
                        if a[i]>100 then f[i,j]:=min(f[i-1,j-1]+a[i],f[i-1,j+1])
                        else f[i,j]:=min(f[i-1,j]+a[i],f[i-1,j+1]);
                for j:=i+1 to n+1 do f[i,j]:=oo;
        end;
        res:=oo;
        for i:=0 to n do res:=min(res,f[n,i]);
        write(go,res);
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        input;
        process;
        close(gi);close(go);
end.
