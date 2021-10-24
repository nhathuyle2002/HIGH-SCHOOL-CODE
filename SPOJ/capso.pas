const   ginp='capso.inp';
        gout='capso.out';
        maxu=100000;

var     n,mm:longint;
        res:int64;

function min(x,y:longint):longint;
begin
        if x<y then min:=x else min:=y;
end;

procedure enter;
begin
        read(n);
end;

procedure process;
var     i,v,vv:longint;
begin
        res:=0;
        mm:=min(n,maxu);
        for i:=1 to n do
                if n div i<mm then break else
                res:=res+n div i;
        vv:=n;
        for i:=2 to mm do
        begin
                v:=n div i;
                res:=res+int64(vv-v)*(i-1);
                vv:=v;
        end;
        write(res);
end;

begin
        assign(input,ginp); assign(output,gout);
        reset(input); rewrite(output);
        enter;
        process;
        close(input); close(output);
end.