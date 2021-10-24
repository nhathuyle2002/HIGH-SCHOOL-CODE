const   ginp='mstring.inp';
        gout='mstring.out';
        kk=1000000007;

var     gi,go:text;
        n:longint;
        s,ss:ansistring;
        f:array[0..2001,0..2001] of int64;

procedure input;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        read(gi,s);
end;

procedure process;
var     i,j:longint;
begin
        n:=length(s);
        ss:=s;
        for i:=1 to n do ss[i]:=s[n-i+1];
        for i:=1 to n do
                for j:=1 to n do
                begin
                        f[i,j]:=(f[i-1,j]+f[i,j-1]) mod kk;
                        if s[i]=s[j] then f[i,j]:=(f[i,j]+1) mod kk else f[i,j]:=(f[i,j]-f[i-1,j-1]+kk) mod kk;
                end;
end;

procedure output;
begin
        write(go,f[n,n] mod kk);
        close(gi);close(go);
end;

begin
        input;
        process;
        output;
end.
