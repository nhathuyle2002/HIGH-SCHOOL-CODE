const   ginp='camera.inp';
        gout='camera.out';

var     gi,go:text;
        n:longint;
        r:real;
        d:array[0..101] of real;
        f:array[0..101] of longint;

procedure main;
var     i,j:longint;
        tm:real;
begin
        readln(gi,n,r);
        for i:=1 to n do readln(gi,d[i]);
        for i:=1 to n-1 do
                for j:=i+1 to n do
                        if d[i]>d[j] then
                        begin
                                tm:=d[i];d[i]:=d[j];d[j]:=tm;
                        end;
        r:=2*r;
        for i:=1 to n do
        begin
                for j:=i-1 downto 0 do
                        if d[i]-d[j]>r then break;
                f[i]:=f[j]+1;
        end;
        write(go,f[n]);
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        main;
        close(gi);close(go);
end.