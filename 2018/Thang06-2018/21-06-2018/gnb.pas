const   ginp='gnb.inp';
        gout='gnb.out';

var     gi,go:text;
        n,res:longint;
        a:array[0..5001] of longint;
        d:array[-200010..200010] of boolean;

procedure input;
var     i:longint;
begin
        readln(gi,n);
        for i:=1 to n do read(gi,a[i]);
        fillchar(d,sizeof(d),false);
end;

procedure main;
var     i,j:longint;
begin
        res:=0;
        for i:=1 to n do
        begin
                for j:=i-1 downto 1 do
                        if d[a[i]-a[j]] then
                        begin
                                inc(res);break;
                        end;
                for j:=i downto 1 do d[a[i]+a[j]]:=true;
        end;
        write(go,res);
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        input;
        main;
        close(gi);close(go);
end.