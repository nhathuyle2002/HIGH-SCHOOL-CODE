const   ginp='ss.inp';
        gout='ss.out';

var     m,n,res:longint;
        a:array[0..3010] of string;
        d:array[0..4010,0..4010,'a'..'z'] of longint;


procedure enter;
var     i:longint;
begin
        readln(m,n);
        for i:=1 to m do readln(a[i]);
end;

function min(x,y:longint):longint;
begin
        if x<y then exit(x) else exit(y);
end;

procedure process;
var     i,j,k:longint;
begin
        res:=0;
        for i:=1 to m do
                for j:=1 to n do
                        if a[i,j]='.' then continue else
                        for k:=1 to min(n-j,m-i) do
                                if a[i,j]=a[i+k,j+k] then
                                begin
                                        res:=res+d[i+j,i+j+2*k,a[i,j]];
                                        inc(d[i+j,i+j+2*k,a[i,j]]);
                                end;
        write(res);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        process;
        close(input);close(output);
end.
