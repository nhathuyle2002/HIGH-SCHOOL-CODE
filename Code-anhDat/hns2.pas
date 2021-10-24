const   ginp='hcn.inp';
        gout='hcn.out';

var     m,n,res:longint;
        a:array[0..1010,0..1010] of longint;              //Sai roi //
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
                        if a[i,j]>=ma1[j] then
                        begin
                                ma2[j]:=ma1[j];
                                ma1[j]:=a[i,j];
                        end else
                        if a[i,j]>ma2[j] then ma2[j]:=a[i,j];
                end;
        end;
end;

function min(x,y:longint):longint; inline;
begin
        if x<y then exit(x) else exit(y);
end;

procedure process;
var     j1,j2,i,m1,m2,tm:longint;
begin
        res:=0;
        for j1:=1 to n-1 do
                for j2:=j1+1 to n do
                begin
                        if min(ma2[j1],ma2[j2])<=res then continue;
                        m1:=0;m2:=0;
                        for i:=1 to m do
                        begin
                                tm:=min(a[i,j1],a[i,j2]);
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