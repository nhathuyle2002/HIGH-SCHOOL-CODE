// The Best //

type    matrix=array [1..3,1..3] of int64;

const   ginp='loco.inp';
        gout='loco.out';
        d:matrix =((1,1,1),(1,0,0),(0,1,0));

var     n,m:int64;

operator * (a,b:matrix) c:matrix;
var     i,j,k:longint;
begin
        fillchar(c,sizeof(c),0);
        for i:=1 to 3 do
                for j:=1 to 3 do
                        for k:=1 to 3 do
                                c[i,j]:=(c[i,j]+a[i,k]*b[k,j]) mod m;
end;

function lt(k:int64):matrix;
var     c:matrix;
begin
        if k=1 then exit(d);
        c:=lt(k shr 1);
        lt:=c*c;
        if k and 1=1 then lt:=lt*d;
end;

procedure main;
var     c:matrix;
begin
        readln(n,m);
        c:=lt(n);
        write(c[1,1]);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        main;
        close(input);close(output);
end.
