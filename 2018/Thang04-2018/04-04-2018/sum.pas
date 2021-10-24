const   ginp='sum.inp';
        gout='sum.out';

var     gi,go:text;
        n,k,b:longint;
        ans:int64;
        a:array[0..1000001] of int64;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n,k,b);
        b:=b mod n;
        if b=0 then b:=n;
        for i:=1 to n do
        begin
                readln(gi,a[i]);
                a[i]:=a[i-1]+a[i];
        end;
end;

procedure output;
begin
        if n-b+1>=k then ans:=a[k+b-1]-a[b-1]
        else
        begin
                ans:=a[n]-a[b-1];
                k:=k-(n-b+1);
                ans:=ans+(k div n)*a[n]+a[k mod n];
        end;
        write(go,ans);
        close(gi);close(go);
end;

begin
        input;
        output;
end.
