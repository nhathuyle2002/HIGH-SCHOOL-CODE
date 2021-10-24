Const   ginp='lexic.inp';
        gout='lexic.out';
        maxn=26;
        maxk=26;
        mn=5;
        base=trunc(1e9);

Type    bignum= array[0..mn] of int64;

Var     f:array[0..maxn,0..maxk] of bignum;
        n,m,st:longint;
        cs:string[2];
        s:string;
        sh:bignum;

Function Max(x,y:longint):longint;
Begin
        if x>y then max:=x else max:=y;
End;

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

Function Cmp(a,b:bignum):boolean;
Var     i:longint;
Begin
        if a[0]<>b[0] then exit(a[0]<b[0]);
        for i:=a[0] downto 1 do
                if a[i]<>b[i] then exit(a[i]<b[i]);
        exit(false);
End;

Operator + (a,b:bignum) c:bignum;
Var     i,nho:longint;
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
End;

Operator - (a,b:bignum) c:bignum;
Var     i,nho:longint;
Begin
        c[0]:=a[0];
        nho:=0;
        for i:=1 to c[0] do
        begin
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

Operator * (a,b:bignum) c:bignum;
Var     i,j:longint;
        nho:int64;
Begin
        c[0]:=a[0]+b[0];
        for i:=1 to c[0] do c[i]:=0;
        nho:=0;
        for i:=1 to a[0] do
        begin
                for j:=1 to b[0] do
                begin
                        c[i+j-1]:=c[i+j-1]+a[i]*b[j]+nho;
                        nho:=c[i+j-1] div base;
                        c[i+j-1]:=c[i+j-1] mod base;
                end;
                while nho>0 do
                begin
                        inc(j);
                        c[i+j-1]:=c[i+j-1]+nho;
                        nho:=c[i+j-1] div base;
                        c[i+j-1]:=c[i+j-1] mod base;
                end;
        end;
        if c[c[0]]=0 then dec(c[0]);
End;

Procedure Init;
Var     i,j:longint;
Begin
        f[0,0]:=setb(1);
        for i:=1 to maxn do
        begin
                f[i,0]:=setb(1);
                for j:=1 to maxk do
                        f[i,j]:=f[i-1,j-1]*setb(i);
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

Procedure Enter;
Begin
        readln(n,m);
        read(cs);
        readln(s);
        if cs='W ' then
        begin
                sh[0]:=0;
                while length(s)>9 do
                begin
                        inc(sh[0]);
                        val(copy(s,length(s)-9+1,9),sh[sh[0]]);
                        delete(s,length(s)-9+1,9);
                end;
                inc(sh[0]);
                val(s,sh[sh[0]]);
        end;
End;

Procedure Process1;
Var     i,j:longint;
        d:array['a'..'z'] of boolean;
Begin
        if length(s)<>m then
        begin
                writeln('Incorrect data');
                exit;
        end;
        fillchar(d,sizeof(d),true);
        for i:=1 to m do
                if (ord(s[i])-ord('a')+1>n) or (not d[s[i]]) then
                begin
                        writeln('Incorrect data');
                        exit;
                end
                else    d[s[i]]:=false;
        fillchar(d,sizeof(d),true);
        sh:=setb(1);
        for i:=1 to m do
        begin
                for j:=1 to ord(s[i])-ord('a') do
                        if d[chr(j+ord('a')-1)] then sh:=sh+f[n-i,m-i];
                d[s[i]]:=false;
        end;
        wop(sh);
End;

Procedure Process2;
Var     i,j:longint;
        d:array[1..26] of boolean;
Begin
        if cmp(f[n,m],sh) then
        begin
                writeln('Incorrect data');
                exit;
        end;
        fillchar(d,sizeof(d),true);
        s:='';
        for i:=1 to m do
        begin
                for j:=1 to n do
                        if d[j] then
                        begin
                                if cmp(f[n-i,m-i],sh) then sh:=sh-f[n-i,m-i] else break;
                        end;
                s:=s+chr(j+ord('a')-1); d[j]:=false;
        end;
        writeln(s);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Init;
        readln(st);
        while st>0 do
        begin
                Enter;
                if n<m then writeln('Incorrect data') else
                if cs='P ' then Process1 else Process2;
                dec(st);
        end;
        Close(input); Close(output);
End.
