Const   ginp='invsort.inp';
        gout='invsort.out';
        maxn=100001;

Var     n,top:longint;
        a,pos,pos2:array[0..maxn] of longint;
        o1,o2:array[0..2*maxn] of longint;

Procedure Swap(var x,y:longint);
Var     tmp:longint;
Begin
        tmp:=x; x:=y; y:=tmp;
End;

Procedure Sort(l,r:longint);
Var     i,j,t:longint;
Begin
        if l>=r then exit;
        i:=l; j:=r;
        t:=a[random(r-l+1)+l];
        repeat
                while a[i]<t do inc(i);
                while a[j]>t do dec(j);
                if i<=j then
                begin
                        swap(a[i],a[j]);
                        swap(pos[i],pos[j]);
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
                pos[i]:=i;
        end;
        sort(1,n);
        for i:=1 to n do pos2[pos[i]]:=i;
End;

Procedure Process;
Var     i:longint;
Begin
        top:=0;
        for i:=1 to n do
        begin
                if i+1<pos[i]-1 then
                begin
                        inc(top);
                        o1[top]:=i+1; o2[top]:=pos[i]-1;
                end;
                if i<pos[i] then
                begin
                        inc(top);
                        o1[top]:=i; o2[top]:=pos[i];
                        pos[pos2[i]]:=pos[i];
                        pos2[pos[i]]:=pos2[i];
                end;
        end;
        writeln(top);
        for i:=1 to top do writeln(o1[i],' ',o2[i]);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
