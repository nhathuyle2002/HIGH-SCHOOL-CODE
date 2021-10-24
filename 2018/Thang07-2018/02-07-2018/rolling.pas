const   ginp='rolling.inp';
        gout='rolling.out';
        s:array[0..4] of longint=(0,6,10,11,14);

var     n,k,res,tm:qword;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        read(n,k);
        tm:=k div 4*s[4]+s[k mod 4];
        res:=n div k*tm;
        k:=n mod k;
        tm:=k div 4*s[4]+s[k mod 4];
        res:=res+tm;
        write(res);
        close(input);close(output);
end.
