const   ginp='daycon.inp';
        gout='daycon.out';
        oo=trunc(1e13);

var     n:longint;
        res,sum,min:int64;

procedure process;
var     i,x:longint;
begin
        sum:=0;min:=0;res:=-oo;
        readln(n);
        for i:=1 to n do
        begin
                read(x);
                sum:=sum+x;
                if sum-min>res then res:=sum-min;
                if sum<min then min:=sum;
        end;
        write(res);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        process;
        close(input);close(output);
end.
