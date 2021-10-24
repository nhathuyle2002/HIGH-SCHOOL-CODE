Const   ginp='bai3.inp';
        gout='bai3.out';
        maxn=100010;

Var     st,n,top,res,maxl:longint;
        a,q,dl,dr:array[0..maxn] of longint;
        d:array[0..maxn] of boolean;

Procedure Enter;
Var     i:longint;
Begin
        readln(n);
        for i:=1 to n do read(a[i]);
        readln;
End;

Procedure Process;
Var     i,l,r,mid:longint;
Begin
        top:=0; q[0]:=0;
        for i:=1 to n do
                if a[i]>q[top] then
                begin
                        inc(top);
                        q[top]:=a[i]; dl[i]:=top;
                end else
                begin
                        l:=1; r:=top;
                        while l<r do
                        begin
                                mid:=(l+r) shr 1;
                                if q[mid]<a[i] then l:=mid+1 else r:=mid;
                        end;
                        q[l]:=a[i]; dl[i]:=l;
                end;
        top:=0; q[0]:=n+1;
        for i:=n downto 1 do
                if a[i]<q[top] then
                begin
                        inc(top);
                        q[top]:=a[i]; dr[i]:=top;
                end else
                begin
                        l:=1; r:=top;
                        while l<r do
                        begin
                                mid:=(l+r) shr 1;
                                if q[mid]>a[i] then l:=mid+1 else r:=mid;
                        end;
                        q[l]:=a[i]; dr[i]:=l;
                end;
        maxl:=0;
        for i:=1 to n do
                if maxl<dl[i]+dr[i]-1 then maxl:=dl[i]+dr[i]-1;
        for i:=1 to n do d[i]:=false;
        res:=0;
        for i:=1 to n do
                if dl[i]+dr[i]-1=maxl then
                begin
                        inc(res);
                        d[a[i]]:=true;
                end;
        writeln(res);
        for i:=1 to n do
                if d[i] then write(i,' ');
        writeln;
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        readln(st);
        for st:=1 to st do
        begin
                Enter;
                Process;
        end;
        Close(input); Close(output);
End.
