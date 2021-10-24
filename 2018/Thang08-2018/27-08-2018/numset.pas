type    matrix=array[1..9,1..9] of int64;

const   ginp='numset.inp';
        gout='numset.out';
        d:matrix= ((0,0,0,0,0,0,1,0,0),(0,0,0,0,0,1,1,1,1),(0,0,0,0,1,1,1,1,1),(0,0,0,0,1,0,1,0,0),
        (0,0,1,1,1,1,1,1,1),(0,1,1,0,1,0,1,0,0),(1,1,1,1,1,1,1,1,1),(0,1,1,0,1,0,1,0,0),(0,1,1,0,1,0,1,0,0));
        base=trunc(1e9);

var     n,res:int64;

operator * (a,b:matrix) c:matrix;
var     i,j,k:longint;
begin
        fillchar(c,sizeof(c),0);
        for i:=1 to 9 do
                for j:=1 to 9 do
                        for k:=1 to 9 do
                                c[i,j]:=(c[i,j]+a[i,k]*b[k,j]) mod base;
end;

function pow(k:int64):matrix;
var     c:matrix;
begin
        if k=1 then exit(d);
        c:=pow(k shr 1);
        pow:=c*c;
        if k and 1=1 then pow:=pow*d;
end;

procedure main;
var     i,j:longint;
        c:matrix;
begin
        read(n);
        c:=pow(n-1);
        res:=0;
        for i:=1 to 9 do
                for j:=1 to 9 do
                        res:=(res+c[i,j]) mod base;
        write(res);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        main;
        close(input);close(output);
end.
