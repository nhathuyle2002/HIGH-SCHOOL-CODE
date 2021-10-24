// The Best //

type    matrix=array[1..2,1..2] of int64;

const   ginp='fibos.inp';
        gout='fibos.out';
        kk=round(1e9)+7;
        d:matrix =((1,1),(1,0));

var     n:int64;

operator * (a,b:matrix) c:matrix;
var     i,j,k:longint;
begin
        fillchar(c,sizeof(c),0);
        for i:=1 to 2 do
                for j:=1 to 2 do
                        for k:=1 to 2 do
                                c[i,j]:=(c[i,j]+a[i,k]*b[k,j]) mod kk;
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
        read(n);
        c:=lt(n+2);
        write(c[1,1]-1);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        main;
        close(input);close(output);
end.
