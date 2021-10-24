Const   ginp='valuestr.inp';
        gout='valuestr.out';
        maxn=1000010;

Var     n,res:longint;
        c:int64;
        s:ansistring;
        da,db:array[0..maxn] of longint;
        sum:array[0..maxn] of int64;

Procedure Enter;
Var     i:longint;
Begin
        readln(n,c);
        read(s);
        for i:=n downto 1 do
        begin
                da[i]:=da[i+1];
                db[i]:=db[i+1];
                sum[i]:=sum[i+1];
                if s[i]='a' then
                begin
                        inc(da[i]);
                        sum[i]:=sum[i]+db[i];
                end else
                if s[i]='b' then
                        inc(db[i]);
        end;
End;

Procedure Process;
Var     i,l,r,mid:longint;
        rr:int64;
Begin
        res:=0;
        for i:=1 to n do
        begin
                l:=i; r:=n+1;
                while l<r do
                begin
                        mid:=(l+r) shr 1;
                        rr:=sum[i]-sum[mid+1]-int64(da[i]-da[mid+1])*db[mid+1];
                        if rr<=c then l:=mid+1 else r:=mid;
                end;
                if l-i>res then res:=l-i;
        end;
        write(res);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
