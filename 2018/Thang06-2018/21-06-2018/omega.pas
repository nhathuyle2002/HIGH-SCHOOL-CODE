const   ginp='omega.inp';
        gout='omega.out';
        oo=trunc(1e15);

var     gi,go:text;
        n:longint;
        res,sum:int64;
        f:array[0..500,0..500] of int64;

function min(x,y:int64):int64;
begin
        if x<y then exit(x) else exit(y);
end;

procedure main;
var     i,j,k,m,u,v,c:longint;
        tm:int64;
begin
        readln(gi,n,m);
        for i:=1 to n do
                for j:=1 to n do f[i,j]:=oo;
        for i:=1 to n do f[i,i]:=0;
        for i:=1 to m do
        begin
                readln(gi,u,v,c);
                f[u,v]:=min(f[u,v],c);
                f[v,u]:=min(f[v,u],c);
        end;
        for k:=1 to n do
                for i:=1 to n do
                        for j:=1 to n do
                                f[i,j]:=min(f[i,j],f[i,k]+f[k,j]);
        res:=0;sum:=oo;
        for i:=1 to n do
        begin
                tm:=0;
                for j:=1 to n do inc(tm,f[i,j]);
                if (sum=tm) and (sum<>oo) then inc(res);
                if tm<sum then
                begin
                        res:=1;sum:=tm;
                end;
        end;
        if res=0 then write(go,0)
        else write(go,sum,' ',res);
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        main;
        close(gi);close(go);
end.


