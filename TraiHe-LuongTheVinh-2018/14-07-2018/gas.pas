const   ginp='gas.inp';
        gout='gas.out';
        oo=trunc(1e9)+100;

var     k,n,l,r:longint;
        res:int64;
        a,d:array[0..1000010] of longint;

procedure main;
var     i:longint;
begin
        readln(n,k);
        l:=1;r:=1;d[1]:=0;a[0]:=oo;
        for i:=1 to n do
        begin
                read(a[i]);
                while (l<=r) and (d[l]<=i-k) do inc(l);
                while (l<=r) and (a[i]<=a[d[r]]) do dec(r);
                inc(r);d[r]:=i;
                res:=res+a[d[l]];
        end;
        write(res);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        main;
        close(input);close(output);
end.