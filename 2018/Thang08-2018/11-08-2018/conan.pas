const   ginp='conan.inp';
        gout='conan.out';
        maxIQ=trunc(1e16)+1;
        maxn=10010;

var     n,m,st:longint;
        t,p:array[0..maxn] of longint;
        y,r,z:array[0..maxn] of int64;

procedure Enter;
var     i:longint;
begin
        read(n);
        for i:=1 to n do read(t[i],y[i]);readln;
        read(m);
        for i:=1 to m do read(p[i],r[i],z[i]);readln;
end;

function Check(cp:int64):boolean;
var     i,j:longint;
begin
        i:=0;j:=1;
        repeat
                inc(i);
                while (j<=m) and (p[j]<=t[i]) do
                begin
                        if cp>=r[j] then cp:=cp+z[j];
                        inc(j);
                end;
                cp:=cp-y[i];
                if cp<=0 then exit(false);
        until i=n;
        exit(true);
end;

procedure Process;
var     left,right,mid:int64;
begin
        left:=1;right:=maxIQ;
        while left<right do
        begin
                mid:=(left+right) shr 1;
                if Check(mid) then right:=mid else left:=mid+1;
        end;
        writeln(left);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        readln(st);
        while st>0 do
        begin
                enter;
                process;
                dec(st);
        end;
        close(input);close(output);
end.
