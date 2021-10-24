const   ginp='nguhanh.inp';
        gout='nguhanh.out';
        kk=1000000007;

var     gi,go:text;
        s:ansistring;
        k:longint;
        ans,gt:int64;

procedure input;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,s);
        read(gi,k);
end;

procedure output;
begin
        write(go,ans);
        close(gi);close(go);
end;

function ccl(n:int64):int64;
var     tmp:int64;
begin
        if (n=0) then exit(1);
        tmp:=ccl(n div 2);
        tmp:=(tmp*tmp) mod kk;
        if n mod 2=0 then exit(tmp mod kk)
        else exit((gt*tmp) mod kk);
end;

procedure process;
var     i,n:longint;
        tmp:int64;
begin
        n:=length(s);
        gt:=2;
        gt:=ccl(n);
        tmp:=(ccl(k)-1) mod kk;
        dec(gt);
        tmp:=(tmp*ccl(kk-2)) mod kk;
        gt:=2;
        for i:=1 to n do
                if (s[i]='0') or (s[i]='5') then
                        ans:=(ans+ccl(i-1)*tmp) mod kk;
end;

begin
        input;
        process;
        output;
end.











