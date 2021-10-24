const   ginp='bracket.inp';
        gout='bracket.out';

var     gi,go:text;
        n:longint;
        a:array[0..10010] of longint;
        s:ansistring;
        f:array[0..10010,0..10010] of longint;

procedure input;
var     i:longint;
begin
        read(gi,s);
        n:=length(s);
        for i:=1 to n do
                if s[i]='(' then a[i]:=a[i-1]+1 else a[i]:=a[i-1]-1;
end;

procedure process;
var     i,j:longint;
begin
        f[0,0]:=1;
        for i:=1 to n do
        begin
                f[i,0]:=f[i-1,0];
                if s[i]=')' then f[i,0]:=(f[i,0]+f[i-1,1]) mod 2012;
                for j:=1 to a[i] do
                        if s[i]='(' then f[i,j]:=(f[i-1,j]+f[i-1,j-1]) mod 2012
                        else f[i,j]:=(f[i-1,j]+f[i-1,j+1]) mod 2012;
        end;
        write(go,f[n,0]);
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        input;
        process;
        close(gi);close(go);
end.
