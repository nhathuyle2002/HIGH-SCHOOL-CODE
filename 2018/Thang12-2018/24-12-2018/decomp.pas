Const   ginp='decomp.inp';
        gout='decomp.out';
        maxn=1000010;

Var     n,cou,top:longint;
        s,res:ansistring;
        l,r,p,q:array[0..maxn] of longint;
        sl:array[0..maxn] of ansistring;

Procedure Enter;
Var     i,j,x:longint;
        id:array[0..maxn] of longint;
Begin
        read(s); s:='('+s+')';
        n:=length(s);
        top:=0; j:=0;
        for i:=1 to n do
                if (s[i]>='0') and (s[i]<='9') and (i>j) then
                begin
                        inc(cou); l[cou]:=i-1; r[cou]:=i-1;
                        j:=i;
                        sl[cou]:='';
                        while (j<=n) and (s[j]>='0') and (s[j]<='9') do
                        begin
                                sl[cou]:=sl[cou]+s[j];
                                inc(j);
                        end;
                        if sl[cou]='' then sl[cou]:='1';
                end else
                if s[i]='(' then
                begin
                        inc(cou); l[cou]:=i;
                        id[i]:=cou;
                        inc(top); q[top]:=i;
                end else
                if s[i]=')' then
                begin
                        x:=id[q[top]];
                        r[x]:=i-1; sl[x]:='';
                        j:=i+1;
                        while (j<=n) and (s[j]>='0') and (s[j]<='9') do
                        begin
                                sl[x]:=sl[x]+s[j];
                                inc(j);
                        end;
                        if sl[x]='' then sl[x]:='1';
                        dec(top);
                end;
End;

Function Ccl(x:ansistring):longint;
Var     i:longint;
Begin
        ccl:=0;
        for i:=1 to length(x) do
                ccl:=ccl*10+ord(x[i])-48;
End;

Procedure Process;
Var     i,j,k,nn,jj:longint;
Begin
        res:='';
        i:=1; j:=1; top:=0;
        repeat
                while (j<=cou) and (l[j]<i) do inc(j);
                if i=l[j] then
                begin
                        if ccl(sl[j])=0 then i:=r[j]+1 else
                        begin
                                p[j]:=length(res)+1;
                                inc(top); q[top]:=j;
                        end;
                        inc(j);
                end;
                if (s[i]>='A') and (s[i]<='Z') then res:=res+s[i];
                if i=r[q[top]] then
                begin
                        nn:=length(res);
                        for k:=1 to ccl(sl[q[top]])-1 do
                                for jj:=p[q[top]] to nn do res:=res+res[jj];
                        dec(top);
                end;
                inc(i);
        until i=n+1;
        write(res);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
