const   ginp='hinhvuong.inp';
        gout='hinhvuong.out';

var     gi,go:text;
        x:int64;
        n:longint;
        luu:array[1..2,0..10001000] of int64;

procedure input;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        read(gi,x);
end;

procedure process;
var     tm,tmp:int64;
        i:longint;
begin
        x:=6*x;
        tm:=trunc(exp(ln(x)/3));
        for i:=1 to tm do
                if x mod (int64(i)*(i+1))=0 then
                begin
                        tmp:=x div (int64(i)*(i+1));
                        tmp:=tmp-1+i;
                        if (tmp mod 3=0) and (tmp div 3>=i) then
                        begin
                                inc(n);
                                luu[1,n]:=i;
                                luu[2,n]:=tmp div 3;
                        end;
                end;
end;

procedure output;
var     i:longint;
begin
        if luu[1,n]<>luu[2,n] then writeln(go,2*n) else writeln(go,2*n-1);
        for i:=1 to n do writeln(go,luu[1,i],' ',luu[2,i]);
        if luu[1,n]=luu[2,n] then dec(n);
        for i:=n downto 1 do writeln(go,luu[2,i],' ',luu[1,i]);
        close(gi);close(go);
end;

begin
        input;
        process;
        output;
end.



