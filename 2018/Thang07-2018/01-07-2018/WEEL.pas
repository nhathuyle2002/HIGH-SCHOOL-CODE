const   fi='WEEL.INP';
        fo='WEEL.OUT';
        oo=trunc(1e9);
var     x,i,n,k:longint;
        a,b:array[0..200005] of longint;

procedure qs(l,r:longint);
var i,j,t,x:longint;
begin
        if l>=r then exit;
        i:=l; j:=r; x:=b[random(r-l+1)+l];
        repeat
                while a[i]<x do i:=i+1; while a[j]>x do j:=j-1;
                if i<=j then begin
                t:=b[i]; b[i]:=b[j]; b[j]:=t; i:=i+1; j:=j-1;end;
        until i>j;
        qs(l,j); qs(i,r);
end;
procedure main;
var     i,v,m,du,kq:longint;
begin
        v:=0; m:=0;
        for i:=1 to n do if a[i]<0 then
        begin
                if v <> 0 then begin
                inc(m);
                b[m]:=i-v-1;   end;
                v:=i;
        end;
        qs(1,m);
        du:=n-v; kq:=x*2; k:=k-x; b[m+1]:=oo;

        for i:=1 to m+1 do if (b[i]<=k) then
        begin
                kq:=kq-2;
                k:=k-b[i];
        end else break;

        v:=i-1;
        if (k>=du) or ((v<m) and (k+b[v]-du-b[v+1]>=0)) then kq:=kq-1;
        write(kq);
end;

begin
        assign(input,fi);  assign(output,fo);
        reset(input);      rewrite(output);
        readln(n,k);
        x:=0;
        for i:=1 to n do
        begin
                read(a[i]);
                if a[i]<0 then inc(x);
        end;
        if x>k then write(-1) else main;
        close(input);      close(output);
end.
