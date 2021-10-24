const   ginp='substrng.in';
        gout='substrng.out';

var     n,k,rl,rr:longint;
        a:ansistring;
        d:array['a'..'z'] of longint;

procedure enter;
begin
        readln(n,k);
        read(a);
end;

procedure process;
var     l,r:longint;
begin
        rl:=0;rr:=0;
        l:=0;
        for r:=1 to n do
        begin
                inc(d[a[r]]);
                while d[a[r]]>k do
                begin
                        inc(l);
                        dec(d[a[l]]);
                end;
                if r-l>rr-rl then
                begin
                        rr:=r;rl:=l;
                end;
        end;
        write(rr-rl,' ',rl+1);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        process;
        close(input);close(output);
end.
