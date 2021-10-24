type    matrix = array[1..8,1..8] of qword;

const   ginp='ss.inp';
        gout='ss.out';
        dd:array[1..8,1..3] of longint=((2,4,5),(1,3,6),(2,4,7),(1,3,8),(1,6,8),(2,5,7),(3,6,8),(4,5,7));

var     dv,d:matrix;
        m:qword;

procedure init;
var     i,j:longint;
begin
        for i:=1 to 8 do dv[i,i]:=1;
        for i:=1 to 8 do
                for j:=1 to 3 do d[i,dd[i,j]]:=1;
end;

operator * (a,b:matrix) c:matrix;
var     i,j,k:longint;
begin
        fillchar(c,sizeof(c),0);
        for i:=1 to 8 do
                for j:=1 to 8 do
                        for k:=1 to 8 do
                                c[i,j]:=(c[i,j]+a[i,k]*b[k,j]) mod m;
end;

function pow(k:longint):matrix;
var     c:matrix;
begin
        if k=0 then exit(dv);
        c:=pow(k shr 1);
        pow:=c*c;
        if k and 1=1 then pow:=pow*d;
end;


procedure process;
var     s:string;
        c:matrix;
        st,fi,k:longint;
begin
        readln(s);
        st:=ord(s[1])-64;fi:=ord(s[3])-64;
        read(k,m);
        c:=pow(k);
        write(c[fi,st]);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        init;
        process;
        close(input);close(output);
end.
