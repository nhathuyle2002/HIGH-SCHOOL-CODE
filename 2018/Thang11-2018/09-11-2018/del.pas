Const   ginp='del.inp';
        gout='del.out';
        maxg=trunc(1e18);

Var     st,n:longint;
        a:array[0..11] of qword;
        pos,sum:qword;

Function Gcd(a,b:qword):qword;
Begin
        if b=0 then exit(a);
        gcd:=gcd(b,a mod b);
End;

Procedure Try(stt,ii:longint; mul,nn:qword);
Var     i:longint;
Begin
        if mul>nn then exit;
        if (stt>0) and (stt mod 2=1) then sum:=sum+nn div mul else
        if (stt>0) and (stt mod 2=0) then sum:=sum-nn div mul;
        for i:=ii+1 to n do
                try(stt+1,i,mul div gcd(mul,a[i])*a[i],nn);
End;

Procedure Enter;
Var     i:longint;
Begin
        readln(n,pos);
        for i:=1 to n do read(a[i]);
        readln;
End;

Procedure Process;
Var     l,r,mid:qword;
Begin
        l:=1; r:=maxg;
        while l<r do
        begin
                mid:=(l+r) shr 1;
                sum:=0;
                try(0,0,1,mid);
                if mid-sum<pos then l:=mid+1 else r:=mid;
        end;
        writeln(l);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        readln(st);
        for st:=1 to st do
        begin
                Enter;
                Process;
        end;
        Close(input); Close(output);
End.
