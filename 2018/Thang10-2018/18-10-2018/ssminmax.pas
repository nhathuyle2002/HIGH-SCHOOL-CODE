Uses    Math;

Const   ginp='ssminmax.inp';
        gout='ssminmax.out';
        maxn=200010;
        maxk=18;

Var     n,mk:longint;
        res:int64;
        fa,fb:array[0..maxn,0..maxk] of longint;

Function Get(l,r,typ:longint):longint;
Var     k:longint;
Begin
        k:=trunc(log2(r-l+1));
        if typ=1 then get:=max(fa[l,k],fa[r-1 shl k+1,k]) else
        get:=min(fb[l,k],fb[r-1 shl k+1,k]);
End;

Procedure Enter;
Var     i:longint;
Begin
        readln(n); mk:=trunc(log2(n));
        for i:=1 to n do read(fa[i,0]); readln;
        for i:=1 to n do read(fb[i,0]);
End;

Procedure Init;
Var     i,k:longint;
Begin
        for k:=1 to mk do
                for i:=1 to n-1 shl k+1 do
                begin
                        fa[i,k]:=max(fa[i,k-1],fa[i+1 shl (k-1),k-1]);
                        fb[i,k]:=min(fb[i,k-1],fb[i+1 shl (k-1),k-1]);
                end;
End;

Procedure Process;
Var     i,l1,l2,l,r,mid:longint;
Begin
        res:=0;
        for i:=1 to n do
        begin
                l:=1; r:=i;
                while l<r do
                begin
                        mid:=(l+r) shr 1;
                        if get(mid,i,1)<=get(mid,i,2) then r:=mid else l:=mid+1;
                end;
                l1:=l;
                if get(l1,i,1)<>get(l1,i,2) then continue;
                l:=1; r:=i+1;
                while l<r do
                begin
                        mid:=(l+r) shr 1;
                        if get(mid,i,1)<get(mid,i,2) then r:=mid else l:=mid+1;
                end;
                l2:=l-1;
                if get(l2,i,1)<>get(l2,i,2) then continue;
                res:=res+l2-l1+1;
        end;
        write(res);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Init;
        Process;
        Close(input); Close(output);
End.
