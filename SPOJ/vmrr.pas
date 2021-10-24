const   ginp='ss.inp';
        gout='ss.out';

var     gi,go:text;
        x,y:char;
        s:ansistring;
        coux:longint;
        res:int64;

procedure input;
var     ss:ansistring;
        i:longint;
begin
        readln(gi,s);
        read(gi,ss);
        i:=1;
        while ss[i]=' ' do inc(i);x:=ss[i];inc(i);
        while ss[i]=' ' do inc(i);y:=ss[i];
end;

procedure process;
var     i:longint;
begin
        res:=0;
        coux:=0;
        for i:=1 to length(s) do
        begin
                if s[i]=y then res:=res+coux;
                if s[i]=x then inc(coux);
        end;
        write(go,res);
end;

begin
        assign(gi,ginp);reset(gi);
        assign(go,gout);rewrite(go);
        input;
        process;
        close(gi);close(go);
end.
