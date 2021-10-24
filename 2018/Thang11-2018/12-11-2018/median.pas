Const   ginp='median.inp';
        gout='median.out';
        maxn=100010;

Var     n,m:longint;
        res:int64;
        sum,c0,pos:array[0..maxn] of longint;
        f0,f1:array[0..2*maxn] of longint;

Procedure Sort(l,r:longint);
Var     i,j,ts,tc,tmp:longint;
Begin
        if l>=r then exit;
        i:=l; j:=r;
        ts:=random(r-l+1)+l;
        tc:=c0[ts]; ts:=sum[ts];
        repeat
                while (sum[i]<ts) or ((sum[i]<ts) and (c0[i]<tc)) do inc(i);
                while (sum[j]>ts) or ((sum[j]=ts) and (c0[j]>tc)) do dec(j);
                if i<=j then
                begin
                        tmp:=sum[i]; sum[i]:=sum[j]; sum[j]:=tmp;
                        tmp:=c0[i]; c0[i]:=c0[j]; c0[j]:=tmp;
                        tmp:=pos[i]; pos[i]:=pos[j]; pos[j]:=tmp;
                        inc(i); dec(j);
                end;
        until i>j;
        sort(l,j); sort(i,r);
End;

Procedure Update0(i:longint);
Begin
        if i>2*n+1 then exit;
        f0[i]:=f0[i]+1;
        update0(i+i and (-i));
End;

Procedure Update1(i:longint);
Begin
        if i>2*n+1 then exit;
        f1[i]:=f1[i]+1;
        update1(i+i and (-i));
End;

Function Quece0(i:longint):longint;
Begin
        if i<1 then exit(0);
        quece0:=f0[i]+quece0(i-i and (-i));
End;

Function Quece1(i:longint):longint;
Begin
        if i<1 then exit(0);
        quece1:=f1[i]+quece1(i-i and (-i));
End;

Procedure Enter;
Var     i:longint;
Begin
        readln(n,m);
        pos[0]:=0; sum[0]:=0; c0[0]:=0;
        for i:=1 to n do
        begin
                pos[i]:=i;
                read(sum[i]);
                if sum[i]<m then sum[i]:=-1 else
                if sum[i]>m then sum[i]:=1 else
                sum[i]:=0;
                if sum[i]=0 then c0[i]:=c0[i-1]+1 else c0[i]:=c0[i-1];
                sum[i]:=sum[i-1]+sum[i];
        end;
        sort(0,n);
End;

Procedure Process1;
Var     i:longint;
Begin
        fillchar(f0,sizeof(f0),0);
        fillchar(f1,sizeof(f1),0);
        for i:=0 to n do
        begin
                if pos[i] mod 2=0 then
                begin
                        res:=res+quece1(c0[i]-sum[i]+n);
                        update0(c0[i]-sum[i]+1+n);
                end;
                if pos[i] mod 2=1 then
                begin
                        res:=res+quece0(c0[i]-sum[i]+n);
                        update1(c0[i]-sum[i]+1+n);
                end;
        end;
End;

Procedure Process2;
Var     i:longint;
Begin
        fillchar(f0,sizeof(f0),0);
        fillchar(f1,sizeof(f1),0);
        for i:=n downto 0 do
        begin
                if pos[i] mod 2=0 then
                begin
                        res:=res+quece1(c0[i]+sum[i]+n);
                        update0(c0[i]+sum[i]+1+n);
                end;
                if pos[i] mod 2=1 then
                begin
                        res:=res+quece0(c0[i]+sum[i]+n);
                        update1(c0[i]+sum[i]+1+n);
                end;
        end;
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process1;
        Process2;
        write(res);
        Close(input); Close(output);
End.
