const   ginp='vitinh.inp';
        gout='vitinh.out';

var     gi,go:text;
        n,ans:int64;

procedure input;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        read(gi,n);
end;

procedure process;
var     cou,d,c:int64;
begin
        ans:=0;
        cou:=1;
        d:=1;c:=9;
        while n>c do
        begin
                ans:=ans+(c-d+1)*cou;
                d:=c+1;
                c:=10*c+9;
                inc(cou);
        end;
        ans:=ans+cou*(n-d+1);
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
