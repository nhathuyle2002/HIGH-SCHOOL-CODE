const   ginp='txau.inp';
        gout='txau.out';

procedure main;
var     gi,go:text;
        sum:int64;
        //i:longint;
        x:char;
        //s:ansistring;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        sum:=0;
        while not eoln(gi) do
        begin
                read(gi,x);
                if (x>='0') and (x<='9') then sum:=sum+ord(x)-48
                else write(go,x);
        end;
        {read(gi,s);
        for i:=1 to length(s) do
        begin
                if (s[i]>='0') and (s[i]<='9') then sum:=sum+ord(s[i])-48
                else write(go,s[i]);
        end;}
        writeln(go);
        write(go,sum);
        close(gi);close(go);
end;

begin
        main;
end.
