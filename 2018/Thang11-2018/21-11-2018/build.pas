Const   ginp='build.inp';
        gout='build.out';
        maxn=100001;
        maxk=301;

Var     n,k,a,b,c:longint;
        s:ansistring;
        f:array[0..maxn,0..maxk] of longint;
        d:array[-maxn..maxn] of longint;

Procedure Enter;
Begin
        readln(a,b,c);
        readln(n,k);
        read(s);
End;

Procedure Process;
Var     i,j,td,w:longint;

        Function Min(x,y:longint):longint;
        Begin
                if x<y then min:=x else min:=y;
        End;

Begin
        for i:=-n to n do d[i]:=-1;
        td:=0;
        for i:=1 to n do
        begin
                if s[i]='R' then w:=a else
                begin
                        w:=b;
                        if s[i]='D' then dec(td) else inc(td);
                end;
                f[i,0]:=f[i-1,0]+w;
                for j:=1 to k do
                begin
                        f[i,j]:=min(f[i,j-1],f[i-1,j]+w);
                        if d[td]<>-1 then f[i,j]:=min(f[i,j],f[d[td],j-1]+c*(i-d[td]));
                end;
                d[td]:=i;
        end;
        write(f[n,k]);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
