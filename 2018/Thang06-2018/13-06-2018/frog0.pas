const   ginp='frog.inp';
        gout='frog.out';

var     gi,go:text;
        m,n,k,l,r:longint;
        q:array[0..1001] of int64;
        v:array[0..1001] of longint;
        a,trace:array[0..1001,0..1001] of longint;
        f:array[0..1001,0..1001] of int64;

procedure input;
var     i,j:longint;
begin
        readln(gi,m,n,k);
        for i:=1 to m do
        begin
                for j:=1 to n do read(gi,a[i,j]);
                readln(gi);
        end;
end;

procedure pop(j:longint);
begin
        while (l<=r) and (v[l]<j) do inc(l);
end;

procedure push(i,j:longint);
begin
        while (l<=r) and (q[r]<=f[i,j]) do dec(r);
        inc(r);q[r]:=f[i,j];v[r]:=j;
end;

procedure process;
var     i,j,dem,vt:longint;
        ou:array[0..1001] of longint;
begin
        for i:=1 to m do
        begin
                l:=1;r:=1;
                for j:=1 to k do
                        if j<=n then push(i-1,j);
                for j:=1 to n do
                begin
                        pop(j-k);
                        if j+k<=n then push(i-1,j+k);
                        f[i,j]:=q[l]+a[i,j];
                        trace[i,j]:=v[l];
                end;
        end;
        vt:=1;
        for j:=2 to n do
                if f[m,j]>f[m,vt] then vt:=j;
        dem:=0;
        i:=m;j:=vt;
        writeln(go,f[i,j]);
        repeat
                inc(dem);ou[dem]:=j;
                j:=trace[i,j];
                dec(i);
        until i=0;
        for i:=dem downto 1 do writeln(go,ou[i],' ');
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        input;
        process;
        close(gi);close(go);
end.