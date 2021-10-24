const   ginp='cowfind.inp';
        gout='cowfind.out';

var     n,cou:longint;
        res:int64;
        a:ansistring;

procedure main;
var     i:longint;
begin
        read(a); n:=length(a);
        cou:=0; res:=0;
        for i:=2 to n do
        begin
                if (a[i]='(') and (a[i-1]='(') then inc(cou);
                if (a[i]=')') and (a[i-1]=')') then res:=res+cou;
        end;
        write(res);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        main;
        close(input);close(output);
end.
