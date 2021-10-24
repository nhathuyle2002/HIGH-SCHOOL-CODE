const   ginp='socola.inp';
        gout='socola.out';

var     gi,go:text;
        n,m,uc:longint;
        ans:int64;

procedure input;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        read(gi,m,n);
end;

procedure gcd;
var     x,y,tmp:longint;
begin
        x:=m;
        y:=n;
        while x<>0 do
        begin
                tmp:=x;
                x:=y mod x;
                y:=tmp;
        end;
        uc:=y;
end;

procedure swap(var x,y:longint);
var     tmp:longint;
begin
        tmp:=x;
        x:=y;
        y:=tmp;
end;

procedure output;
begin
        write(go,ans);
        close(gi);close(go);
end;

procedure process;
var     mm,nn:longint;
begin
        if m>n then swap(m,n);
        gcd;
        mm:=m div uc;
        nn:=n div uc;
        ans:=(mm+nn-1)*uc;
end;

begin
        input;
        process;
        output;
end.
