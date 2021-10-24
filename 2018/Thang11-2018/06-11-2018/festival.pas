Const   ginp='festival.inp';
        gout='festival.out';
        maxn=110;

Var     n,mx,my,res:longint;
        x,y,t,gx,gy:array[0..maxn] of longint;
        s,f:array[0..maxn,0..maxn] of longint;
        dd:array[0..maxn,0..maxn] of boolean;

Procedure Sort(l,r:longint; var a,p:array of longint);
Var     i,j,t,tmp:longint;
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
                        tmp:=p[i]; p[i]:=p[j]; p[j]:=tmp;
                        inc(i); dec(j);
                end;
        until i>j;
        sort(l,j,a,p); sort(i,r,a,p);
End;

Procedure Enter;
Var     i:longint;
        d,p:array[0..maxn] of longint;
Begin
        readln(n);
        for i:=1 to n do
        begin
                readln(t[i],x[i],y[i]);
                dec(x[i]); dec(y[i]);
        end;
        for i:=1 to n do
        begin
                d[i]:=x[i]; p[i]:=i;
        end;
        sort(1,n,d,p);
        gx[1]:=0; mx:=1;
        for i:=1 to n do
        begin
                if d[i]>gx[mx] then
                begin
                        inc(mx); gx[mx]:=d[i];
                end;
                x[p[i]]:=mx;
        end;
        for i:=1 to n do
        begin
                d[i]:=y[i]; p[i]:=i;
        end;
        sort(1,n,d,p);
        gy[1]:=0; my:=1;
        for i:=1 to n do
        begin
                if d[i]>gy[my] then
                begin
                        inc(my); gy[my]:=d[i];
                end;
                y[p[i]]:=my;
        end;
End;

Procedure Process;
Var     i,j:longint;
Begin
        fillchar(dd,sizeof(dd),false);
        fillchar(f,sizeof(f),0);
        fillchar(s,sizeof(s),0);
        for i:=1 to n do
        begin
                inc(s[x[i],y[i]],t[i]);
                inc(f[x[i],y[i]],1);
        end;
        dd[1,1]:=true;
        res:=0;
        for i:=1 to mx do
        for j:=1 to my do
        begin
                s[i,j]:=s[i-1,j]+s[i,j-1]-s[i-1,j-1]+s[i,j];
                f[i,j]:=f[i-1,j]+f[i,j-1]-f[i-1,j-1]+f[i,j];
                dd[i,j]:=dd[i,j] or (dd[i-1,j] and (s[i-1,j]>=gx[i]+gy[j])) or (dd[i,j-1] and (s[i,j-1]>=gx[i]+gy[j]));
                if dd[i,j] and (res<f[i,j]) then res:=f[i,j];
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
