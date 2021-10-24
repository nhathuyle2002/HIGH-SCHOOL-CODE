Const   ginp='path.inp';
        gout='path.out';
        maxn=100001;
        maxm=300001;

Var     n,m,dw,res:longint;
        x,y,w:array[0..maxm] of longint;
        dd,pa,deg1,deg2:array[0..maxn] of longint;

Procedure Sort(l,r:longint);
Var     i,j,t,tmp:longint;
Begin
        if l>=r then exit;
        i:=l; j:=r;
        t:=w[random(r-l+1)+l];
        repeat
                while w[i]<t do inc(i);
                while w[j]>t do dec(j);
                if i<=j then
                begin
                        tmp:=x[i]; x[i]:=x[j]; x[j]:=tmp;
                        tmp:=y[i]; y[i]:=y[j]; y[j]:=tmp;
                        tmp:=w[i]; w[i]:=w[j]; w[j]:=tmp;
                        inc(i); dec(j);
                end;
        until i>j;
        sort(l,j); sort(i,r);
End;

Procedure Enter;
Var     i,na,nb,u:longint;
Begin
        readln(n,m,dw,na,nb);
        for i:=1 to m do readln(x[i],y[i],w[i]);
        for i:=1 to na do
        begin
                read(u); dd[u]:=1;
        end;
        readln;
        for i:=1 to nb do
        begin
                read(u); dd[u]:=2;
        end;
        sort(1,m);
End;

Function Find(p:longint):longint;
Begin
        while pa[p]<>p do p:=pa[p];
        find:=p;
End;

Procedure Process;
Var     x0,y0,i:longint;
Begin
        for i:=1 to n do
        begin
                pa[i]:=i;
                if dd[i]=1 then deg1[i]:=1 else
                if dd[i]=2 then deg2[i]:=1;
        end;
        res:=0;
        for i:=1 to m do
                if w[i]>dw then break else
                begin
                        x0:=find(x[i]); y0:=find(y[i]);
                        if x0<>y0 then
                        begin
                                if w[i]=dw then res:=res+int64(deg1[x0])*deg2[y0]+int64(deg2[x0])*deg1[y0];
                                deg1[x0]:=deg1[x0]+deg1[y0];
                                deg2[x0]:=deg2[x0]+deg2[y0];
                        end;
                        pa[x[i]]:=x0; pa[y[i]]:=x0; pa[y0]:=x0;
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
