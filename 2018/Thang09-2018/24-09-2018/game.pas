Const   ginp='game.inp';
        gout='game.out';
        maxn=100010;

Var     n:longint;
        res:qword;
        a,b:array[0..maxn] of int64;

Procedure Sort(l,r:longint; var d:array of int64);
Var     i,j:longint;
        t,tmp:int64;
begin
        if l>=r then exit;
        i:=l; j:=r;
        t:=d[random(r-l+1)+l];
        repeat
                while d[i]<t do inc(i);
                while d[j]>t do dec(j);
                if i<=j then
                begin
                        tmp:=d[i]; d[i]:=d[j]; d[j]:=tmp;
                        inc(i); dec(j);
                end;
        until i>j;
        sort(l,j,d); sort(i,r,d);
end;

Function Abs(x:int64):int64;
Begin
        if x<0 then abs:=-x else abs:=x;
End;

Function Min(x,y:qword):qword;
Begin
        if x<y then min:=x else min:=y;
End;

Procedure Answer(x,y:int64);
Begin
        if ((x<0) and (y>0)) or ((x>0) and (y<0)) then res:=min(res,qword(abs(x+y)))
        else res:=min(res,qword(abs(x))+qword(abs(y)));
End;

Procedure Enter;
Var     i:longint;
Begin
        readln(n);
        for i:=1 to n do read(a[i]);
        sort(1,n,a); readln;
        for i:=1 to n do read(b[i]);
        sort(1,n,b);
End;

Procedure Process;
Var     i,j:longint;
Begin
        res:=high(qword); j:=n;
        for i:=1 to n do
        begin
                while (j>0) and (b[j]>=-a[i]) do dec(j);
                if j>0 then answer(a[i],b[j]);
                if j<n then answer(a[i],b[j+1]);
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
