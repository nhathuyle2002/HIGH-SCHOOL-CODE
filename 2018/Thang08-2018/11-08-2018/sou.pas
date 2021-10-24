const   ginp='sou.inp';
        gout='sou.out';
        base=trunc(1e7)+7;

var     n:longint;
        cou,res:int64;
        d,dd:array[0..1000010] of longint;

procedure create;
var     i,j:longint;
begin
        for i:=2 to n do
                if dd[i]=0 then
                begin
                        dd[i]:=i;
                        for j:=i to n div i do dd[i*j]:=i;
                end;
end;

procedure process;
var     i,ii:longint;
        sum,tm:int64;
begin
        for i:=2 to n do
        begin
                ii:=i;
                while ii>1 do
                begin
                        d[dd[ii]]:=(d[dd[ii]]+1) mod base;
                        ii:=ii div dd[ii];
                end;
        end;
        cou:=1;res:=1;
        for i:=2 to n do
        begin
                cou:=cou*(d[i]+1) mod base;
                tm:=1;sum:=1;
                for ii:=1 to d[i] do
                begin
                        tm:=tm*i mod base;
                        sum:=(sum+tm) mod base;
                end;
                res:=res*sum mod base;
        end;
        writeln(cou);
        writeln(res);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        readln(n);
        create;
        process;
        close(input);close(output);
end.
