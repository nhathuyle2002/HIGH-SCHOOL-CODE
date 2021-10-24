const   ginp='one.inp';
        gout='one.out';

var     gi,go:text;
        n,m:longint;
        a:array[0..200010] of longint;

procedure main;
var     i,nho,sum:longint;
begin
        read(gi,n);
        nho:=0;
        m:=0;
        for i:=1 to n do
        begin
                sum:=i+nho;
                inc(m);a[m]:=sum mod 10;
                nho:=sum div 10;
        end;
        for i:=n-1 downto 1 do
        begin
                sum:=i+nho;
                inc(m);a[m]:=sum mod 10;
                nho:=sum div 10;
        end;
        for i:=m downto 1 do write(go,a[i]);
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        main;
        close(gi);close(go);
end.
