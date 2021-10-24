const   ginp='intsle.inp';
        gout='intsle.out';

var     st:longint;
        a1,b1,c1,a2,b2,c2:int64;
        dx,dy,d:int64;
        x,y:real;

function uc(a,b:int64):int64;
begin
        if b=0 then exit(a);
        uc:=uc(b,a mod b);
end;

procedure main;
begin
        readln(a1,b1,c1,a2,b2,c2);
        d:=a1*b2-a2*b1;
        dx:=c1*b2-c2*b1;
        dy:=a1*c2-a2*c1;
        if d=0 then
        begin
                if (dx<>0) or (dy<>0) then writeln('NO SOLUTION') else
                if ((c1 mod uc(a1,b1)=0) and (c2 mod uc(a2,b2)=0)) then write('INFINITE') else write('NO SOLUTION');
        end else
        begin
                x:=dx/d;y:=dy/d;
                if (x=trunc(x)) and (y=trunc(y)) then writeln(trunc(x),' ',trunc(y))
                else writeln('NO SOLUTION');
        end;
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        readln(st);
        while st>0 do
        begin
                main;
                dec(st);
        end;
        close(input);close(output);
end.
