const   ginp='ss.inp';
        gout='ss.out';
        maxn=100010;
        oo=trunc(1e9)+100;

var     gi,go:text;
        n,res,l,r:longint;
        s,la,q:array[0..2*maxn] of longint;

procedure input;
var     i:longint;
begin
        readln(gi,n);
        for i:=1 to n do read(gi,s[n-i+1]);
        for i:=n+1 to 2*n do s[i]:=s[i-n];
        for i:=2 to 2*n do s[i]:=s[i-1]+s[i];
end;

procedure pop(i:longint);
begin
        while (q[l]<=i) and (l<=r) do inc(l);
end;

procedure push(i:longint);
begin
        while (s[i]>=s[q[r]]) and (l<=r) do dec(r);
        inc(r);q[r]:=i;
end;

procedure process;
var     i:longint;
begin
        l:=1;r:=1;
        res:=0;
        for i:=1 to n do push(i);
        for i:=n+1 to 2*n do
        begin
                pop(i-n);
                if s[i]-s[q[l]]>0 then inc(res);
                push(i);
        end;
        write(go,res);
end;

begin
        assign(gi,ginp);reset(gi);
        assign(go,gout);rewrite(go);
        input;
        process;
        close(gi);close(go);
end.
