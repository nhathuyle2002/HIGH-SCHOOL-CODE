Const   ginp='bai2.inp';
        gout='bai2.out';
        maxn=501;

Var     n,m,k,minp:longint;
        a,res:ansistring;
        b:array[0..maxn] of ansistring;
        d:array[0..maxn] of longint;
        x:int64;
        mul:array[0..maxn] of int64;

Procedure Sort(l,r:longint; var c:ansistring);
Var     i,j:longint;
        t,tmp:char;
Begin
        if l>=r then exit;
        i:=l; j:=r;
        t:=c[random(r-l+1)+l];
        repeat
                while c[i]<t do inc(i);
                while c[j]>t do dec(j);
                if i<=j then
                begin
                        tmp:=c[i]; c[i]:=c[j]; c[j]:=tmp;
                        inc(i); dec(j);
                end;
        until i>j;
        sort(l,j,c); sort(i,r,c);
End;

Procedure Enter;
Var     i:longint;
Begin
        readln(n,m,k,x);
        readln(a);
        for i:=1 to m do
        begin
                readln(b[i]);
                sort(1,k,b[i]);
        end;
        minp:=m+1; mul[m+1]:=1;
        for i:=m downto 1 do
        begin
                mul[i]:=mul[i+1]*k;
                minp:=i;
                if mul[i]>x then break else;
        end;

End;

Procedure Process;
Var     i,cou:longint;
Begin
        for i:=1 to m do
                if i<minp then d[i]:=1 else
                begin
                        cou:=1;
                        while x>mul[i+1] do
                        begin
                                inc(cou);
                                x:=x-mul[i+1];
                        end;
                        d[i]:=cou;
                end;
        cou:=0; res:='';
        for i:=1 to n do
                if a[i]<>'#' then res:=res+a[i] else
                begin
                        inc(cou);
                        res:=res+b[cou,d[cou]];
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
