const   ginp='ss.inp';
        gout='ss.out';
        oo=trunc(1e9);

var     n,res:longint;
        a,d:array[0..201,0..201] of longint;

procedure enter;
var     i,j:longint;
begin
        readln(n);
        for i:=1 to n do
        begin
                for j:=1 to n do read(a[i,j]);
                readln;
        end;
end;

function min(x,y:longint):longint;
begin
        if x<y then exit(x) else exit(y);
end;

procedure process;
var     i,j:longint;
begin
        d[2,1]:=a[2,1];
        for i:=3 to n do
        begin
                d[i,i-1]:=oo;
                for j:=1 to i-2 do
                begin
                        d[i,j]:=d[i-1,j]+a[i-1,i];
                        d[i,i-1]:=min(d[i,i-1],d[i-1,j]+a[i,j]);
                end;
        end;
        if n=1 then res:=0 else res:=oo;
        for i:=1 to n-1 do
                res:=min(res,d[n,i]+a[n,1]+a[i,1]);
        write(res);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        process;
        close(input);close(output);
end.
