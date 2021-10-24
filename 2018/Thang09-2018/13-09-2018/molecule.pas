const   ginp='molecule.inp';
        gout='molecule.out';

var     res:longint;
        a:ansistring;

procedure main;
var     i,cB,cW:longint;
begin
        read(a); a:='#'+a;
        cB:=0; cW:=0;
        for i:=2 to length(a) do
                if a[i]<>a[i-1] then
                begin
                        if a[i]='W' then inc(cW) else inc(cB);
                end;
        if cW<cB then res:=cW-1 else res:=cB-1;
        if res<0 then res:=0;
        write(res);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        main;
        close(input);close(output);
end.
