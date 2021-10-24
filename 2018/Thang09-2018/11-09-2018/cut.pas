const   ginp='cut.inp';
        gout='cut.out';

var     m,n,k,res:int64;

procedure swap(var x,y:int64);
var     tmp:int64;
begin
        tmp:=x; x:=y; y:=tmp;
end;

procedure main;
begin
        read(m,n,k);
        if m>n then swap(m,n);
        if k>m+n-2 then k:=m+n-2;
        if k div 2>m-1 then res:=m*(k-m+2)
        else res:=(k div 2+1)*(k-k div 2+1);
        write(res);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        main;
        close(input);close(output);
end.
