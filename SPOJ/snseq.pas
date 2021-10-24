const   ginp='ss.inp';
        gout='ss.out';

var     gi,go:text;
        n:longint;
        a,b:extended;
        x:array[0..1001] of longint;

procedure input;
var     i:longint;
begin
        read(gi,n,a);
        x[1]:=0;x[2]:=0;x[3]:=2;
        for i:=4 to n do x[i]:=2*x[i-1]-x[i-2]+2;
end;

procedure process;
var     i:longint;
        tm:extended;
begin
        b:=0;
        for i:=3 to n do
        begin
                tm:=((i-2)*a-x[i])/(i-1);
                if tm>b then b:=tm;
        end;
        b:=(n-1)*b-(n-2)*a+x[n];
        write(go,trunc(b*100)/100:0:2);
end;

begin
        assign(gi,ginp);reset(gi);
        assign(go,gout);rewrite(go);
        input;
        process;
        close(gi);close(go);
end.
