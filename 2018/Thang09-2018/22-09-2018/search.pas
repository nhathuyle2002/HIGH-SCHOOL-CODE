Const   ginp='search.inp';
        gout='search.out';
        maxn=100010;

Var     m,n,p,res,cou:longint;
        c:array[0..maxn] of longint;
        d:array[0..maxn] of longint;
        a,b:array[0..maxn] of boolean;

Procedure Enter;
Var     i,x:longint;
Begin
        readln(m,n,p);
        for i:=1 to m do
        begin
                read(x); a[x]:=true;
        end;
        readln;
        for i:=1 to n do
        begin
                read(x); b[x]:=true;
        end;
        for i:=1 to p do read(c[i]);
End;

Procedure Push(x:longint);
Begin
        if a[x] then
        begin
                inc(d[x]);
                if d[x]=1 then inc(cou);
        end;
End;

Procedure Pop(x:longint);
Begin
        if a[x] then
        begin
                dec(d[x]);
                if d[x]=0 then dec(cou);
        end;
End;

Procedure Process;
Var     l,r:longint;
Begin
        cou:=0; l:=1; r:=0;
        repeat
                while (r<p) and (b[c[r+1]]) do
                begin
                        inc(r); push(c[r]);
                end;
                while (l<=r) do
                begin
                        pop(c[l]); inc(l);
                end;
                while (r<p) and (not b[c[r+1]]) do
                begin
                        inc(r); push(c[r]);
                end;
                if (cou=m) and (res<r-l+1) then res:=r-l+1;
        until l>p;
        write(res);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
