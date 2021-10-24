Uses    Math;

Const   ginp='shopping.inp';
        gout='shopping.out';
        maxn=5*100010;
        maxl=19;

Var     n,maxs,k,top:longint;
        res:int64;
        a,d,vr,vl:array[0..maxn] of longint;
        ma:array[0..maxn,0..maxl] of longint;

Procedure Enter;
Var     i,j:longint;
Begin
        readln(n,maxs);
        for i:=1 to n do
        begin
                read(a[i]);
                ma[i,0]:=a[i];
        end;
        k:=trunc(log2(n));
        for j:=1 to k do
                for i:=1 to n-1 shl j+1 do
                        ma[i,j]:=max(ma[i,j-1],ma[i+1 shl (j-1),j-1]);
End;

Function Get(l,r:longint):longint;
Var     j:longint;
Begin
        j:=trunc(log2(r-l+1));
        get:=max(ma[l,j],ma[r-1 shl j+1,j]);
End;

Procedure Process;
Var     i,l1,r1,l2,r2,mid:longint;
Begin
        top:=0;
        for i:=1 to n do
        begin
                vr[i]:=n;
                while (top>0) and (a[d[top]]>=a[i]) do
                begin
                        vr[d[top]]:=i-1;
                        dec(top);
                end;
                vl[i]:=d[top]+1;
                inc(top); d[top]:=i;
        end;
        for i:=1 to n do
        begin
                if 2*a[i]>maxs then continue;
                l1:=vl[i]; r1:=i;
                while l1<r1 do
                begin
                        mid:=(l1+r1) shr 1;
                        if get(mid,i)+a[i]<=maxs then r1:=mid else l1:=mid+1;
                end;
                l2:=i; r2:=vr[i]+1;
                while l2<r2 do
                begin
                        mid:=(l2+r2) shr 1;
                        if get(i,mid)+a[i]<=maxs then l2:=mid+1 else r2:=mid;
                end;
                dec(r2);
                res:=res+int64(i-l1+1)*(r2-i+1);
        end;
        write(res);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
