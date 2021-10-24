const   ginp='ss.inp';
        gout='ss.out';

var     n:longint;
        f:array[0..1010,0..1] of longint;
        a,b:array[0..1010] of longint;

procedure enter;
var     i:longint;
begin
        readln(n);
        for i:=1 to n do readln(a[i],b[i]);
end;

function max(x,y:longint):longint;
begin
        if x>y then exit(x) else exit(y);
end;

function abs(x:longint):longint;
begin
        if x<0 then exit(-x) else exit(x);
end;

procedure process;
var     i:longint;
begin
        f[1,0]:=b[1];f[1,1]:=a[1];
        for i:=2 to n do
        begin
                f[i,0]:=max(f[i-1,0]+abs(a[i]-a[i-1]),f[i-1,1]+abs(a[i]-b[i-1]))+b[i];
                f[i,1]:=max(f[i-1,0]+abs(b[i]-a[i-1]),f[i-1,1]+abs(b[i]-b[i-1]))+a[i];
        end;
        write(max(f[n,0],f[n,1]));
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        process;
        close(input);close(output);
end.
