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
        d[1,1]:=0;
        for i:=2 to n do
        begin
                for j:=1 to i-1 do d[i,j]:=d[i-1,j]+a[i-1,i];
                d[i,i]:=oo;
                for j:=1 to i-1 do
                begin
                        d[i,i-1]:=min(d[i,i-1],d[i-1,j]+a[i,j]);
                        d[i,i]:=min(d[i,i],d[i-1,j]+a[i,i-1]+a[i,j]);
                end;
        end;
        res:=oo;
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
