const   ginp='highcard.inp';
        gout='highcard.out';

var     n,st,cou,res:longint;
        d:array[0..100010] of boolean;

procedure process;
var     i,x:longint;
begin
        fillchar(d,sizeof(d),false);
        for i:=1 to n do
        begin
                read(x);
                d[x]:=true;
        end;
        readln;
        cou:=0;res:=0;
        for i:=2*n downto 1 do
                if d[i]=false then inc(cou) else
                if cou>0 then
                begin
                        inc(res);
                        dec(cou);
                end;
        writeln(res);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        readln(n,st);
        while st>0 do
        begin
                process;
                dec(st);
        end;
        close(input);close(output);
end.
