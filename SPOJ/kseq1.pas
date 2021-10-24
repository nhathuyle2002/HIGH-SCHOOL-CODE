const   ginp='ss.inp';
        gout='ss.out';

var     gi,go:text;
        n,res:longint;
        a:array[0..301] of longint;
        f:array[0..301,0..301] of longint;

procedure input;
var     i:longint;
begin
        readln(gi,n);
        for i:=1 to n do read(gi,a[i]);
end;

function max(x,y:longint):longint;
begin
        if x>y then exit(x) else exit(y);
end;

procedure process;
var     i,j,k:longint;
begin
        res:=0;
        for k:=1 to n-1 do
        begin
                for i:=1 to k do f[i,0]:=0;
                for j:=1 to n-k do f[0,j]:=0;
                for i:=1 to k do
                        for j:=1 to n-k do
                                if a[j+k]>a[i] then f[i,j]:=f[i-1,j-1]+1
                                else f[i,j]:=max(f[i-1,j],f[i,j-1]);
                res:=max(res,f[k,n-k]);
        end;
end;

begin
        assign(gi,ginp);reset(gi);
        assign(go,gout);rewrite(go);
        input;
        process;
        write(go,res);
        close(gi);close(go);
end.
