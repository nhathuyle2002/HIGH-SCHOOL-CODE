const   ginp='knapsack.inp';
        gout='knapsack.out';

var     gi,go:text;
        n,w1,w2,ans:longint;
        w,v:array[0..100000] of int64;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n,w1,w2);
        for i:=1 to n do readln(gi,w[i],v[i]);
end;

function min(x,y,z:int64):int64;
begin
        min:=x;
        if y<min then min:=y;
        if z<min then min:=z;
end;

procedure process1;
var     i,j,k:longint;
begin
        for i:=0 to n do
                for j:=0 to 5*n do
                        for k:=0 to w1 do f[i,j,k]:=maxlongint;
        f[0,0,0]:=0;
        for i:=1 to n do
                for j:=0 to 5*n do
                        for k:=0 to w1 do
                                if j-v[i]<0 then f[i,j,k]:=f[i-1,j,k]
                                else if k-w[i]<0 then f[i,j,k]:=min(f[i-1,j,k],f[i-1,j-v[i],k]+w[i],maxlongint)
                                else f[i,j,k]:=min(f[i-1,j,k],f[i-1,j-v[i],k-w[i]],f[i-1,j-v[i],k]+w[i]);
        for j:=5*n downto 0 do
                for i:=n downto 1 do
                        for k:=0 to w1 do
                                if f[i,j,k]<=w2 then break;
        ans:=j;
end;

procedure process2;
var     i,j:longint;
begin
end;

procedure output;
begin
        write(go,ans);
        close(gi);close(go);
end;

begin
        input;
        output;
end.
