type    matrix=array[1..50,1..50] of longint;

const   ginp='cpath.inp';
        gout='cpath.out';
        kk=2017;

var     n,sk,res:longint;
        ok:boolean;
        d:matrix;

procedure enter;
var     i,m,u,v:longint;
begin
        readln(n,m,sk);
        for i:=1 to m do
        begin
                readln(u,v);
                inc(d[u,v]);
        end;
end;

operator * (a,b:matrix) c:matrix;
var     i,j,k:longint;
begin
        fillchar(c,sizeof(c),0);
        for i:=1 to n do
                for j:=1 to n do
                        for k:=1 to n do
                                c[i,j]:=(c[i,j]+a[i,k]*b[k,j]) mod kk;
end;

function lt(k:longint):matrix;
var     c:matrix;
begin
        if k=1 then exit(d);
        c:=lt(k shr 1);
        lt:=c*c;
        if k and 1=1 then lt:=lt*d;
end;

procedure process;
var     c:matrix;
begin
        c:=lt(sk);
        write(c[1,n]);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        process;
        close(input);close(output);
end.