const   ginp='game.inp';
        gout='game.out';

var     gi,go:text;
        st,n:longint;
        a,f:array[0..100010] of longint;

procedure input;
var     i:longint;
begin
        readln(gi,n);
        for i:=1 to n do read(gi,a[i]);
        readln(gi);
end;

procedure process;
var     i,cou:longint;
begin
        f[0]:=0;a[0]:=0;
        for i:=1 to n do
                if a[i]>a[f[i-1]] then f[i]:=i else f[i]:=f[i-1];
        i:=n;cou:=0;
        while i>0 do
        begin
                inc(cou);
                i:=f[i]-1;
        end;
        if cou mod 2=1 then writeln(go,'BOB') else writeln(go,'ANDY');
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,st);
        while st>0 do
        begin
                input;
                process;
                dec(st);
        end;
        close(gi);close(go);
end.