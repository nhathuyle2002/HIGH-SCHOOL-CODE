Uses    Math;

Const   ginp='paren.inp';
        gout='paren.out';
        mn=30;
        base=trunc(1e9);

Type    bignum= array[0..mn] of longint;
        mang= array[0..101,0..101,0..101] of bignum;

Var     n,mb:longint;
        sh,res:bignum;
        s:string;
        f:mang;
        d:array[0..101,0..101,0..101] of boolean;

Function Setb(x:longint):bignum;
Begin
        setb[0]:=0;
        while x>0 do
        begin
                inc(setb[0]);
                setb[setb[0]]:=x mod base;
                x:=x div base;
        end;
End;

Procedure Wop(x:bignum);
Var     i:longint;
        c:string[10];
Begin
        write(x[x[0]]);
        for i:=x[0]-1 downto 1 do
        begin
                str(x[i],c);
                while length(c)<9 do c:='0'+c;
                write(c);
        end;
        writeln;
End;

Function Cmp(a,b:bignum):boolean;
Var     i:longint;
Begin
        if a[0]<>b[0] then exit(a[0]<b[0]);
        for i:=a[0] downto 1 do
                if a[i]<>b[i] then exit(a[i]<b[i]);
        exit(false);
End;

Operator + (a,b:bignum) h:bignum;
Var     i,nho:longint;
        c:bignum;
Begin
        c[0]:=max(a[0],b[0]);
        nho:=0;
        for i:=1 to c[0] do
        begin
                if i>a[0] then a[i]:=0;
                if i>b[0] then b[i]:=0;
                c[i]:=a[i]+b[i]+nho;
                if c[i]>=base then
                begin
                        nho:=1;
                        c[i]:=c[i]-base;
                end
                else    nho:=0;
        end;
        if nho>0 then
        begin
                inc(c[0]);
                c[c[0]]:=nho;
        end;
        h:=c;
End;

Operator - (a,b:bignum) c:bignum;
Var     i,nho:longint;
Begin
        c[0]:=a[0];
        nho:=0;
        for i:=1 to c[0] do
        begin
                if i>a[0] then a[i]:=0;
                if i>b[0] then b[i]:=0;
                c[i]:=a[i]-b[i]-nho;
                if c[i]<0 then
                begin
                        nho:=1;
                        c[i]:=c[i]+base;
                end
                else    nho:=0;
        end;
        while (c[0]>0) and (c[c[0]]=0) do dec(c[0]);
End;

Procedure Enter;
Var     t:string;
Begin
        read(n,mb);
        read(t);
        while t[1]=' ' do delete(t,1,1);
        while t[length(t)]=' ' do delete(t,length(t),1);
        sh[0]:=0;
        while length(t)>9 do
        begin
                inc(sh[0]);
                val(copy(t,length(t)-9+1,9),sh[sh[0]]);
                delete(t,length(t)-9+1,9);
        end;
        inc(sh[0]);
        val(t,sh[sh[0]]);
End;

Function Calc(i,c,maxc:longint):bignum;
Var     sum:bignum;
Begin
        if d[i,c,maxc] then exit(f[i,c,maxc]);
        if i>n then
        begin
                if (maxc=mb) and (c=0) then
                begin
                        f[i,c,maxc]:=setb(1);
                end
                else    f[i,c,maxc]:=setb(0);
                d[i,c,maxc]:=true;
                exit(f[i,c,maxc]);
        end;
        sum:=setb(0);
        if c<mb then sum:=sum+calc(i+1,c+1,max(maxc,c+1));
        if c>0 then sum:=sum+calc(i+1,c-1,max(maxc,c-1));
        f[i,c,maxc]:=sum;
        d[i,c,maxc]:=true;
        calc:=sum;
End;

Procedure Tryv(i,c,maxc:longint);
Var     tmp:bignum;
Begin
        if i>n then exit;
        tmp:=calc(i+1,c+1,max(maxc,c+1));
        if (c>0) and (cmp(tmp,sh)) then
        begin
                s:=s+')'; sh:=sh-tmp;
                tryv(i+1,c-1,max(maxc,c-1));
        end else
        begin
                s:=s+'(';
                tryv(i+1,c+1,max(maxc,c+1));
        end;
End;

Procedure Solve;
Var     i,j,k:longint;
Begin
        for i:=0 to n do
                for j:=0 to mb do
                        for k:=0 to mb do d[i,j,k]:=false;
        res:=calc(1,0,0);
        wop(res);
        s:='';
        Tryv(1,0,0);
        write(s);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Solve;
        Close(input); Close(output);
End.
