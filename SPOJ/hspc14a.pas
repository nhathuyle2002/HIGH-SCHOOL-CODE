const   ginp='ss.inp';
        gout='ss.out';

var     gi,go:text;
        n,ans,kq:longint;

function check(x,y:longint):longint;
begin
        if x=0 then exit(y);
        kq:=kq+y div x;
        exit(check(y mod x,x));
end;

function min(x,y:longint):longint;
begin
        if x<y then exit(x) else exit(y);
end;

procedure main;
var     i,j,tm,t:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,t);
        for j:=1 to t do
        begin
                readln(gi,n);
                ans:=0;
                if n<>1 then
                begin
                        ans:=n-1;
                        for i:=n div 2 to n-1 do
                        begin
                                kq:=0;
                                if check(i,n)=1 then ans:=min(ans,kq-1);
                        end;
                end;
                writeln(go,ans);
        end;
        close(gi);close(go);
end;

begin
        main;
end.
