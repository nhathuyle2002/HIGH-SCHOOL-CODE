const   ginp='omega.inp';
        gout='omega.out';
        oo=trunc(1e17);

var     n,m,res:longint;
        sres:int64;
        f:array[0..451,0..451] of int64;

function min(x,y:int64):int64;
begin
        if x<y then exit(x) else exit(y);
end;

procedure enter;
var     i,j,u,v:longint;
        c:int64;
begin
        readln(n,m);
        for i:=1 to n do
                for j:=1 to n do
                        if i=j then f[i,j]:=0 else f[i,j]:=oo;
        for i:=1 to m do
        begin
                readln(u,v,c);
                f[u,v]:=min(f[u,v],c);
                f[v,u]:=f[u,v];
        end;
end;

procedure process;
var     i,j,k:longint;
        sum:int64;
begin
        for k:=1 to n do
                for i:=1 to n do
                        for j:=1 to n do
                                f[i,j]:=min(f[i,j],f[i,k]+f[k,j]);
        res:=0;sres:=oo;
        for i:=1 to n do
        begin
                sum:=0;
                for j:=1 to n do
                        sum:=sum+f[i,j];
                if sum<sres then
                begin
                        res:=1;
                        sres:=sum;
                end else
                if sum=sres then inc(res);
        end;
        if sres=oo then write(0) else write(sres,' ',res);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        process;
        close(input);close(output);
end.
