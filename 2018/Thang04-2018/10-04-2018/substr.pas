const   ginp='substr.inp';
        gout='substr.out';

var     gi,go:text;
        s:ansistring;
        k:longint;
        ans:int64;

procedure input;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,k);
        read(gi,s);
end;

procedure process;
var     i,n:longint;
        a:array[0..1000010] of longint;
begin
        n:=0;a[0]:=1;
        for i:=1 to length(s) do
                if s[i]='1' then
                begin
                        inc(n);
                        a[n]:=1;
                end
                else inc(a[n]);
        if k>0 then
                for i:=k to n do ans:=ans+int64(a[i])*a[i-k];
        if k=0 then
                for i:=0 to n do ans:=ans+(a[i]-1)*int64(a[i]) div 2;
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



