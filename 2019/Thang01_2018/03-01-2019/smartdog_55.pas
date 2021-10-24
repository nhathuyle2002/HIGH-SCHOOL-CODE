Uses    Windows;

Const   ginp='smartdog.inp';
        gout='smartdog.out';
        maxn=100010;
        oo=trunc(1e9);
        mg=1000;

Type    point= record x,y,w:longint; end;
        save= record l1,r1,l2,r2,w:longint; d:boolean; end;

Var     n,delta,res:longint;
        a:array[0..maxn] of point;
        ll1,rr1,ll2,rr2,gg:longint;
        f:array[0..8*mg,0..8*mg] of save;

Function Max(x,y:longint):longint;
Begin
        if x>y then max:=x else max:=y;
End;

Procedure Build(i1,l1,r1,i2,l2,r2:longint);
Var     m1,m2:longint;
Begin
        if (l1>r1) or (l2>r2) then
        begin
                f[i1,i2].d:=false;
                exit;
        end;
        f[i1,i2].w:=-oo; f[i1,i2].d:=true;
        f[i1,i2].l1:=l1; f[i1,i2].r1:=r1;
        f[i1,i2].l2:=l2; f[i1,i2].r2:=r2;
        if (l1=r1) and (l2=r2) then exit;
        m1:=(l1+r1)>>1; m2:=(l2+r2)>>1;
        build(i1<<1,l1,m1,i2<<1,l2,m2);
        build(i1<<1,l1,m1,i2<<1+1,m2+1,r2);
        build(i1<<1+1,m1+1,r1,i2<<1,l2,m2);
        build(i1<<1+1,m1+1,r1,i2<<1+1,m2+1,r2);
End;

Function Query(i1,i2:longint):longint;
Begin
        with f[i1,i2] do
        begin
                if not d then exit(-oo);
                if (l1>rr1) or (r1<ll1) or (l2>rr2) or (r2<ll2) then exit(-oo);
                if (ll1<=l1) and (r1<=rr1) and (ll2<=l2) and (r2<=rr2) then exit(w);
        end;
        query:=max(max(query(i1<<1,i2<<1),query(i1<<1,i2<<1+1)),max(query(i1<<1+1,i2<<1),query(i1<<1+1,i2<<1+1)));
End;

Procedure Update(i1,i2:longint);
Begin
        with f[i1,i2] do
        begin
                if not d then exit;
                if (l1>rr1) or (r1<ll1) or (l2>rr2) or (r2<ll2) then exit;
                if (ll1<=l1) and (r1<=rr1) and (ll2<=l2) and (r2<=rr2) then
                begin
                        w:=max(w,gg);
                        exit;
                end;
        end;
        update(i1<<1,i2<<1);
        update(i1<<1,i2<<1+1);
        update(i1<<1+1,i2<<1);
        update(i1<<1+1,i2<<1+1);
        f[i1,i2].w:=max(f[i1,i2].w,gg);//max(max(f[i1<<1,i2<<1],f[i1<<1,i2<<1+1]),max(f[i1<<1+1,i2<<1],f[i1<<1+1,i2<<1+1]));
End;

Procedure Enter;
Var     i:longint;
Begin
        readln(n,delta);
        for i:=1 to n do readln(a[i].x,a[i].y,a[i].w);
        a[0].x:=0; a[0].y:=0;
End;

Procedure Process1;
Var     i,j:longint;
        f1:array[0..maxn] of longint;
Begin
        f1[0]:=0; res:=0;
        for i:=1 to n do
        begin
                f1[i]:=-oo;
                for j:=i-1 downto 0 do
                        if abs(a[i].x-a[j].x)+abs(a[i].y-a[j].y)<=delta then f1[i]:=max(f1[i],f1[j]+a[i].w);
                res:=max(res,f1[i]);
        end;
        writeln(res);
End;

Procedure Process2;
Var     i,t,sum:longint;
Begin
        sum:=0;
        build(1,0,2*mg,1,0,2*mg);
        ll1:=0+mg; rr1:=0+mg; ll2:=0; rr2:=0; gg:=0;
        update(1,1);
        res:=0;
        for i:=1 to n do
        with a[i] do
        begin
                ll1:=x-y-delta+mg; rr1:=x-y+delta+mg;
                ll2:=x+y-delta; rr2:=x+y+delta;
                t:=gettickcount;
                gg:=query(1,1);
                sum:=sum+gettickcount-t;
                if gg<>-oo then
                begin
                        gg:=gg+w;
                        ll1:=x-y+mg; rr1:=x-y+mg; ll2:=x+y; rr2:=x+y;
                        update(1,1);
                        res:=max(res,gg);
                end;
        end;
        //writeln(sum);
        write(res);
End;

Procedure Sinh;
Var     i:longint;
Begin
        Assign(output,ginp); Rewrite(output);
        randomize;
        n:=100000;
        writeln(n,' ',random(900)+10);
        for i:=1 to n do
                writeln(random(1000)+1,' ',random(1000)+1,' ',random(1000)+1);
        Close(output);
End;

Begin
        //Sinh;
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process2;
        //if n<=5000 then Process1 else Process2;
        Close(input); Close(output);
End.
