// ~~ Best ~~ //

const   ginp='ps.inp';
        gout='ps.out';

var     p,q:longint;

procedure try(x,y,u,v:longint);
var     k,h:longint;
begin
        k:=x+u;h:=y+v;
        if k/h=p/q then exit;
        if k/h>p/q then
        begin
                write('L');
                try(x,y,k,h);
        end else
        begin
                write('R');
                try(k,h,u,v);
        end;
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        while not seekeoln do
        begin
                readln(p,q);
                if (p=1) and (q=1) then break;
                //if p/q<1 then try(0,1,1,1) else try(1,1,1,0);
                try(0,1,1,0);
                writeln;
        end;
        close(input);close(output);
end.
