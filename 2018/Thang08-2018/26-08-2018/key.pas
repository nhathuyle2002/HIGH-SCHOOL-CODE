const   ginp='key.inp';
        gout='key.out';

var     n,k:longint;
        res:int64;
        v:array[0..100010] of longint;
        s:array[0..100010] of int64;

procedure enter;
var     i,x:longint;
begin
        readln(n,k);
        for i:=1 to n do
        begin
                readln(x);
                v[x]:=i;
        end;
end;

procedure process;
var     i:longint;
begin
        s[1]:=v[1]-1;
        for i:=2 to n do
                 if v[i]>v[i-1] then s[i]:=s[i-1]+v[i]-v[i-1]
                 else s[i]:=s[i-1]+v[i]+n-v[i-1];
        if k<=n then
        begin
                write(s[k]);
                exit;
        end;
        res:=s[n];k:=k-n;
        v[0]:=v[n];
        for i:=1 to n do
                if v[i]>v[i-1] then s[i]:=s[i-1]+v[i]-v[i-1]
                else s[i]:=s[i-1]+v[i]+n-v[i-1];
        res:=res+s[n]*(k div n)+s[k mod n];
        write(res);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        process;
        close(input);close(output);
end.
