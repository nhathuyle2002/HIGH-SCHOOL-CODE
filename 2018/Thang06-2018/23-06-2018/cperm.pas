const   ginp='cperm.inp';
        gout='cperm.out';
        kk=round(1e9)+7;

var     gi,go:text;
        st,n:longint;

function ccl(i:longint):int64;
var     tm:int64;
begin
        if i=1 then exit(2);
        tm:=ccl(i shr 1);
        if i mod 2=0 then ccl:=(tm*tm) mod kk
        else ccl:=(tm*tm*2) mod kk;
end;

procedure main;
begin
        readln(gi,st);
        while st>0 do
        begin
                readln(gi,n);
                if (n<=2) then writeln(go,0) else
                writeln(go,(ccl(n-1)-2+kk) mod kk);
                dec(st);
        end;
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        main;
        close(gi);close(go);
end.
