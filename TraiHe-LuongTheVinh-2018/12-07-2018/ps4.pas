// ~~ Best ~~ //

type    matrix=array[1..4,1..4] of int64;

const   ginp='ps4.inp';
        gout='ps4.out';
        dv:matrix =((1,0,0,0),(0,1,0,0),(0,0,1,0),(0,0,0,1));
        dl:matrix =((1,0,0,0),(0,1,0,0),(1,0,1,0),(0,1,0,1));
        dr:matrix =((1,0,1,0),(0,1,0,1),(0,0,1,0),(0,0,0,1));

var     n,cl,cr,sk,m,rp,rq:int64;
        d:matrix;
        s:ansistring;

function md(x,y:int64):int64;
begin
        if x=0 then exit(0);
        md:=md(x shr 1,2*y mod m);
        if x and 1=1 then md:=(md+y) mod m;
end;

operator * (a,b:matrix) c:matrix;
var     i,j,k:longint;
begin
        fillchar(c,sizeof(c),0);
        for i:=1 to 4 do
                for j:=1 to 4 do
                        for k:=1 to 4 do
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
var     i:longint;
        c:matrix;
begin
        readln(n,sk,m);
        read(s);
        for i:=1 to n do
                if s[i]='L' then inc(cl) else inc(cr);
        d:=dl;c:=lt(cl);
        d:=dr;c:=c*lt(cr);
        d:=c;c:=lt(sk);
        rp:=(c[1,2]+c[1,3]+c[3,2]+c[3,3]) mod m;
        rq:=(c[2,2]+c[2,3]+c[4,2]+c[4,3]) mod m;
        write(rp,' ',rq);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        main;
        close(input);close(output);
end.