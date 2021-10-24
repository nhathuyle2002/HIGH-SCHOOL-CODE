const   ginp='ss.inp';
        gout='ss.out';

var     gi,go:text;
        n:longint;
        ans:int64;
        maxr:real;
        r:array[0..10001] of real;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n);
        for i:=1 to n do
        begin
                read(gi,r[i]);
                maxr:=maxr+r[i];
        end;
        r[n+1]:=r[1];
end;

function ccl(a,b,c:real):real;
var     si:real;
begin
        ccl:=(a*a+b*b-c*c)/(2*a*b);
        if abs(ccl)>1 then exit(-1);
        if ccl=0 then exit(pi);
        si:=sqrt(1-ccl*ccl);
        ccl:=arctan(si/ccl);
end;

function check(x:real):real;
var     i:longint;
        tm:real;
begin
        check:=0;
        for i:=1 to n do
        begin
                tm:=ccl(x,x,r[i]+r[i+1]);
                if tm=-1 then exit(2*pi-1);
                check:=check+tm;
        end;
end;

procedure process;
var     d,c,m:int64;
        tm:real;
begin
        d:=1;c:=trunc(maxr*1000);
        m:=(d+c) div 2;
        while (d<>m) and (c<>m) do
        begin
                tm:=check(m/1000);
                if tm=2*pi then
                begin
                        ans:=m;
                        exit;
                end;
                if tm<2*pi then c:=m else d:=m;
        end;
        if abs(check(d/1000)-2*pi)<abs(check(c/1000)-2*pi) then ans:=d else ans:=c;
end;

procedure output;
begin
        write(go,ans/1000:0:3);
        close(gi);close(go);
end;

begin
        input;
        process;
        output;
end.
