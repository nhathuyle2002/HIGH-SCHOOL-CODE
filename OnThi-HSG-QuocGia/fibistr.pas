Uses    Math;

Const   ginp='fibistr.inp';
        gout='fibistr.out';
        mn=31;

Var     n,ns:longint;
        lg:array[0..mn] of longint;
        a:array[0..mn] of ansistring;
        s:ansistring;
        dc,dl:int64;
        dp:array[0..100] of qword;

Procedure Enter;
Var     i,j:longint;
Begin
        a[1]:='A'; a[2]:='B';
        for i:=3 to mn do a[i]:=a[i-1]+a[i-2];
        for i:=1 to mn do lg[i]:=length(a[i]);
End;

Function Z_Func(a,b:ansistring):longint;
Var     l,r,i,nn,cou:longint;
        z:array of longint;
Begin
        nn:=length(a); cou:=0;
        a:=a+'#'+b;
        setlength(z,length(a)+1);
        z[1]:=0; l:=1; r:=1;
        for i:=2 to length(a) do
        begin
                if i<=r then z[i]:=min(r-i+1,z[i-l+1]) else z[i]:=0;
                while (i+z[i]<=length(a)) and (a[1+z[i]]=a[i+z[i]]) do inc(z[i]);
                if r<i+z[i]-1 then
                begin
                        l:=i; r:=i+z[i]-1;
                end;
                if z[i]=nn then inc(cou);
        end;
        z_func:=cou;
End;

Procedure Process;
Var     i,p,cou:longint;
        tmp:int64;
Begin
        readln(n,s);
        if n=0 then exit;
        while s[1]=' ' do delete(s,1,1);
        ns:=length(s);

        if n<mn then
        begin
                writeln(z_func(s,a[n]));
                exit;
        end;

        if ns=1 then
        begin
                if s='A' then dp[1]:=1 else dp[2]:=1;
                for i:=3 to n do dp[i]:=dp[i-1]+dp[i-2];
                writeln(dp[n]);
                exit;
        end;

        for p:=7 to mn do
                if lg[p-2]>=ns-1 then break;

        dp[p-2]:=z_func(s,a[p-2]);
        dp[p-1]:=z_func(s,a[p-1]);

        dc:=z_func(s,copy(a[p-1],lg[p-1]-ns+2,ns-1)+copy(a[p-2],1,ns-1));
        dl:=z_func(s,copy(a[p],lg[p]-ns+2,ns-1)+copy(a[p-1],1,ns-1));

        if p mod 2=1 then
        begin
                tmp:=dl; dl:=dc; dc:=tmp;
        end;

        for i:=p to n do
                if i mod 2=0 then dp[i]:=dp[i-1]+dp[i-2]+dc else
                dp[i]:=dp[i-1]+dp[i-2]+dl;

        writeln(dp[n]);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        while not eof do Process;
        Close(input); Close(output);
End.
