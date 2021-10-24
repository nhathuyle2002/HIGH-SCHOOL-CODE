const   ginp='queen.inp';
        gout='queen.out';
        maxn=1010;

var     m,n:longint;
        res:int64;
        a:array[0..maxn,0..maxn] of longint;
        sh,sc,cc,cp:array[-maxn..2*maxn] of int64;

function max(x,y:int64):int64;
begin
        if x>y then max:=x else max:=y;
end;

procedure enter;
var     i,j:longint;
begin
        readln(m,n);
        for i:=1 to m do
        begin
                for j:=1 to n do
                begin
                        read(a[i,j]);
                        inc(sh[i],a[i,j]); inc(sc[j],a[i,j]);
                        inc(cc[i-j],a[i,j]); inc(cp[i+j],a[i,j]);
                end;
                readln;
        end;
end;

procedure process;
var     i,j:longint;
begin
        res:=-trunc(1e13);
        for i:=1 to m do
                for j:=1 to n do
                        res:=max(res,sh[i]+sc[j]+cc[i-j]+cp[i+j]-3*a[i,j]);
        write(res);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        process;
        close(input);close(output);
end.
