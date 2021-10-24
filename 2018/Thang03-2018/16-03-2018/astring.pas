const   ginp='astring.inp';
        gout='astring.out';

var     gi,go:text;
        s,t:array[0..1001] of char;
        n,m,k:longint;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n,m,k);
        for i:=1 to n do readln(gi,s[i]);
        readln(gi);
        for i:=1 to m do readln(gi,t[i]);
end;

procedure output;
begin
        close(gi);close(go);
end;

begin
        input;
        proces;
        output;
end.
