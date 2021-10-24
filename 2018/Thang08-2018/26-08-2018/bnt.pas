const   ginp='bnt.inp';
        gout='bnt.out';
        maxn=1001000;

var     n,m,res,nn:longint;
        nt:array[0..maxn] of longint;
        a,b:array[0..501] of longint;

procedure create;
var     i,j:longint;
        d:array[0..maxn] of boolean;
begin
        nn:=0;
        fillchar(d,sizeof(d),true);
        for i:=2 to maxn do
                if d[i] then
                begin
                        inc(nn);nt[nn]:=i;
                        for j:=i to maxn div i do d[i*j]:=false;
                end;
end;

function cnp(x:longint):longint;
var     l,r,mid:longint;
begin
        l:=1;r:=nn;
        while l<r do
        begin
                mid:=(l+r) shr 1;
                if nt[mid]>=x then r:=mid else l:=mid+1;
        end;
        cnp:=nt[l]-x;
end;

procedure process;
var     i,j,x,tmp:longint;
begin
        readln(m,n);
        for i:=1 to m do
        begin
                for j:=1 to n do
                begin
                        read(x);tmp:=cnp(x);
                        inc(a[i],tmp);inc(b[j],tmp);
                end;
                readln;
        end;
        res:=maxn*500;
        for i:=1 to m do
                if a[i]<res then res:=a[i];
        for j:=1 to n do
                if b[j]<res then res:=b[j];
        write(res);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        create;
        process;
        close(input);close(output);
end.
