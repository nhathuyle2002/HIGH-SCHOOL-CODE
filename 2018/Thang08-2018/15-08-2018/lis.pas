uses    math;

const   ginp='lis.inp';
        gout='lis.out';
        oo=trunc(1e8);

var     n:longint;
        res,gmax,sum:int64;

procedure main;
var     i:longint;
        x:int64;
begin
        readln(n);
        res:=oo;gmax:=0;sum:=0;
        for i:=1 to n do
        begin
                read(x);
                sum:=sum+x;
                res:=min(res,sum-gmax);
                gmax:=max(gmax,sum);
        end;
        write(res);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        main;
        close(input);close(output);
end.
