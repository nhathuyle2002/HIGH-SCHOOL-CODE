const fo= 'REL.INP';

var   f:text;
        n, m, ta, tb, i,t :longint;
        a:array[1..100000] of longint;

begin
        assign(f,fo); rewrite(f);
        randomize;

        n:= 10; m:=15;


        writeln(f,n,' ',m);
        randomize;
        for i:= 1 to n do a[i]:= random(20)+1;

        for i:=1 to m do
        begin
                if i = m then
                        inc(ta);
                ta := random(n)+1;
                tb := random(n)+1;
                t := random(2);
                if a[ta] < a[tb] then
                begin
                        if (t = 0) then writeln(f,ta,'<',tb)
                        else writeln(f,ta,'<=',tb);
                end
                else if (a[ta] > a[tb]) then
                begin
                        if (t = 0) then writeln(f,ta,'>',tb)
                        else writeln(f,ta,'>=',tb);
                end
                else writeln(f,ta,'=',tb);
        end;

        close(f);
end.
