const   ginp='mcows.inp';
        gout='mcows.out';

var     gi,go:text;
        n,dem:int64;

procedure input;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        read(gi,n);
end;

procedure process;
var     tmp1,tmp2:int64;
        st:longint;
begin
        st:=1;
        tmp1:=1;
        tmp2:=9;
        while (tmp2<n) do
        begin
                dem:=dem+(tmp2-tmp1+1)*st;
                tmp1:=tmp1*10;
                tmp2:=tmp2*10+9;
                inc(st);
        end;
        dem:=dem+(n-tmp1+1)*st;
end;

procedure output;
begin
        write(go,dem);
        close(gi);close(go);
end;

begin
        input;
        process;
        output;
end.
