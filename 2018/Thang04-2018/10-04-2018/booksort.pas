const   ginp='booksort.inp';
        gout='booksort.out';

var     gi,go:text;
        n,ans:longint;
        a:array[0..300100] of longint;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n);
        for i:=1 to n do readln(gi,a[i]);
end;

procedure process;
var     i:longint;
begin
        ans:=n;
        for i:=n downto 1 do
                if a[i]=ans then dec(ans);
end;

procedure output;
begin
        write(go,ans);
        close(gi);close(go);
end;

begin
        input;
        process;
        output;
end.

