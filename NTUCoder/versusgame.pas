const   ginp='ss.inp';
        gout='ss.out';
        maxn=1000010;
        //a:array[1..6] of longint = (5,4,4,3,1,10);
        d:array[1..6] of longint = (15,19,5,3,1,10);
        w:array[1..6] of longint = (2,3,2,1,1,1);

var     n,t:longint;
        f:array[0..maxn] of longint;

function min(x,y:longint):longint;
begin
        if x<y then exit(x) else exit(y);
end;

procedure create;
var     i,j:longint;
begin
        for i:=1 to maxn do
        begin
                f[i]:=maxn;
                for j:=1 to 6 do
                        if i-d[j]>=0 then f[i]:=min(f[i],f[i-d[j]]+w[j]);
        end;
end;

procedure process;
var     j,res,i:longint;
begin
        readln(t);
        for i:=1 to t do
        begin
                readln(n);
                res:=f[n];
                //for j:=1 to 6 do
                        //if i-a[j]>=0 then res:=min(res,f[i-a[j]]+1);
                writeln(res);
        end;
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        create;
        process;
        close(input);close(output);
end.
