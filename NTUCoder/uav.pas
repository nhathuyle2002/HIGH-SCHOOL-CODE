const   ginp='ss.inp';
        gout='ss.out';
        oo=trunc(1e13);

var     n,ll:longint;
        a,b,c:array[0..500010] of int64;

procedure enter;
var     i:longint;
begin
        readln(ll);
        readln(n);
        a[1]:=1000;a[n]:=1001;
        for i:=2 to n-1 do read(a[i]);
end;

function min(x,y:int64):int64;
begin
        if x<y then exit(x) else exit(y);
end;

function max(x,y:int64):int64;
begin
        if x>y then exit(x) else exit(y);
end;

procedure process;
var     i,j,l,r:longint;
        tm:int64;
        q:array[0..500010] of longint;
begin
        b[1]:=1;c[1]:=0;
        l:=1;r:=1;q[1]:=1;
        tm:=-a[1];
        for i:=2 to n do
        begin
                b[i]:=oo;c[i]:=-oo;
                if a[i] and 1=1 then
                begin
                        while (l<=r) and (q[l]<i-ll) do inc(l);
                        b[i]:=b[q[l]]+1;
                        while (l<=r) and (b[i]<=b[q[r]]) do dec(r);
                        inc(r);q[r]:=i;
                end;
                if a[i] and 1=0 then
                begin
                        c[i]:=tm;
                        if i-ll>0 then c[i]:=max(c[i],c[i-ll]+a[i-ll]);
                        tm:=max(tm,c[i]-a[i]);
                end;
        end;
        writeln(b[n]);
        write(max(tm,c[n-ll]+a[n-ll])+a[n]);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        process;
        close(input);close(output);
end.
