Const   ginp='ants.inp';
        gout='ants.out';
        maxn=100010;
        oo=trunc(1e12)+1;

Var     n,k:longint;
        x,a:array[0..maxn] of int64;

Procedure Sort(l,r:longint; var p,q:array of int64);
Var     i,j:longint;
        t,tmp:int64;
Begin
        if l>=r then exit;
        i:=l; j:=r;
        t:=p[random(r-l+1)+l];
        repeat
                while p[i]<t do inc(i);
                while p[j]>t do dec(j);
                if i<=j then
                begin
                        tmp:=p[i]; p[i]:=p[j]; p[j]:=tmp;
                        tmp:=q[i]; q[i]:=q[j]; q[j]:=tmp;
                        inc(i); dec(j);
                end;
        until i>j;
        sort(l,j,p,q); sort(i,r,p,q);
End;

Function Min(x,y:int64):int64;
Begin
        if x<y then min:=x else min:=y;
End;

Procedure Enter;
Var     i:longint;
Begin
        readln(n,k);
        for i:=1 to n do read(x[i]); readln;
        for i:=1 to n do read(a[i]);
        sort(1,n,x,a);
End;

Procedure Process;
Var     i,cou:longint;
        l,r,mid,d,v:int64;
Begin
        l:=0; r:=oo;
        while l<r do
        begin
                mid:=(l+r) shr 1;
                cou:=0; v:=-oo;
                for i:=1 to n do
                begin
                        d:=mid div a[i] div 2;
                        if x[i]-d<=v then v:=min(v,x[i]+d) else
                        begin
                                inc(cou); v:=x[i]+d;
                        end;
                        if cou>k then break;
                end;
                if cou<=k then r:=mid else l:=mid+1;
        end;
        write(l);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
