const   ginp='c2snt.inp';
        gout='c2snt.out';

var     a,b,n:int64;

function pow(k:int64):int64;
var     c:int64;
begin
        if k=0 then exit(1);
        c:=pow(k shr 1);
        pow:=c*c mod b;
        if k and 1=1 then pow:=pow*10 mod b;
end;

procedure process;
var     i:longint;
begin
        readln(a);
        readln(b);
        read(n);
        a:=a*pow(n-1)*10 div b;
        write(a mod 10);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        process;
        close(input);close(output);
end.
