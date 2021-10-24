Const   ginp='modulo.inp';
        gout='modulo.out';
        maxn=22;

Var     n,n1,n2,a,b:longint;
        k,n0:int64;
        m10:array[0..maxn*2] of int64;
        d1,d2:array[0..1 shl maxn] of int64;
        p1,p2:array[0..1 shl maxn] of longint;
        r1,r2:longint;

Procedure Enter;
Var     i:longint;
Begin
        readln(a,b);
        read(n,k);
        n0:=1;
        for i:=1 to n do n0:=n0*2;
        m10[0]:=1;
        for i:=1 to n-1 do m10[i]:=(m10[i-1]*10) mod n0;
End;

Procedure Sort(l,r:longint; var d:array of int64; var p:array of longint);
Var     i,j,tt:longint;
        t,tmp:int64;
Begin
        if l>=r then exit;
        i:=l; j:=r;
        t:=d[random(r-l+1)+l];
        repeat
                while d[i]<t do inc(i);
                while d[j]>t do dec(j);
                if i<=j then
                begin
                        tmp:=d[i]; d[i]:=d[j]; d[j]:=tmp;
                        tt:=p[i]; p[i]:=p[j]; p[j]:=tt;
                        inc(i); dec(j);
                end;
        until i>j;
        sort(l,j,d,p); sort(i,r,d,p);
End;

Function Getb(x,i:longint):longint;
Begin
        getb:=x shr (i-1) and 1;
End;

Procedure Process;
Var     x,i,l,r,mid:longint;
        xx:int64;
Begin
        n1:=n div 2; n2:=n-n div 2;
        for x:=0 to 1 shl n1-1 do
        begin
                p1[x]:=x; d1[x]:=0;
                for i:=1 to n1 do
                        if getb(x,i)=0 then d1[x]:=(d1[x]+m10[i-1]*a) mod n0
                        else d1[x]:=(d1[x]+m10[i-1]*b) mod n0;
        end;
        sort(0,1 shl n1-1,d1,p1);
        for x:=0 to 1 shl n2-1 do
        begin
                p2[x]:=x; d2[x]:=0;
                for i:=1 to n2 do
                        if getb(x,i)=0 then d2[x]:=(d2[x]+m10[i-1+n1]*a) mod n0
                        else d2[x]:=(d2[x]+m10[i-1+n1]*b) mod n0;
        end;
        sort(0,1 shl n2-1,d2,p2);
        r1:=-1; r2:=-1;
        for i:=0 to 1 shl n1-1 do
        begin
                if d1[i]<=k then xx:=k-d1[i] else xx:=k-d1[i]+n0;
                l:=0; r:=1 shl n2-1;
                while l<r do
                begin
                        mid:=(l+r) shr 1;
                        if d2[mid]<xx then l:=mid+1 else r:=mid;
                end;
                if d2[l]=xx then
                begin
                        r1:=p1[i]; r2:=p2[l];
                        break;
                end;
        end;
        if r1=-1 then
        begin
                write(-1);
                exit;
        end;
        for i:=n2 downto 1 do
                if getb(r2,i)=0 then write(a) else write(b);
        for i:=n1 downto 1 do
                if getb(r1,i)=0 then write(a) else write(b);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
