Const   ginp='wedding.inp';
        gout='wedding.out';
        maxn=1500010;

Var     k,m,n:longint;
        modul:int64;
        a,b,p:array[0..maxn] of int64;
        ok:boolean;

Function Gcd(a,b:int64):int64;
Begin
        if b=0 then exit(a);
        gcd:=gcd(b,a mod b);
End;

Function Lcm(a,b:int64):int64;
Begin
        lcm:=a div gcd(a,b)*b;
End;

Procedure Enter;
Var     i:longint;
Begin
        readln(k,modul);
        for i:=0 to k-1 do read(p[i]);
End;

Procedure Dequyb(i:longint);
Var     j,i2:longint;
        o:boolean;
Begin
        if i=n then
        begin
                ok:=true;
                exit;
        end;
        for j:=0 to modul-1 do
        begin
                o:=true;
                for i2:=0 to m do
                        if i2*n+i>=k then break else
                        if (a[i2]*j-p[i2*n+i]) mod modul<>0 then
                        begin
                                o:=false;
                                break;
                        end;
                if o then
                begin
                        b[i]:=j;
                        dequyb(i+1);
                        if ok then exit;
                end;
        end;
End;

Procedure Dequya(i:longint);
Var     j:longint;
Begin
        if i=m then
        begin
                dequyb(0);
                exit;
        end;
        for j:=0 to modul-1 do
        begin
                a[i]:=j;
                dequya(i+1);
                if ok then exit;
        end;
End;

Procedure Process;
Var     i,j:longint;
Begin
        m:=2;
        repeat
                n:=k div m;
                if n<=1 then
                begin
                        write('NO');
                        exit;
                end;
                if k mod m=0 then
                begin
                        ok:=false;
                        dequya(0);
                        if ok then
                        begin
                                writeln('YES');
                                write(m,' '); for i:=0 to m-1 do write(a[i],' '); writeln;
                                write(n,' '); for j:=0 to n-1 do write(b[j],' ');
                                exit;
                        end;
                end;
                inc(m);
        until false;
        {for j:=0 to n do b[j]:=1;
        for i:=0 to m do
        begin
                a[i]:=0;
                for j:=0 to n do
                        if i*n+j>=k then break else a[i]:=gcd(a[i],modul+p[i*n+j]);
                a[i]:=a[i]*(modul div a[i]);
                for j:=0 to n do
                begin
                        b[j]:=lcm(b[j],(modul+p[i*n+j]) div gcd(a[i],modul+p[n*i+j]));
                        if b[j]>=modul then
                        begin
                                write('NO');
                                exit;
                        end;
                end;
        end;
        writeln('YES');
        for i:=0 to m do write(a[i]); writeln;
        for j:=0 to n do write(b[i]);}
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
