Uses    Math;

Const   ginp='is.inp';
        gout='is.out';
        maxn=100010;

Var     n,ir,cou:longint;
        a,w,trace,bit,o:array[0..maxn] of longint;
        f:array[0..maxn] of int64;

Procedure Sort(l,r:longint; var d,p:array of longint);
Var     i,j,t,tmp:longint;
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
                        tmp:=p[i]; p[i]:=p[j]; p[j]:=tmp;
                        inc(i); dec(j);
                end;
        until i>j;
        sort(l,j,d,p); sort(i,r,d,p);
End;

Procedure Enter;
Var     i:longint;
Begin
        readln(n);
        for i:=1 to n do read(a[i]);
        readln;
        for i:=1 to n do read(w[i]);
End;

Function Query(i:longint):longint;
Var     j:longint;
Begin
        if i<1 then exit(0);
        j:=query(i-i and (-i));
        if f[bit[i]]<f[j] then exit(j) else exit(bit[i]);
End;

Procedure Update(i,j:longint);
Begin
        if i>maxn then exit;
        if f[bit[i]]<f[j] then
        begin
                bit[i]:=j;
                update(i+i and (-i),j);
        end;
End;

Procedure Process;
Var     i:longint;
        tmp:int64;
Begin
        ir:=0; f[0]:=0;
        for i:=1 to n do
        begin
                trace[i]:=query(a[i]-1);
                f[i]:=f[trace[i]]+w[i];
                update(a[i],i);
                if f[i]>f[ir] then ir:=i;
        end;
        cou:=0;
        while ir<>0 do
        begin
                inc(cou); o[cou]:=ir;
                ir:=trace[ir];
        end;
        writeln(cou);
        for i:=cou downto 1 do write(o[i],' ');
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
