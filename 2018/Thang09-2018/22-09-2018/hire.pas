Const   ginp='hire.inp';
        gout='hire.out';
        maxt=500010;
        oo=trunc(1e12);

Var     n:longint;
        leaf:array[0..maxt] of longint;
        f:array[0..4*maxt] of int64;

Function Min(x,y:int64):int64;
Begin
        if x<y then min:=x else min:=y;
End;

Procedure Build(id,l,r:longint);
Var     mid:longint;
Begin
        f[id]:=oo;
        if l<r then
        begin
                mid:=(l+r) shr 1;
                build(id*2,l,mid); build(id*2+1,mid+1,r);
        end
        else    leaf[l]:=id;
End;

Procedure Update(id:longint; x:int64);
Begin
        id:=leaf[id];
        while (id>0) and (f[id]>x) do
        begin
                f[id]:=x;
                id:=id shr 1;
        end;
End;

Function Quece(id,l,r,dd,cc:longint):int64;
Var     mid:longint;
Begin
        if (l>cc) or (r<dd) then exit(oo);
        if (dd<=l) and (r<=cc) then exit(f[id]);
        mid:=(l+r) shr 1;
        quece:=min(quece(id*2,l,mid,dd,cc),quece(id*2+1,mid+1,r,dd,cc));
End;

Procedure Process;
Var     i,t:longint;
        p:int64;
Begin
        readln(n);
        Build(1,0,n); Update(0,0);
        for i:=1 to n do
        begin
                readln(t,p);
                p:=p+quece(1,0,n,i-1,n);
                update(t,p);
        end;
        write(f[leaf[n]]);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Process;
        Close(input); Close(output);
End.
