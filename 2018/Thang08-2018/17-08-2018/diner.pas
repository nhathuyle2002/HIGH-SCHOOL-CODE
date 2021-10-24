const   ginp='diner.inp';
        gout='diner.out';
        oo=trunc(1e6);

var     n,m:longint;
        a:array[0..101,1..6] of longint;
        f:array[0..101,0..100010] of longint;

function max(x,y:longint):longint;
begin
        if x>y then exit(x) else exit(y);
end;

procedure enter;
var     i,j:longint;
begin
        readln(n,m);
        for i:=1 to n do
        begin
                for j:=1 to 6 do read(a[i,j]);
                readln;
        end;
end;

function cnp(k,x:longint):longint;
var     left,right,mid:longint;
begin
        if f[k,m]<x then exit(oo);
        left:=0;right:=m;
        while left<right do
        begin
                mid:=(left+right) shr 1;
                if f[k,mid]>=x then right:=mid else left:=mid+1;
        end;
        exit(left);
end;

procedure process;
var     i,k,sum,left,right,mid:longint;
begin
        for k:=1 to n do
        begin
                f[k,0]:=a[k,2];
                for i:=1 to m do
                begin
                        f[k,i]:=f[k,i-1];
                        if i-a[k,4]>=0 then f[k,i]:=max(f[k,i],f[k,i-a[k,4]]+a[k,3]);
                        if i-a[k,6]>=0 then f[k,i]:=max(f[k,i],f[k,i-a[k,6]]+a[k,5]);
                end;
        end;
        left:=1;right:=oo+1;
        while left<right do
        begin
                mid:=(left+right) shr 1;
                sum:=0;
                for k:=1 to n do sum:=sum+cnp(k,a[k,1]*mid);
                if sum>m then right:=mid else left:=mid+1;
        end;
        write(left-1);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        process;
        close(input);close(output);
end.
