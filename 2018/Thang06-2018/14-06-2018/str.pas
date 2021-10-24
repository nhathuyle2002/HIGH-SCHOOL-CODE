const   ginp='str.inp';
        gout='str.out';

var     gi,go:text;
        n,res:longint;
        s:ansistring;

procedure main;
var     i:longint;
begin
        readln(gi,s);n:=length(s);
        if s[1]='B' then res:=1 else res:=0;
        for i:=2 to n do
                if (s[i]<>s[i-1]) and (s[i]='B') then inc(res);
        write(go,res);
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        main;
        close(gi);close(go);
end.
