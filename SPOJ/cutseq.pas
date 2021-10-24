const   ginp='ss.inp';
        gout='ss.out';

var     n:longint;
        f:array[0..201,0..201] of longint;
        a:string;

function max(x,y:longint):longint;
begin
        if x>y then exit(x) else exit(y);
end;

procedure main;
var     i,j,i0,j0,kc,k:longint;
begin
        readln(n);
        read(a);
        for i:=1 to n do f[i,i]:=1;
        for kc:=1 to n-1 do
                for i:=1 to n-kc do
                begin
                        j:=i+kc;
                        for k:=i to j-1 do f[i,j]:=max(f[i,j],f[i,k]+f[k+1,j]);
                        if a[i]<>a[j] then continue;
                        i0:=i;j0:=j;
                        while (i0<=j) and (a[i0]=a[i]) do inc(i0);
                        while (j0>=i) and (a[j0]=a[j]) do dec(j0);
                        if i0>j0 then f[i,j]:=max(f[i,j],sqr(j-i+1))
                        else f[i,j]:=max(f[i,j],f[i0,j0]+sqr(i0-i+j-j0));
                end;
        write(f[1,n]);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        main;
        close(input);close(output);
end.
