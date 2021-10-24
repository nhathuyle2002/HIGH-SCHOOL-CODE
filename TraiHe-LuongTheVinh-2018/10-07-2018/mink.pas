const   ginp='mink.inp';
        gout='mink.out';
        oo=trunc(1e9)+1;

var     n,k,l,r,st:longint;
        a,d:array[0..1000010] of longint;

procedure pop(i:longint);
begin
        while (l<=r) and (d[l]<=i) do inc(l);
end;

procedure push(i:longint);
begin
        while (l<=r) and (a[i]<=a[d[r]]) do dec(r);
        inc(r);d[r]:=i;
end;

procedure main;
var     i:longint;
begin
        readln(n,k);
        l:=1;r:=1;d[1]:=0;a[0]:=oo;
        for i:=1 to k-1 do
        begin
                read(a[i]);push(i);
        end;
        for i:=k to n do
        begin
                read(a[i]);
                pop(i-k);push(i);
                write(a[d[l]],' ');
        end;
        readln;writeln;
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        readln(st);
        while st>0 do
        begin
                main;
                dec(st);
        end;
        close(input);close(output);
end.