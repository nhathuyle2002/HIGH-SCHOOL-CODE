const   ginp='ss.inp';
        gout='ss.out';
        base=trunc(1e7);

var     n,m:longint;
        a:array[0..201,0..201] of longint;
        f:array[0..201,0..201,0..7] of longint;

procedure enter;
var     i,j:longint;
begin
        readln(m,n);
        for i:=1 to m do
        begin
                for j:=1 to n do read(a[i,j]);
                readln;
        end;
end;

function getb(i,x:longint):longint;
begin
        getb:=x shr (i-1) and 1;
end;

function setb(i,x,t:longint):longint;
begin
        if t=1 then setb:=x or (1 shl (i-1))
        else setb:=x and (not (1 shl (i-1)));
end;

procedure process;
var     i,j,x,xx:longint;
begin
        f[1,1,0]:=1;
        for i:=1 to m do
                for j:=1 to n do
                if a[i,j]>0 then
                begin
                        for x:=0 to 7 do
                        if getb(a[i,j],x)=1 then
                        begin
                                xx:=setb(a[i,j],x,0);
                                f[i,j,x]:=(f[i,j-1,x]+f[i-1,j,x]+f[i,j-1,xx]+f[i-1,j,xx]) mod base;
                        end;
                end;
        write((f[m,n-1,3]+f[m,n-1,5]+f[m,n-1,6]+f[m,n-1,7]+f[m-1,n,3]+f[m-1,n,5]+f[m-1,n,6]+f[m-1,n,7]) mod base);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        process;
        close(input);close(output);
end.
