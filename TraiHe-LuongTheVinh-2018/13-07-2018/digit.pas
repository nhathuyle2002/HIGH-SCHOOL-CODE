const   ginp='digit.inp';
        gout='digit.out';

var     a,b,sk,sd:qword;

function md(x,y:qword):qword;
begin
        if x=0 then exit(0);
        //md:=(md(x div 10,10*y mod b)+(x mod 10)*y mod b) mod b;
        md:=(md(x shr 1,2*y mod b)+(x and 1)*y mod b) mod b;
end;

function power(k:qword):qword;
var     d:qword;
begin
        if k=0 then exit(1 mod b);
        d:=power(k shr 1);
        power:=md(d,d);
        if k and 1=1 then power:=power*10 mod b;
end;

procedure main;
begin
        read(a,b,sk);
        sd:=power(sk-1);
        write(md(a,sd)*10 div b);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        main;
        close(input);close(output);
end.
