const   ginp='ss.inp';
        gout='ss.out';
        maxt=trunc(1e9)+100;
        oo=trunc(1e18);
        esp=1e-10;

var     n:longint;
        a,v:array[0..100010] of int64;

function max(x,y:double):double;
begin
        if x>y then exit(x) else exit(y);
end;

function min(x,y:double):double;
begin
        if x<y then exit(x) else exit(y);
end;

procedure enter;
var     i:longint;
begin
        readln(n);
        for i:=1 to n do read(a[i]);readln;
        for i:=1 to n do read(v[i]);
end;

function ccl(t:double):double;
var     i:longint;
        xma,xmi,tmp:double;
begin
        xma:=-oo;xmi:=oo;
        for i:=1 to n do
        begin
                tmp:=t*v[i]+a[i];
                xma:=max(xma,tmp);
                xmi:=min(xmi,tmp);
        end;
        ccl:=xma-xmi;
end;

procedure process;
var     l,r,m1,m2,f1,f2:double;
begin
        l:=0;r:=maxt;
        while abs(r-l)>=esp do
        begin
                m1:=l+(r-l)/3;
                m2:=r-(r-l)/3;
                f1:=ccl(m1);f2:=ccl(m2);
                if f1>f2 then l:=m1 else
                if f1<f2 then r:=m2 else
                begin
                        l:=m1;r:=m2;
                end;
        end;
        write(min(ccl(l),ccl(r))/2:0:3);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        process;
        close(input);close(output);
end.
