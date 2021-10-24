const   ginp='mushroom.inp';
        gout='mushroom.out';
        oo=trunc(1e9);

var     n,k:longint;
        a:array[0..1001,0..1001] of longint;
        f:array[0..1,0..1001,0..1001] of longint;

procedure enter;
var     i,j:longint;
begin
        readln(n,k);
        for i:=1 to n do
        begin
                for j:=1 to n do read(a[i,j]);
                readln;
        end;
end;

function max(x,y:longint):longint; inline;
begin
        if x>y then exit(x) else exit(y);
end;

procedure process;
var     i,j,t:longint;
begin
        for i:=0 to n+1 do
                for j:=0 to n+1 do f[0,i,j]:=-oo;
        f[0,0,1]:=0;f[1]:=f[0];
        for t:=0 to k do
        begin
                for i:=1 to n do
                        for j:=1 to n do
                                f[1,i,j]:=max(f[0,i,j],max(max(f[1,i-1,j],f[1,i,j-1]),max(f[0,i+1,j],f[0,i,j+1]))+a[i,j]);
                f[0]:=f[1];
        end;
        write(f[1,n,n]);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        process;
        close(input);close(output);
end.
