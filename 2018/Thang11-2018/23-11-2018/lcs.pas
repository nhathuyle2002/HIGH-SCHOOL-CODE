Uses    Math;

Const   ginp='lcs.inp';
        gout='lcs.out';
        maxn=5001;

Var     st,res:longint;
        a,b:ansistring;
        f:array[0..maxn,0..maxn] of longint;
        next:array[0..maxn,'!'..'z'] of longint;

Procedure Enter;
Var     c:ansistring;
Begin
        readln(a);
        readln(b);
        if length(a)>length(b) then
        begin
                c:=a; a:=b; b:=c;
        end;
End;

Procedure Process;
Var     i,j:longint;
Begin
        res:=0;
        for i:=0 to length(a) do f[i,0]:=0;
        for j:=1 to length(b) do f[0,j]:=0;
        for i:=1 to length(a) do
                for j:=1 to length(b) do
                        if a[i]=b[j] then
                        begin
                                f[i,j]:=f[i-1,j-1]+1;
                                res:=max(res,f[i,j]);
                        end
                        else f[i,j]:=max(f[i-1,j],f[i,j-1]);
        writeln(res);
End;

Procedure Init2;
Var     i:longint;
        x:char;
Begin
        for i:=length(b)+1 downto 1 do
        begin
                for x:='!' to 'z' do
                        if i=length(b)+1 then next[i,x]:=maxn+1 else
                        if b[i]=x then next[i,x]:=i else
                        next[i,x]:=next[i+1,x];
        end;
End;

Procedure Process2;
Var     i,j:longint;
Begin
        for i:=0 to length(a) do
                for j:=0 to i do f[i,j]:=maxn+1;
        res:=0;
        f[0,0]:=0;
        for i:=0 to length(a)-1 do
                for j:=0 to i do
                        if f[i,j]<>maxn+1 then
                        begin
                                f[i+1,j]:=min(f[i+1,j],f[i,j]);
                                if next[f[i,j]+1,a[i+1]]<>maxn+1 then
                                begin
                                        res:=max(res,j+1);
                                        f[i+1,j+1]:=min(f[i+1,j+1],next[f[i,j]+1,a[i+1]]);
                                end;
                        end;
        writeln(res);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        //readln(st);
        for st:=1 to 1 do//st do
        begin
                Enter;
                //Process;
                Init2;
                Process2;
        end;
        Close(input); Close(output);
End.
