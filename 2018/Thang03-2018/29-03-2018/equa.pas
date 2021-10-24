const   ginp='equa.inp';
        gout='equa.out';

var     gi,go:text;
        t:longint;
        a,b:int64;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,t);
end;

procedure process;
var     x:longint;
        dem:int64;
        y:real;
begin
        dem:=1;
        for x:=a*b+1 to 2*a*b-1 do
        begin
                y:=(a*b*x)/(x-a*b);
                if trunc(y)=y then dem:=dem+2;
        end;
        writeln(go,dem);
end;

procedure output;
var     i:longint;
begin
        for i:=1 to t do
        begin
                readln(gi,a,b);
                process;
        end;
        close(gi);close(go);
end;

begin
        input;
        output;
end.
