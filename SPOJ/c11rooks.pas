const   ginp='ss.inp';
        gout='ss.out';
        oo=trunc(1e9);

var     n,res:longint;
        a:array[0..301,0..301] of longint;
        sh,sc,b,c:array[0..301] of longint;

procedure enter;
var     i,j:longint;
begin
        readln(n);
        for i:=1 to n do
        begin
                for j:=1 to n do
                begin
                        read(a[i,j]);
                        sh[i]:=sh[i]+a[i,j];
                        sc[j]:=sc[j]+a[i,j];
                end;
                readln;
        end;
end;

function max(x,y:longint):longint;
begin
        if x>y then exit(x) else exit(y);
end;

function min(x,y:longint):longint;
begin
        if x<y then exit(x) else exit(y);
end;

procedure process;
var     i1,i2,j,j1,j2,j3,j4:longint;
begin
        res:=0;b[0]:=-oo;c[0]:=-oo;
        for i1:=1 to n do
                for i2:=1 to n do
                if i1<>i2 then
                begin
                        for j:=1 to n do b[j]:=sc[j]-2*a[i1,j]-a[i2,j];
                        j1:=0;j2:=0;
                        for j:=1 to n do
                                if b[j]>=b[j1] then
                                begin
                                        j2:=j1;j1:=j;
                                end else
                                if b[j]>b[j2] then j2:=j;
                        for j:=1 to n do c[j]:=sc[j]-a[i1,j]-2*a[i2,j];
                        j3:=0;j4:=0;
                        for j:=1 to n do
                                if c[j]>=c[j3] then
                                begin
                                        j4:=j3;j3:=j;
                                end else
                                if c[j]>c[j4] then j4:=j;
                        if j1<>j3 then res:=max(res,sh[i1]+sh[i2]+b[j1]+c[j3])
                        else res:=max(res,sh[i1]+sh[i2]+max(sc[j1]-a[i1,j1]-a[i2,j1],max(b[j1]+c[j4],b[j2]+c[j3])));
                end else
                begin
                        for j:=1 to n do b[j]:=sc[j]-2*a[i1,j];
                        j1:=0;j2:=0;
                        for j:=1 to n do
                                if b[j]>=b[j1] then
                                begin
                                        j2:=j1;j1:=j;
                                end else
                                if b[j]>b[j2] then j2:=j;
                        res:=max(res,sh[i1]+b[j1]+b[j2]);
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
