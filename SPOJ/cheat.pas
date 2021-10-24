const   ginp='ss.inp';
        gout='ss.out';

var     gi,go:text;
        n,r:longint;
        a,s:array[0..100010] of longint;

procedure main;
var     i,l:longint;
begin
        readln(gi,n);
        l:=1;
        for i:=1 to n do readln(gi,a[i]);
        for i:=1 to n do
        begin
                inc(r);s[r]:=i;
                while (s[r]=a[l]) and (r>0) do
                begin
                        dec(r);
                        inc(l);
                end;
        end;
        if r=0 then write(go,'NO')
        else write(go,'YES');
end;

begin
        assign(gi,ginp);reset(gi);
        assign(go,gout);rewrite(go);
        main;
        close(gi);close(go);
end.
