const   ginp='hcn.inp';
        gout='hcn.out';

var     m,n,res:longint;
        a:array[0..1010,0..1010] of longint;
        ma1,ma2:array[0..1010] of longint;

procedure enter;
var     i,j:longint;
begin
        readln(m,n);
        for i:=1 to m do
        begin
                for j:=1 to n do
                begin
                        read(a[i,j]);
                        if a[i,j]>=ma1[i] then
                        begin
                                ma2[i]:=ma1[i];
                                ma1[i]:=a[i,j];
                        end else
                        if a[i,j]>ma2[i] then ma2[i]:=a[i,j];
                end;
        end;
end;

function min(x,y:longint):longint; inline;
begin
        if x<y then exit(x) else exit(y);
end;

procedure process;
var     i1,i2,j,m1,m2,tm:longint;
begin
        res:=0;
        for i1:=1 to m-1 do
                for i2:=i1+1 to m do
                begin
                        if min(ma2[i1],ma2[i2])<=res then continue;
                        m1:=0;m2:=0;
                        for j:=1 to n do
                        begin
                                tm:=min(a[i1,j],a[i2,j]);
                                if tm>=m1 then
                                begin
                                        m2:=m1;m1:=tm;
                                end else
                                if tm>m2 then m2:=tm;
                        end;
                        if m2>res then res:=m2;
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