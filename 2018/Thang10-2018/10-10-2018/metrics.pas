Const   ginp='metrics.inp';
        gout='metrics.out';
        maxn=100010;

Type    save= record val,pos:longint; sum:int64; end;

Var     m,n:longint;
        res:int64;
        a,b:array[0..maxn] of save;

Procedure Sort(l,r:longint; var d:array of save);
Var     i,j:longint;
        t,tmp:save;
Begin
        if l>=r then exit;
        i:=l; j:=r;
        t:=d[random(r-l+1)+l];
        repeat
                while d[i].val<t.val do inc(i);
                while d[j].val>t.val do dec(j);
                if i<=j then
                begin
                        tmp:=d[i]; d[i]:=d[j]; d[j]:=tmp;
                        inc(i); dec(j);
                end;
        until i>j;
        sort(l,j,d); sort(i,r,d);
End;

Function Binary_A(x:longint):longint;
Var     l,r,mid:longint;
Begin
        l:=1; r:=m+1;
        while l<r do
        begin
                mid:=(l+r) shr 1;
                if a[mid].val<x then l:=mid+1 else r:=mid;
        end;
        exit(l-1);
End;

Function Binary_B(x:longint):longint;
Var     l,r,mid:longint;
Begin
        l:=1; r:=n+1;
        while l<r do
        begin
                mid:=(l+r) shr 1;
                if b[mid].val<=x then l:=mid+1 else r:=mid;
        end;
        exit(l-1);
End;

Procedure Enter;
Var     i,j:longint;
Begin
        readln(m);
        for i:=1 to m do
        with a[i] do
        begin
                read(val); pos:=i;
        end;
        readln;
        readln(n);
        for j:=1 to n do
        with b[j] do
        begin
                read(val); pos:=j;
        end;
        sort(1,m,a); sort(1,n,b);
End;

Procedure Process;
Var     i,j:longint;
Begin
        for i:=1 to m do a[i].sum:=a[i-1].sum +a[i].pos;
        for j:=1 to n do b[j].sum:=b[j-1].sum +b[j].pos;
        res:=0;
        for i:=1 to m do
        begin
                j:=binary_b(a[i].val);
                res:=res +int64(2*j-n)*a[i].val*a[i].pos;
                res:=res +(b[n].sum -2*b[j].sum)*a[i].val;
        end;
        for j:=1 to n do
        begin
                i:=binary_a(b[j].val);
                res:=res +int64(m-2*i)*b[j].val*b[j].pos;
                res:=res +(2*a[i].sum-a[m].sum)*b[j].val;
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
