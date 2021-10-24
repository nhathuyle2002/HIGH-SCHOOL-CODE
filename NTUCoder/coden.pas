const   ginp='ss.inp';
        gout='ss.out';

var     m,n,res:int64;

procedure process;
begin
        read(m,n);
        res:=(m div 2+m mod 2)*(n div 2+n mod 2);
        //if (m and 1=1) and (n and 1=1) then dec(res);
        write(res);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        process;
        close(input);close(output);
end.
