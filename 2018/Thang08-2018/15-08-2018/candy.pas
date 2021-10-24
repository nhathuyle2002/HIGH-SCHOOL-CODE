const   ginp='candy.inp';
        gout='candy.out';

var     n,k:longint;
        res:int64;

procedure main;
var     i,x,y:longint;
begin
        read(n,k);
        res:=0;
        if k=1 then res:=1 else
        if k=2 then res:=(n-1) div 2 else
        if k=3 then
        begin
                for x:=1 to (n-3) div 3 do
                        res:=res+(n-x-1) div 2-x;
        end else
        begin
                for x:=1 to (n-6) div 4 do
                        for y:=x+1 to (n-x-3) div 3 do
                                res:=res+(n-y-x-1) div 2-y;
        end;
        write(res);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        main;
        close(input);close(output);
end.
