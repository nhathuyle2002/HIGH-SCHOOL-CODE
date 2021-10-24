Const   ginp='collider.inp';
        gout='collider.out';
        maxn=200010;

Var     n,m,cou,top,res:longint;
        x,id,dis,stack,tg:array[0..maxn] of longint;

Procedure Sort(l,r:longint; var d:array of longint);
Var     i,j,t,tmp:longint;
Begin
        if l>=r then exit;
        i:=l; j:=r;
        t:=d[random(r-l+1)+l];
        repeat
                while d[i]<t do inc(i);
                while d[j]>t do dec(j);
                if i<=j then
                begin
                        tmp:=d[i]; d[i]:=d[j]; d[j]:=tmp;
                        inc(i); dec(j);
                end;
        until i>j;
        sort(l,j,d); sort(i,r,d);
End;

Procedure Enter;
Var     i:longint;
Begin
        readln(n);
        for i:=1 to n do readln(x[i],id[i]);
        readln(m);
        for i:=1 to m do read(tg[i]);
End;

Procedure Process;
Var     i,j:longint;
Begin
        cou:=0; top:=0;
        for i:=1 to n do
                if id[i]=1 then
                begin
                        inc(top); stack[top]:=i;
                end else
                if top>0 then
                begin
                        inc(cou); dis[cou]:=(x[i]-x[stack[top]]) div 2+(x[i]-x[stack[top]]) mod 2;
                        dec(top);
                end;
        sort(1,cou,dis);
        res:=n; i:=1;
        for j:=1 to m do
        begin
                while (i<=cou) and (dis[i]<=tg[j]) do
                begin
                        inc(i); res:=res-2;
                end;
                writeln(res);
        end;
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
