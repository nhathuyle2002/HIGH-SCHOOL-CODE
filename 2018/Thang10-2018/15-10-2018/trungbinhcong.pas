Uses    Math;

Const   ginp='trungbinhcong.inp';
        gout='trungbinhcong.out';
        err=0.001;
        maxn=100010;
        oo=10001;

Var     n:longint;
        a:array[0..maxn] of longint;

Procedure Enter;
Var     i:longint;
Begin
        readln(n);
        for i:=1 to n do readln(a[i]);
End;

Function Check(x:extended):boolean;
Var     i:longint;
        sum,smin:extended;
        sm:array[0..maxn] of extended;
Begin
        sm[0]:=oo; sum:=0;
        for i:=1 to n-2 do
        begin
                sum:=sum+a[i]-x;
                sm[i]:=min(sm[i-1],sum);
        end;
        sum:=0; smin:=oo;
        for i:=n downto 3 do
        begin
                sum:=sum+a[i]-x;
                smin:=min(smin,sum);
                if smin+sm[i-2]<=0 then exit(true);
        end;
        check:=false;
End;

Procedure Process;
Var     l,r,mid:extended;
Begin
        l:=0; r:=oo;
        while abs(r-l)>err do
        begin
                mid:=(l+r)/2;
                if check(mid) then r:=mid else l:=mid;
        end;
        l:=trunc(l*1000)/1000;
        if check(l) then write(l:0:3) else write((l+err):0:3);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
