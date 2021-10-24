const   ginp='solve.inp';
        gout='solve.out';

var     gi,go:text;
        n,x:int64;

procedure input;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n);
end;

function tong(a:int64):int64;
begin
        tong:=0;
        while a<>0 do
        begin
                tong:=tong+a mod 10;
                a:=a div 10;
        end;
end;

procedure process;
var     i,tmp,dem,tmp2:int64;
begin
        x:=-1;
        dem:=0;
        i:=trunc(sqrt(n));
        repeat
                if n mod i=0 then
                begin
                        tmp:=n div i-i;
                        tmp2:=tong(i);
                        if tmp=tmp2 then x:=i;
                end;
                dec(i);
                inc(dem);
        until (dem>162) or (i<=0);
end;

procedure output;
begin
        write(go,x);
        close(gi);close(go);
end;

begin
        input;
        process;
        output;
end.
