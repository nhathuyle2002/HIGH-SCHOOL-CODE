Uses    Math;

Const   ginp='gifts.inp';
        gout='gifts.out';
        maxn=1001;

Var     n,cou:longint;
        a,b,pos:array[0..maxn] of longint;
        ox,oy:array[0..100001] of longint;

Procedure Swap(Var x,y:longint);
Var     tmp:longint;
Begin
        tmp:=x; x:=y; y:=tmp;
End;

Procedure Enter;
Var     i:longint;
Begin
        readln(n);
        for i:=1 to n do readln(a[i],b[i]);
End;

Procedure Sort(l,r:longint);
Var     i,j,t:longint;
Begin
        if l>=r then exit;
        i:=l; j:=r;
        t:=a[pos[random(r-l+1)+l]];
        repeat
                while a[pos[i]]>t do inc(i);
                while a[pos[j]]<t do dec(j);
                if i<=j then
                begin
                        swap(pos[i],pos[j]);
                        inc(i); dec(j);
                end;
        until i>j;
        sort(l,j); sort(i,r);
End;

Procedure Process;
Var     i,j:longint;
Begin
        cou:=0;
        for i:=1 to n do
        begin
                for j:=1 to n do pos[j]:=j;
                sort(1,n);
                for j:=1 to n do
                        if (i<>pos[j]) and (a[pos[j]]>0) and (b[i]>0) then
                        begin
                                inc(cou);
                                ox[cou]:=i; oy[cou]:=pos[j];
                                dec(b[i]); dec(a[pos[j]]);
                        end;
                if b[i]>0 then
                begin
                        write('NO');
                        exit;
                end;
        end;
        writeln('YES');
        for i:=1 to cou do writeln(ox[i],' ',oy[i]);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
