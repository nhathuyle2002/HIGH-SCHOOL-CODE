const   ginp='sumdiv.inp';
        gout='sumdiv.out';
        mg=100000;

var     res:int64;
        n:longint;

procedure main2;
var     i:longint;
begin
        for i:=1 to n do res:=res+n div i;
        writeln(res);
end;

procedure main;
var     i:longint;
begin
        read(n);
        main2;
        res:=0;
        for i:=1 to mg do
                res:=res+int64(i)*(n div i-n div (i+1));
        for i:=1 to mg do
        begin
                if i>n div mg then break;
                res:=res+n div i;
        end;
        write(res);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        main;
        close(input);close(output);
end.
