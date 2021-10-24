Const   ginp='counts.inp';
        gout='counts.out';
        maxn=100001;

Var     n,tb,cou:longint;
        res:int64;
        pos,f,p:array[0..maxn] of longint;
        s:array[-1..maxn] of int64;

Procedure Sort(l,r:longint);
Var     i,j,tt:longint;
        t,tmp:int64;
Begin
        if l>=r then exit;
        i:=l; j:=r;
        t:=s[random(r-l+1)+l];
        repeat
                while s[i]<t do inc(i);
                while s[j]>t do dec(j);
                if i<=j then
                begin
                        tmp:=s[i]; s[i]:=s[j]; s[j]:=tmp;
                        tt:=p[i]; p[i]:=p[j]; p[j]:=tt;
                        inc(i); dec(j);
                end;
        until i>j;
        sort(l,j); sort(i,r);
End;


Procedure Enter;
Var     i:longint;
Begin
        readln(n,tb);
        s[0]:=0; p[0]:=0;
        for i:=1 to n do
        begin
                read(s[i]);
                s[i]:=s[i]+s[i-1]-tb;
                p[i]:=i;
        end;
        sort(0,n);
        cou:=0; s[-1]:=trunc(1e16);
        for i:=0 to n do
        begin
                if s[i]<>s[i-1] then inc(cou);
                pos[p[i]]:=cou;
        end;
End;

Function Quece(i:longint):longint;
Begin
        if i<1 then exit(0);
        quece:=f[i]+quece(i-i and (-i));
End;

Procedure Update(i,x:longint);
Begin
        if i>cou then exit;
        f[i]:=f[i]+x;
        update(i+i and (-i),x);
End;

Procedure Process;
Var     i:longint;
Begin
        fillchar(f,sizeof(f),0);
        for i:=n downto 0 do
        begin
                res:=res+quece(pos[i]);
                update(pos[i],1);
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
