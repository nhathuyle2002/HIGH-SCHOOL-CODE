const   ginp='ss.inp';
        gout='ss.out';

var     gi,go:text;
        n:longint;
        p:ansistring;
        f,a:array[0..250] of ansistring;

procedure input;
var     i:longint;
begin
        readln(gi,n);
        read(gi,p);
        a[0]:=1;
        for i:=1 to n do a[i]:=nhan(a[i-1],2);
end;

procedure process;
var     :longint;
begin

end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        input;
        process;
        close(gi);close(go);
end.
