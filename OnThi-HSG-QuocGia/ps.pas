Uses    Math;

Const   ginp='ps.inp';
        gout='ps.out';
        maxn=1000001;

Var     n,n0,l,r,mi:longint;
        a,pos,maxp,minp:array[0..maxn] of int64;

Procedure Sort(l,r:longint);
Var     i,j,tmp:longint;
        t,tt:int64;
Begin
        if l>=r then exit;
        i:=l; j:=r;
        t:=a[random(r-l+1)+l];
        repeat
                while a[i]<t do inc(i);
                while a[j]>t do dec(j);
                if i<=j then
                begin
                        tt:=a[i]; a[i]:=a[j]; a[j]:=tt;
                        tmp:=pos[i]; pos[i]:=pos[j]; pos[j]:=tmp;
                        inc(i); dec(j);
                end;
        until i>j;
        sort(l,j); sort(i,r);
End;

Procedure Enter;
Var     i:longint;
Begin
        readln(n);
        for i:=1 to n do
        begin
                read(a[i]);
                a[i]:=a[i]+a[i-1];
                pos[i]:=i;
        end;
        sort(1,n);
End;

Procedure Process;
Var     i:longint;
Begin
        l:=0; r:=-1; mi:=n+1;
        n0:=0; a[0]:=-trunc(1e13);
        for i:=1 to n do
        begin
                if a[i]>0 then r:=max(r,pos[i]);
                if a[i]=a[n0] then
                begin
                        maxp[n0]:=max(maxp[n0],pos[i]);
                        minp[n0]:=min(minp[n0],pos[i]);
                end else
                begin
                        inc(n0);
                        a[n0]:=a[i];
                        maxp[n0]:=pos[i];
                        minp[n0]:=pos[i];
                end;
        end;
        for i:=1 to n0 do
        begin
                if maxp[i]-mi>r-l then
                begin
                        r:=maxp[i]; l:=mi;
                end;
                mi:=min(mi,minp[i]);
        end;
        write(l+1,' ',r);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
