const   ginp='ss.inp';
        gout='ss.out';

var     gi,go:text;
        n,m,res:longint;
        a,b:ansistring;
        s:array[1..52] of longint;
        f:array[0..3000100,1..52] of longint;

function ms(x:char):longint;inline;
begin
        if x<='Z' then exit(ord(x)-64)
        else exit(ord(x)-70);
end;

procedure main;
var     i,j:longint;
        ok:boolean;
begin
        readln(gi,n,m);
        readln(gi,a);
        readln(gi,b);
        for i:=1 to n do inc(s[ms(a[i])]);
        res:=0;
        for i:=1 to m do
        begin
                if i>=n then ok:=true else ok:=false;
                for j:=1 to 52 do
                begin
                        f[i,j]:=f[i-1,j];
                        if j=ms(b[i]) then inc(f[i,j]);
                        if i>=n then
                                if f[i,j]-f[i-n,j]<>s[j] then ok:=false;
                end;
                if ok then inc(res);
        end;
        write(go,res);
end;

begin
        assign(gi,ginp);reset(gi);
        assign(go,gout);rewrite(go);
        main;
        close(gi);close(go);
end.
