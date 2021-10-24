Const   ginp='gen.inp';
        gout='gen.out';
        base=211;
        modul= trunc(1e9)+13;
        maxn=1000010;

Var     n:longint;
        a:array[0..maxn] of ansistring;
        leng:array[0..maxn] of longint;
        hash:array[0..maxn] of array of int64;

Procedure Sort(l,r:longint);
Var     i,j:longint;
        t,tmp:ansistring;
Begin
        if l>=r then exit;
        i:=l; j:=r;
        t:=a[random(r-l+1)+l];
        repeat
                while a[i]<t do inc(i);
                while a[j]>t do dec(j);
                if i<=j then
                begin
                        tmp:=a[i]; a[i]:=a[j]; a[j]:=tmp;
                        inc(i); dec(j);
                end;
        until i>j;
        sort(l,j); sort(i,r);
End;

Procedure Enter;
Var     i:longint;
Begin
        readln(n);
        for i:=1 to n do readln(a[i]);
        sort(1,n);
End;

Procedure Process;
Var     i,j,l,r,mid:longint;
        ok:boolean;
Begin
        for i:=1 to n do
        begin
                leng[i]:=length(a[i]);
                setlength(hash[i],leng[i]+1);
                hash[i,0]:=0;
                for j:=1 to leng[i] do
                        hash[i,j]:=(hash[i,j-1]*base+ord(a[i,j])) mod modul;
        end;
        l:=1; r:=maxn;
        while l<r do
        begin
                mid:=(l+r) shr 1;
                ok:=true;
                for i:=2 to n do
                        if (mid<=leng[i]) and (mid<=leng[i-1]) and (hash[i,mid]=hash[i-1,mid]) then
                        begin
                                ok:=false;
                                break;
                        end;
                if ok then r:=mid else l:=mid+1;
        end;
        write(l);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
