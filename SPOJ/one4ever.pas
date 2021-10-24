type    matrix= array[1..2,1..2] of qword;

const   ginp='ss.inp';
        gout='ss.out';
        dv:matrix = ((1,0),(0,1));

var     m,st:qword;
        d:matrix;

function md(x,y:qword):qword;
begin
        if x=0 then exit(0);
        md:=(md(x shr 1,y shl 1 mod m)+x and 1*y) mod m;
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

function pow(k:qword):matrix;
var     c:matrix;
begin
        if k=0 then exit(dv);
        c:=pow(k shr 1);
        pow:=c*c;
        if k and 1=1 then pow:=pow*d;
end;

procedure process;
var     a,b,k,res:qword;
        c:matrix;
begin
        readln(a,b,m,k);
        d[1,1]:=a;d[1,2]:=b;d[2,1]:=0;d[2,2]:=1;
        c:=pow(k-1);
        res:=(md(b mod m,c[1,1])+c[1,2]) mod m;
        writeln(res);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        readln(st);
        while st>0 do
        begin
                process;
                dec(st);
        end;
        close(input);close(output);
end.
