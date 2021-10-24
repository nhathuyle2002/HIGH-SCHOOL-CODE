const   ginp='nearest.inp';
        gout='nearest.out';

var     n,l,r:longint;
        a,ft,fs,d:array[0..1000010] of longint;

procedure main;
var     i:longint;
begin
        readln(n);
        for i:=1 to n do read(a[i]);
        r:=1;
        for i:=1 to n do
        begin
                while (r>0) and (a[d[r]]<a[i]) do
                begin
                        fs[d[r]]:=i;
                        dec(r);
                end;
                if a[i]=a[d[r]] then ft[i]:=ft[d[r]] else ft[i]:=d[r];
                inc(r);d[r]:=i;
        end;
        for i:=1 to n do writeln(ft[i],' ',fs[i]);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        main;
        close(input);close(output);
end.