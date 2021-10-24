const   ginp='diophantine.inp';
        gout='diophantine.out';

var     a,b,c,res:int64;

function uc(x,y:int64):int64;
begin
        if y=0 then exit(x);
        uc:=uc(y,x mod y);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        read(a,b,c);

        close(input);close(output);
end.
