const   ginp='ss.inp';
        gout='ss.out';
        maxn=200;

var     gi,go:text;
        a:array[-maxn..maxn,-maxn..maxn] of longint;
        f:array[0..25] of longint;
        res:int64;

procedure input;
var     i,n,u,v:longint;
begin
        readln(gi,n);
        for i:=1 to n do readln(gi,u,v,a[u,v]);
end;

procedure process;
var     i,j,k,p:longint;
begin
        res:=0;
        for i:=-maxn to maxn do
                for j:=i+1 to maxn do
                begin
                        for k:=1 to 3 do
                                for p:=k+1 to 4 do f[k*p]:=0;
                        for k:=-maxn to maxn do
                                if (a[i,k]<>a[j,k]) and (a[i,k]*a[j,k]>0) then
                                begin
                                        res:=res+f[24 div (a[i,k]*a[j,k])];
                                        inc(f[a[i,k]*a[j,k]]);
                                end;
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
