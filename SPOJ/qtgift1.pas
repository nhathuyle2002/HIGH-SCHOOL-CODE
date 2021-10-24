const   ginp='ss.inp';
        gout='ss.out';

var     gi,go:text;
        n,k,l,r:longint;
        sum:int64;
        a,f,d:array[0..1000001] of int64;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n,k);
        for i:=1 to n do
        begin
                read(gi,a[i]);
                sum:=sum+a[i];
        end;
end;

function empty:boolean;
begin
        if l>r then exit(false) else exit(true);
end;

procedure push(i:longint);
begin
        while (empty) and (f[d[r]]>=f[i]) do dec(r);
        inc(r);d[r]:=i;
end;

procedure pop(i:longint);
begin
        while (empty) and (d[l]<i) do inc(l);
end;

procedure process;
var     i:longint;
begin
        for i:=1 to k do
        begin
                f[i]:=a[i];
                push(i);
        end;
        for i:=k+1 to n+1 do
        begin
                pop(i-k);
                f[i]:=f[d[l]]+a[i];
                push(i);
        end;
end;

procedure output;
begin
        write(go,sum-f[n+1]);
        close(gi);close(go);
end;

begin
        input;
        process;
        output;
end.















