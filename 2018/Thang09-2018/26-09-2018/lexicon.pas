Const   ginp='lexicon.inp';
        gout='lexicon.out';
        maxl=1000010;
        base=211;
        kk=trunc(1e9)+13;

Var     la,lb,st:longint;
        a,b:ansistring;
        ha,hb,pow:array[0..maxl] of int64;

Function Max(x,y:longint):longint; inline;
Begin
        if x>y then exit(x) else exit(y);
End;

Function Min(x,y:longint):longint; inline;
Begin
        if x<y then exit(x) else exit(y);
End;

Procedure Enter;
Var     i:longint;
Begin
        readln(la,lb);
        readln(a); readln(b);
        for i:=1 to la do ha[i]:=(ha[i-1]*base+ord(a[i])) mod kk;
        for i:=1 to lb do hb[i]:=(hb[i-1]*base+ord(b[i])) mod kk;
        pow[0]:=1;
        for i:=1 to max(la,lb) do pow[i]:=pow[i-1]*base mod kk;
End;

Function Get(l1,r1,l2,r2:longint):boolean; inline;
Begin
        if (ha[r1]-hb[r2]-(ha[l1-1]-hb[l2-1])*pow[r1-l1+1]) mod kk=0 then
        get:=true else get:=false;
End;

Function Binary(l1,r1,l2,r2:longint):longint; inline;
Var     left,right,mid,rr:longint;
Begin
        rr:=min(r1-l1+1,r2-l2+1);
        left:=0; right:=rr;
        while left<right do
        begin
                mid:=(left+right) shr 1;
                if get(l1,l1+mid,l2,l2+mid) then left:=mid+1 else right:=mid;
        end;
        if left=rr then
        begin
                if r1-l1<r2-l2 then exit(-1) else
                if r1-l1>r2-l2 then exit(1) else
                exit(0);
        end
        else if a[l1+left]<b[l2+left] then exit(-1)
        else exit(1);
End;

Procedure Process;
Var     i,l1,r1,l2,r2,res:longint;
Begin
        readln(st);
        for i:=1 to st do
        begin
                readln(l1,r1,l2,r2);
                res:=binary(l1,r1,l2,r2);
                if res=-1 then write('<')
                else if res=0 then write('=')
                else write('>');
        end;
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
