const   ginp='ss.inp';
        gout='ss.out';
        oo=trunc(1e16);

var     n,l,r:longint;
        del,p,q,m,res:int64;
        a,d:array[0..10000010] of int64;

procedure enter;
var     i:longint;
begin
        readln(n,del);
        read(p,q,m);
        for i:=1 to n do a[i]:=(p*i) mod m+q;
        for i:=n+1 to 2*n-1 do a[i]:=a[i-n];
        for i:=1 to 2*n-1 do a[i]:=a[i]+del*i;
end;

procedure push(i:longint);
begin
        while (l<=r) and (a[d[r]]<a[i]) do dec(r);
        inc(r); d[r]:=i;
end;

procedure pop(i:longint);
begin
        while (l<=r) and (d[l]<i) do inc(l);
end;

procedure process;
var     i,cou:longint;
begin
        l:=1;r:=0;
        for i:=1 to n-1 do push(i);
        res:=oo; cou:=0;
        for i:=n to 2*n-1 do
        begin
                pop(i-n+1); push(i);
                if res>a[d[l]]-del*cou then res:=a[d[l]]-del*cou;
                inc(cou);
        end;
        write(res);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        process;
        close(input);close(output);
end.
