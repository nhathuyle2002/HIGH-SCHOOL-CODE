const   ginp='frac.inp';
        gout='frac.out';

var     gi,go:text;
        n,m,ans:int64;

procedure input;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        read(gi,m,n);
end;

function ltl(x:real):int64;
begin
        exit(trunc(x)+1);
end;

function ltx(x:real):int64;
begin
        if trunc(x)=x then exit(trunc(x)-1);
        exit(trunc(x));
end;

procedure process;
var     i:longint;
        tmp1,tmp2:int64;
begin
        ans:=0;
        for i:=1 to n-1 do
        begin
                tmp1:=ltl(m/(n+i));
                tmp2:=ltx(2*m/(n+i));
                ans:=ans+tmp2-tmp1+1;
        end;
end;

procedure output;
begin
        write(go,ans);
        close(gi);close(go);
end;

begin
        input;
        process;
        output;
end.
