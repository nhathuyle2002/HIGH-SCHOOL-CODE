const   ginp='ss.inp';
        gout='ss.out';

var     gi,go:text;
        n,a,b,res:longint;

function uc(x,y:longint):longint;
begin
        if y=0 then exit(x);
        uc:=uc(y,x mod y);
end;

procedure main;
var     i,x,xx:longint;
begin
        read(gi,a,b);
        res:=0;
        for i:=a to b do
        begin
                x:=0;xx:=i;
                while xx<>0 do
                begin
                        x:=x*10+xx mod 10;
                        xx:=xx div 10;
                end;
                if uc(x,i)=1 then inc(res);
        end;
        write(go,res);
end;

begin
        assign(gi,ginp);reset(gi);
        assign(go,gout);rewrite(go);
        main;
        close(gi);close(go);
end.
