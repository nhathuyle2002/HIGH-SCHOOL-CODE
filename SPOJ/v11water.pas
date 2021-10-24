const   ginp='ss.inp';
        gout='ss.out';

var     gi,go:text;
        n,r:longint;
        q:array[0..100001] of longint;
        sum,f,h:array[0..100001] of int64;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n);
        for i:=1 to n do
        begin
                read(gi,h[i]);
                sum[i]:=sum[i-1]+h[i];
        end;
end;

procedure process;
var     i,j:longint;
begin
        r:=0;q[0]:=1;
        for i:=1 to n do
        begin
                if h[i]>=h[q[0]] then
                begin
                        j:=q[0];
                        f[i]:=f[j]+h[j]*(i-j-1)-sum[i-1]+sum[j];
                        r:=0;q[0]:=i;
                end
                else
                begin
                        while h[i]>h[q[r]] do dec(r);
                        j:=q[r];
                        f[i]:=f[j]+h[i]*(i-j-1)-sum[i-1]+sum[j];
                        while h[i]=h[q[r]] do dec(r);
                        inc(r);q[r]:=i;
                end;
        end;
end;

procedure output;
begin
        write(go,f[n]);
        close(gi);close(go);
end;

begin
        input;
        process;
        output;
end.
