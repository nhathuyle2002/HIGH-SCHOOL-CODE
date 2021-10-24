Const   ginp='makerect.inp';
        gout='makerect.out';
        maxn=200010;

Var     n,r1,r2:longint;
	a,d:array[0..maxn] of longint;

Procedure Sort(l,r:longint);
Var	i,j,t,tmp:longint;
Begin
	if l>=r then exit;
        i:=l; j:=r;
        t:=a[random(r-l+1)+l];
        repeat
        	while a[i]<t do inc(i);
                while a[j]>t do dec(j);
                if i<=j then
                begin
                	tmp:=a[i]; a[i]:=a[j]; a[j]:=tmp;
                        inc(i); dec(j);
                end;
        until i>j;
        sort(l,j); sort(i,r);
End;

Procedure Enter;
Var     i:longint;
Begin
	readln(n);
        for i:=1 to n do read(a[i]);
        sort(1,n);
End;

Procedure Process;
Var     i:longint;
Begin
	r1:=0; r2:=0;
        for i:=n-1 downto 1 do
        	if (a[i]=a[i+1]) and (d[i+1]=0) then
                begin
                	if r1=0 then r1:=a[i] else
                        if r2=0 then r2:=a[i];
                        if r2>0 then break;
                        d[i]:=1;
                end;
        write(int64(r1)*r2);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
