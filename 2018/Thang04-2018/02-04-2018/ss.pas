const   ginp='simi.inp';
        gout='simi.out';

var     gi,go:text;
        ss:ansistring;
        l,r,n:longint;
        s:array[0..1000001] of char;
        z:array[0..1000001] of longint;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        read(gi,ss);
        n:=length(ss);
        for i:=0 to n-1 do s[i]:=ss[i+1];
end;

procedure process;
var     i,k:longint;
begin
        l:=0;r:=0;
        for i:=1 to n-1 do
                if i>r then
                begin
                        l:=i;r:=i;
                        while (r<n) and (s[r]=s[r-l]) do inc(r);
                        z[i]:=r-l;dec(r);
                end
                else
                begin
                        k:=i-l;
                        if z[k]<r-i+1 then z[i]:=z[k]
                        else
                        begin
                                l:=i;
                                while (r<n) and (s[r]=s[r-l]) do inc(r);
                                z[i]:=r-l;dec(r);
                        end;
                end;
end;

procedure output;
var     i:longint;
        ans:int64;
begin
        ans:=0;
        for i:=1 to n-1 do ans:=ans+z[i];
        ans:=ans+n;
        write(go,ans);
        close(gi);close(go);
end;

begin
        input;
        process;
        output;
end.

