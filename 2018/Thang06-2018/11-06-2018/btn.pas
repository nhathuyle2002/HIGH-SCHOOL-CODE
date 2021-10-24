const   ginp='btn.inp';
        gout='btn.out';

var     gi,go:text;
        n,maxk:longint;
        s:string;
        a:array[0..101] of longint;
        d:array[0..101,0..101] of longint;
        f:array[0..101,0..101,0..101] of int64;

procedure input;
var     i,j,cou:longint;
begin
        readln(gi,n,maxk);
        readln(gi,s);
        cou:=0;
        for i:=1 to n do
                if s[i]='(' then a[i]:=1 else
                if s[i]=')' then a[i]:=-1 else
                if s[i]='[' then a[i]:=2 else
                if s[i]=']' then a[i]:=-2 else
                if s[i]='{' then a[i]:=3 else
                if s[i]='}' then a[i]:=-3 else
                a[i]:=4;
        for i:=1 to n do
                for j:=i+1 to n do
                        if a[i]<0 then d[i,j]:=0 else
                        if (a[j]>0) and (a[j]<4) then d[i,j]:=0 else
                        if a[i]+a[j]=0 then d[i,j]:=1 else
                        if (a[i]=4) and (a[j]=4) then d[i,j]:=3 else
                        if (a[i]=4) or (a[j]=4) then d[i,j]:=1 else
                        d[i,j]:=0;
end;

function ccl(i,j,k:longint):int64;
var     kk:longint;
begin
        if i>j then exit(1);
        if k<=0 then exit(0);
        if f[i,j,k]<>-1 then exit(f[i,j,k]);
        if d[i,j]<>0 then ccl:=ccl(i+1,j-1,k-1)*d[i,j] else ccl:=0;
        kk:=i+1;
        while kk<=j-2 do
        begin
                if d[i,kk]<>0 then ccl:=ccl+d[i,kk]*ccl(i+1,kk-1,k-1)*ccl(kk+1,j,k);
                inc(kk,2);
        end;
        f[i,j,k]:=ccl;
end;

procedure process;
var     i,j,k:longint;
begin
        for i:=1 to n do
                for j:=1 to n do
                        for k:=1 to maxk do f[i,j,k]:=-1;
        write(go,ccl(1,n,maxk)-ccl(1,n,maxk-1));
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        input;
        if maxk<>0 then process;
        close(gi);close(go);
end.


