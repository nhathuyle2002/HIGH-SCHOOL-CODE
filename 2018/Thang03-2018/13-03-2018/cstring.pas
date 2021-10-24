const   ginp='cstring.inp';
        gout='cstring.out';
        kk=1000000007;

var     gi,go:text;
        n:longint;
        s,p:ansistring;
        f:array[0..2001,0..2001] of int64;

procedure input;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,s);
        read(gi,p);
end;

procedure process;
var     i,j:longint;
begin
        for i:=1 to length(s) do
                for j:=1 to length(p) do
                        if s[i]=p[j] then f[i,j]:=(f[i-1,j]+f[i,j-1]+1) mod kk
                        else f[i,j]:=(f[i-1,j]+f[i,j-1]-f[i-1,j-1]+kk) mod kk;
end;

procedure output;
begin
        write(go,f[length(s),length(p)]);
        close(gi);close(go);
end;

begin
        input;
        process;
        output;
end.
