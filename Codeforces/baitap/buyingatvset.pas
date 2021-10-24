Const   ginp='ss.inp';
        gout='ss.out';

Var     a,b,x,y:int64;

function gcd(aa,bb:int64):int64;
begin
        if bb=0 then gcd:=aa else
        gcd:=gcd(bb,aa mod bb);
end;

Procedure Process;
var     tmp,re1,re2:int64;
Begin
        read(a,b,x,y);
        tmp:=gcd(x,y);
        x:=x div tmp; y:=y div tmp;
        re1:=a div x; re2:=b div y;
        if re1<re2 then write(re1) else write(re2);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Process;
        Close(input); Close(output);
End.
