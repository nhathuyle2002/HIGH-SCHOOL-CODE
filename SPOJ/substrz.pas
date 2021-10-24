const   ginp='ss.inp';
        gout='ss.out';

var     gi,go:text;
        n,m:longint;
        a,b:ansistring;
        z:array[0..2000010] of longint;

function min(x,y:longint):longint;
begin
        if x<y then exit(x) else exit(y);
end;

procedure main;
var     i,l,r:longint;
begin
        readln(gi,a);
        read(gi,b);m:=length(b);
        a:=b+'*'+a;n:=length(a);
        l:=m+1;r:=m;
        for i:=m+2 to n-m+1 do
        begin
                if i<=r then z[i]:=min(r-i+1,z[i-l+1]);
                while (i+z[i]<=n) and (a[1+z[i]]=a[i+z[i]]) do inc(z[i]);
                if r<i+z[i]-1 then
                begin
                        l:=i;r:=i+z[i]-1;
                end;
                if z[i]=m then write(go,i-m-1,' ');
        end;
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        main;
        close(gi);close(go);
end.
