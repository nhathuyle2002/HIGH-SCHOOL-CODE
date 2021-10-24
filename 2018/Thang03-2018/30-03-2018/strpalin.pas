const   ginp='strpalin.inp';
        gout='strpalin.out';

var     gi,go:text;
        s:ansistring;

procedure input;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,s);
end;

function check(l,r:longint):boolean;
var     i,m:longint;
begin
        m:=(l+r) div 2;
        for i:=l to m do
                if s[i]<>s[r-i+l] then exit(false);
        exit(true);
end;

procedure process;
var     i,k,l,r:longint;
begin
        readln(gi,k);
        for i:=1 to k do
        begin
                readln(gi,l,r);
                if check(l,r) then writeln(go,1) else writeln(go,-1);
        end;
end;

procedure output;
begin
        close(gi);close(go);
end;

begin
        input;
        process;
        output;
end.
