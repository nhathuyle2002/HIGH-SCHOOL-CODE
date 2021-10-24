Const   ginp='ss.inp';
        gout='ss.out';
        maxr=10101;

Var     n,m,gmax,gmin:longint;
        a:array[0..101] of longint;

Procedure Enter;
Var     i:longint;
Begin
        readln(n); readln(m);
        gmax:=0;
        for i:=1 to n do
        begin
                readln(a[i]);
                if a[i]>gmax then gmax:=a[i];
        end;
        gmax:=gmax+m;
End;

Procedure Process;
Var     l,r,mid,i,sum:longint;
        ok:boolean;
Begin
        l:=1; r:=maxr;
        while l<r do
        begin
                mid:=(l+r) div 2; sum:=m;
                ok:=true;
                for i:=1 to n do
                        if a[i]>mid then ok:=false
                        else sum:=sum-mid+a[i];
                if (ok) and (sum<=0) then r:=mid else l:=mid+1;
        end;
        write(l,' ',gmax);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
