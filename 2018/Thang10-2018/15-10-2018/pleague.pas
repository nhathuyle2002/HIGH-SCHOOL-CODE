Const   ginp='pleague.inp';
        gout='pleague.out';
        maxn=100010;

Var     n:longint;
        a,b,pos,ans1,ans2:array[0..2*maxn+10] of longint;
        x,y,d,db,f,dt:array[-2..maxn+10] of longint;

Procedure Swap(var p,q:longint);
Var     tmp:longint;
Begin
        tmp:=p; p:=q; q:=tmp;
End;

Procedure Sorta(l,r:longint);
Var     i,j,t:longint;
Begin
        if l>=r then exit;
        i:=l; j:=r;
        t:=a[random(r-l+1)+l];
        repeat
                while a[i]>t do inc(i);
                while a[j]<t do dec(j);
                if i<=j then
                begin
                        swap(a[i],a[j]);
                        swap(b[i],b[j]);
                        swap(pos[i],pos[j]);
                        inc(i); dec(j);
                end;
        until i>j;
        sorta(l,j); sorta(i,r);
End;

Procedure Sortx(l,r:longint);
Var     i,j,t:longint;
Begin
        if l>=r then exit;
        i:=l; j:=r;
        t:=x[random(r-l+1)+l];
        repeat
                while x[i]>t do inc(i);
                while x[j]<t do dec(j);
                if i<=j then
                begin
                        swap(x[i],x[j]);
                        swap(y[i],y[j]);
                        inc(i); dec(j);
                end;
        until i>j;
        sortx(l,j); sortx(i,r);
End;

Function Quece(i:longint):longint;
Begin
        quece:=f[i]+f[i-1]+f[i-2];
End;

Procedure Enter;
Var     i:longint;
Begin
        readln(n);
        for i:=1 to 2*n do
        begin
                read(a[i]); a[i]:=a[i];
                inc(d[a[i]]);
                pos[i]:=i;
        end;
        readln;
        for i:=1 to n do
        begin
                readln(x[i],y[i]);
                b[x[i]]:=a[y[i]]; b[y[i]]:=a[x[i]];
                x[i]:=a[x[i]]; y[i]:=a[y[i]];
                if x[i]<y[i] then swap(x[i],y[i]);
                if x[i]=y[i] then inc(db[x[i]]);
                if x[i]-y[i]<=2 then inc(dt[x[i]-3]);
        end;
        sorta(1,2*n);
        sortx(1,n);
        for i:=maxn downto 0 do d[i]:=d[i+1]+d[i];
End;

Procedure Process;
Var     i,l,r,res1,res2:longint;
Begin
        l:=1; r:=1;
        for i:=1 to 2*n do
        begin
                res1:=d[a[i]+4]+dt[a[i]];

                res2:=d[a[i]+1]+db[a[i]];
                if a[i]=b[i] then dec(res2);

                while (l<=n) and (x[l]>a[i]) do
                begin
                        inc(f[y[l]]);
                        inc(l);
                end;
                while (r<=n) and (x[r]>a[i]-3) do inc(r);

                res2:=res2+r-l+quece(a[i])-1;
                if (a[i]<b[i]+3) and (b[i]<=a[i]) then inc(res2);

                ans1[pos[i]]:=res1+1; ans2[pos[i]]:=res2+1;
        end;
        for i:=1 to 2*n do writeln(ans1[i],' ',ans2[i]);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
