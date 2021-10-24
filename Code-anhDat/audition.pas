const   ginp='35.in';
        gout='audition.out';
        oo=trunc(1e9);

var     m,n,res:longint;
        a,b:array[0..201] of longint;
        f:array[0..201,0..201] of longint;

function enter:boolean;
var     i:longint;
begin
        readln(n,m);
        if (n=0) and (m=0) then exit(false);
        for i:=1 to n do readln(a[i],b[i]);
        readln;
        enter:=true;
end;

function min(x,y:longint):longint;
begin
        if x<y then exit(x) else exit(y);
end;

procedure process;
var     i,k,j:longint;
begin
        for i:=0 to n do f[i,1]:=oo;
        f[1,1]:=0;
        for k:=2 to m-1 do
                for i:=k to n-1 do
                begin
                        f[i,k]:=f[i-1,k-1];
                        for j:=i-2 downto k-1 do f[i,k]:=min(f[i,k],f[j,k-1]+sqr(a[i]-b[j]));
                end;
        res:=f[n-1,m-1];
        for i:=n-2 downto m-1 do
                res:=min(res,f[i,m-1]+sqr(a[n]-b[i]));
        writeln(res);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        while enter do process;
        close(input);close(output);
end.
