const   ginp='count.inp';
        gout='count.out';

var     gi,go:text;
        ans:int64;
        n:longint;

////////////////////

function timuc(x,y:int64):int64;
begin
        if x=0 then exit(y);
        exit(timuc(y mod x,x));
end;

////////////////////

procedure process;
var     i,tm,x:longint;
begin
        ans:=0;
        x:=trunc(sqrt(n));
        for i:=1 to x do
                ans:=ans+(n div i);
        x:=x+1;
        while x<=n do
        begin
                i:=n div x;
                tm:=n div i;
                ans:=ans+(tm-x+1)*i;
                x:=tm+1;
        end;
end;

//////////////////////

procedure main;
var     i,t:longint;
        y,uc:int64;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,t);
        for i:=1 to t do
        begin
                readln(gi,n);
                process;
                y:=int64(n)*n;
                uc:=timuc(ans,y);
                writeln(go,ans div uc,'/',y div uc);
        end;
        close(gi);close(go);
end;

//////////////////////

begin
        main;
end.

