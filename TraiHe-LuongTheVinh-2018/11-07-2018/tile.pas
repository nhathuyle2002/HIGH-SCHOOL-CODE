// The Best //

type    matrix=array[1..2,1..2] of int64;

const   ginp='tile.inp';
        gout='tile.out';
        kk=trunc(1e9)+7;
        d:matrix =((1,2),(1,0));

var     st,n:int64;

function nh(a,b:matrix):matrix;
var     i,j,k:longint;
begin
        fillchar(nh,sizeof(nh),0);
        for i:=1 to 2 do
                for j:=1 to 2 do
                        for k:=1 to 2 do
                                nh[i,j]:=(nh[i,j]+a[i,k]*b[k,j]) mod kk;
end;

function lt(k:int64):matrix;
var     c:matrix;
begin
        if k=1 then exit(d);
        c:=lt(k shr 1);
        lt:=nh(c,c);
        if k and 1=1 then lt:=nh(lt,d);
end;

procedure process;
var     c:matrix;
begin
        {if n=1 then writeln(1) else
        begin
                c:=lt(n-1);
                writeln((c[1,1]+c[1,2]) mod kk);
        end;}
        c:=lt(n);
        writeln(c[1,1]);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        readln(st);
        while st>0 do
        begin
                readln(n);
                process;
                dec(st);
        end;
        close(input);close(output);
end.

