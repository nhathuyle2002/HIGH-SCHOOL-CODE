// ~~ Best ~~ //

type    matrix=array[1..2,1..2] of int64;

const   ginp='func.inp';
        gout='func.out';
        dv:matrix =((1,0),(0,1));

var     r,p,q,m,sk:int64;
        d:matrix;

function uc(a,b:int64):int64;
begin
        if a mod b=0 then exit(b);
        uc:=uc(b,a mod b);
end;

function md(a,b:int64):int64;
begin
        if a=0 then exit(0);
        md:=md(a shr 1,2*b mod m);
        if a and 1=1 then md:=(md+b) mod m;
end;

operator * (a,b:matrix) c:matrix;
var     i,j,k:longint;
begin
        fillchar(c,sizeof(c),0);
        for i:=1 to 2 do
                for j:=1 to 2 do
                        for k:=1 to 2 do
                                c[i,j]:=(c[i,j]+md(a[i,k],b[k,j])) mod m;
end;

function lt(k:int64):matrix;
var     c:matrix;
begin
        if k=0 then exit(dv);
        c:=lt(k shr 1);
        lt:=c*c;
        if k and 1=1 then lt:=lt*d;
end;

procedure main;
var     tm,rp,rq:int64;
        c:matrix;
begin
        readln(sk,r,p,q,m);
        tm:=uc(p,q);
        p:=p div tm;q:=q div tm;
        d[1,1]:=0;d[1,2]:=1;d[2,1]:=1;d[2,2]:=r;
        c:=lt(sk-1);
        rp:=(md(c[1,1],p)+md(c[1,2],q)) mod m;
        rq:=(md(c[2,1],p)+md(c[2,2],q)) mod m;
        writeln(rp,' ',rq);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        while not seekeof do main;
        close(input);close(output);
end.

