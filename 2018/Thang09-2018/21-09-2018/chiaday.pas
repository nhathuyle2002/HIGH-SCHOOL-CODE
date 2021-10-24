Const   ginp='chiaday.inp';
        gout='chiaday.out';
        maxn=100010;
        maxuc=10010;

Var     n,cou,res:longint;
        a:array[-maxuc..maxuc] of longint;
        s:array[0..maxn] of int64;

Procedure Enter;
Var     i:longint;
Begin
        readln(n);
        for i:=1 to n do
        begin
                read(s[i]);
                s[i]:=s[i]+s[i-1];
        end;
        cou:=0;
        for i:=1 to trunc(sqrt(s[n])) do
                if s[n] mod i=0 then
                begin
                        inc(cou);
                        a[-cou]:=i; a[cou]:=s[n] div i;
                end;
End;

Procedure Process;
Var     l,r,k,count:longint;
        ok:boolean;
Begin
        for k:=-1 downto -cou do
        begin
                l:=1; r:=0; count:=0; ok:=false;
                repeat
                        inc(count);
                        while (r<=n) and (s[r]-s[l-1]<a[k]) do inc(r);
                        if (r=n+1) or (s[r]-s[l-1]>a[k]) then break;
                        if (r=n) and (s[r]-s[l-1]=a[k]) then
                        begin
                                ok:=true; break;
                        end;
                        l:=r+1;
                until false;
                if ok then
                begin
                        write(count); exit;
                end;
        end;
        for k:=cou downto 1 do
        begin
                l:=1; r:=0; count:=0; ok:=false;
                repeat
                        inc(count);
                        while (r<=n) and (s[r]-s[l-1]<a[k]) do inc(r);
                        if (r=n+1) or (s[r]-s[l-1]>a[k]) then break;
                        if (r=n) and (s[r]-s[l-1]=a[k]) then
                        begin
                                ok:=true; break;
                        end;
                        l:=r+1;
                until false;
                if ok then
                begin
                        write(count); exit;
                end;
        end;
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
