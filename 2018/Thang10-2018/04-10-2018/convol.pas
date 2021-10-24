Uses    Math;

Const   ginp='convol.inp';
        gout='convol.out';
        maxn=101;

Var     n:longint;
        a,res,b:array[0..maxn] of longint;
        d:array[0..maxn] of boolean;

Function Cmp(x,y:array of longint):boolean;
Var     i:longint;
Begin
        for i:=1 to n do
                if x[i]<y[i] then exit(true) else
                if x[i]>y[i] then exit(false);
        exit(false);
End;

Procedure Create(ii,x:longint);
Var     i:longint;
Begin
        for i:=1 to n do b[i]:=0;
        for i:=1 to ii-1 do b[i]:=a[i];
        b[ii]:=x;
        for i:=1 to ii do
                if b[b[i]]=0 then b[b[i]]:=i;
End;

Function Check:boolean;
Var     i,j:longint;
        dd:array[0..maxn] of boolean;
Begin
        for i:=1 to n do dd[i]:=false;
        for i:=1 to n do
        if b[i]>0 then
        begin
                if (b[b[i]]<>i) or (dd[b[i]]) then exit(false);
                dd[b[i]]:=true;
        end;
        check:=true;
        j:=1;
        for i:=1 to n do
        if b[i]=0 then
        begin
                while dd[j] do inc(j);
                b[i]:=j; b[j]:=i;
                dd[j]:=true;
        end;
End;

Procedure Enter;
Var     i:longint;
Begin
        readln(n);
        for i:=1 to n do read(a[i]);
End;

Procedure Process;
Var     i,j:longint;
Begin
        for i:=1 to n do d[i]:=false;
        d[a[n]]:=true; b[0]:=1;
        for i:=n-1 downto 1 do
        begin
                d[a[i]]:=true;
                for j:=a[i]+1 to n+1 do
                if d[j] then
                begin
                        create(i,j);
                        if (check) and (cmp(a,b)) and ((res[0]=0) or (cmp(b,res))) then res:=b;
                end;
        end;
        for i:=1 to n do write(res[i],' ');
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
