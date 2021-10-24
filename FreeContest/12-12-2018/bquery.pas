Const   ginp='bquery.inp';
        gout='bquery.out';
        maxn=2010;

Var     m,n,q,x1,x2,y1,y2,w:longint;
        f,dit:array[0..4*maxn,0..4*maxn] of int64;

Function Max(x,y,z,t:int64):int64;
Begin
        max:=x;
        if y>max then max:=y;
        if z>max then max:=z;
        if t>max then max:=t;
End;

Procedure Cn(id1,id2:longint);
Var     x:longint;
Begin
        if dit[id1,id2]=0 then exit;
        x:=dit[id1,id2];
        inc(f[id1,id2],x);
        if (id1*2+1>4*maxn) or (id2*2+1>4*maxn) then exit;
        inc(dit[id1*2,id2*2],x);
        inc(dit[id1*2+1,id2*2],x);
        inc(dit[id1*2,id2*1+1],x);
        inc(dit[id1*2+1,id2*2+1],x);
        dit[id1,id2]:=0;
End;

Procedure Update(id1,l1,r1,id2,l2,r2:longint);
Var     mid1,mid2:longint;
Begin
        cn(id1,id2);
        if (l1>x2) or (r1<x1) or (l2>y2) or (r2<y1) then exit;
        if (x1<=l1) and (r1<=x2) and (y1<=l2) and (r2<=y2) then
        begin
                dit[id1,id2]:=w;
                cn(id1,id2);
                exit;
        end;
        mid1:=(l1+r1) shr 1;
        mid2:=(l2+r2) shr 1;
        update(id1*2,l1,mid1,id2*2,l2,mid2);
        update(id1*2+1,mid1+1,r1,id2*2,l2,mid2);
        update(id1*2,l1,mid1,id2*2+1,mid2+1,r2);
        update(id1*2+1,mid1+1,r1,id2*2+1,mid2+1,r2);
        f[id1,id2]:=max(f[id1*2,id2*2],f[id1*1+1,id2*2],f[id1*2,id2*2+1],f[id1*2+1,id2*2+1]);
End;

Function Quece(id1,l1,r1,id2,l2,r2:longint):int64;
Var     mid1,mid2:longint;
Begin
        cn(id1,id2);
        if (l1>x2) or (r1<x1) or (l2>y2) or (r2<y1) then exit(0);
        if (x1<=l1) and (r1<=x2) and (y1<=l2) and (r2<=y2) then exit(f[id1,id2]);
        mid1:=(l1+r1) shr 1;
        mid2:=(l2+r2) shr 1;
        quece:=max( quece(id1*2,l1,mid1,id2*2,l2,mid2), quece(id1*2+1,mid1+1,r1,id2*2,l2,mid2),
                quece(id1*2,l1,mid1,id2*2+1,mid2+1,r2), quece(id1*2+1,mid1+1,r1,id2*2+1,mid2+1,r2));
        f[id1,id2]:=max(f[id1*2,id2*2],f[id1*1+1,id2*2],f[id1*2,id2*2+1],f[id1*2+1,id2*2+1]);
End;

Procedure Process;
Var     typ:longint;
Begin
        readln(m,n,q);
        for q:=1 to q do
        begin
                read(typ);
                if typ=1 then
                begin
                        readln(x1,w);
                        x2:=x1; y1:=1; y2:=n;
                        update(1,1,m,1,1,n);
                end else
                if typ=2 then
                begin
                        readln(y1,w);
                        y2:=y1; x1:=1; x2:=m;
                        update(1,1,m,1,1,n);
                end else
                if typ=3 then
                begin
                        readln(x1,y1,x2,y2);
                        writeln(quece(1,1,m,1,1,n));
                end;
        end;
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Process;
        Close(input); Close(output);
End.
