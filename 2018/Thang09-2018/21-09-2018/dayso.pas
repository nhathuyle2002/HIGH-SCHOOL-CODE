Const   ginp='dayso.inp';
        gout='dayso.out';
        maxn=1010;
        oo=trunc(1e9);

Var     n,res,cou:longint;
        a:array[0..maxn] of longint;
        g:array[0..maxn*maxn] of longint;
        d:array[0..maxn*maxn] of boolean;

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
        for i:=1 to n do read(a[i]);
End;

Function Bina_se(x:longint):longint;
Var     l,r,mid:longint;
Begin
        l:=1; r:=cou;
        while l<r do
        begin
                mid:=(l+r) shr 1;
                if g[mid]<x then l:=mid+1 else r:=mid;
        end;
        if g[l]=x then exit(l) else exit(0);
End;

Procedure Init;
Var     i,j,cc:longint;
Begin
        sort(1,n,a);
        cou:=0; cc:=0;
        for i:=1 to n do
                for j:=i+1 to n do
                begin
                        inc(cc); g[cc]:=a[i]+a[j];
                end;
        sort(1,cc,g);
        g[0]:=-oo;
        for i:=1 to cc do
                if g[i]>g[i-1] then
                begin
                        inc(cou); g[cou]:=g[i];
                end;
End;

Procedure Process;
Var     i,j,count:longint;
        ok:boolean;
Begin
        fillchar(d,sizeof(d),false);
        count:=0; a[n+1]:=oo;
        for i:=1 to n do
        begin
                inc(count); ok:=false;
                for j:=1 to i-1 do d[bina_se(a[i]+a[j])]:=true;
                if a[i]<a[i+1] then
                begin
                        if count>=3 then ok:=true;
                        for j:=i+1 to n do
                                if ok then break else
                                if d[bina_se(3*a[i]-a[j])] then ok:=true;
                        if ok then res:=res+count;
                        count:=0;
                end;
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
