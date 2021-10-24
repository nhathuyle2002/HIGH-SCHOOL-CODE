uses    math;
const   ginp='ss.inp';
        gout='ss.out';
var     r,n,r1,r2,i,j:longint;
        a,b:string;
        d:array[1..51,1..3] of longint;
function dm(x:char):longint;
begin
        if x='P' then dm:=1 else
        if x='S' then dm:=2 else dm:=3;
end;
function ck(x,y:longint):longint;
begin
        if x=y then ck:=1 else
        if x-1=y mod 3 then ck:=2 else ck:=0;
end;
begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        readln(r);readln(a);
        readln(n);
        for i:=1 to n do
        begin
                readln(b);
                for j:=1 to r do
                begin
                        r1:=r1+ck(dm(a[j]),dm(b[j]));
                        d[j,1]:=d[j,1]+ck(1,dm(b[j]));
                        d[j,2]:=d[j,2]+ck(2,dm(b[j]));
                        d[j,3]:=d[j,3]+ck(3,dm(b[j]));
                end;
        end;
        writeln(r1);
        for i:=1 to r do r2:=r2+max(max(d[i,1],d[i,2]),d[i,3]);
        write(r2);
        close(input);close(output);
end.