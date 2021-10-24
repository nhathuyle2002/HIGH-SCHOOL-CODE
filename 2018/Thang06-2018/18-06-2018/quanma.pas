const   ginp='quanma.inp';
        gout='quanma.out';
        oo=trunc(1e16);
        di:array[1..4] of longint =(-1,-1,-2,-2);
        dj:array[1..4] of longint =(-2,2,-1,1);

var     gi,go:text;
        n,m:longint;
        a:array[0..102,0..102] of int64;
        f:array[0..102,-1..102] of int64;

function max(x,y:int64):int64;
begin
        if x>y then exit(x) else exit(y);
end;

procedure main;
var     i,j,k,i0,j0:longint;
        res:int64;
begin
        readln(gi,m,n);
        for i:=1 to m do
        begin
                for j:=1 to n do read(gi,a[i,j]);
                readln(gi);
        end;
        for i:=0 to m do
                for j:=-1 to n+2 do f[i,j]:=-oo;
        for i:=1 to n do f[1,i]:=a[1,i];
        for i:=2 to m do
                for j:=1 to n do
                        for k:=1 to 4 do
                        begin
                                i0:=i+di[k];
                                j0:=j+dj[k];
                                if f[i0,j0]<>-oo then f[i,j]:=max(f[i,j],f[i0,j0]+a[i,j]);
                        end;
        res:=-oo;
        for i:=1 to n do res:=max(res,f[m,i]);
        write(go,res);
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        main;
        close(gi);close(go);
end.
