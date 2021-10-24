Const   ginp='travel.inp';
        gout='travel.out';
        maxn=42;
        maxch=1 shl 21;
        oo=trunc(1e14);

Var     n,coul,cour,cou:longint;
        res,s,sum:int64;
        cost:array[0..maxn] of longint;
        dr:array[0..maxch] of longint;
        fl,fr,f:array[0..maxch] of int64;

Procedure Enter;
Var     i:longint;
Begin
        readln(n,s);
        for i:=1 to n do read(cost[i]);
End;

Procedure Dequy(i,last:longint; sum:int64);
Var     j:longint;
Begin
        inc(cou); f[cou]:=sum;
        for j:=i to last do
                dequy(j+1,last,sum+cost[j]);
End;

Procedure Init;
Var     i:longint;
Begin
        cou:=0;
        dequy(1,n shr 1,0);
        coul:=cou; fl:=f;
        cou:=0;
        dequy(n shr 1+1,n,0);
        cour:=cou; fr:=f;
End;

Procedure Sort(l,r:longint; var d:array of int64);
Var     i,j:longint;
        t,tmp:int64;
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

Function Bina_se(x:int64):longint;
Var     l,r,mid:longint;
Begin
        l:=1; r:=cour;
        while l<r do
        begin
                mid:=(l+r) shr 1;
                if fr[mid]<x then l:=mid+1 else r:=mid;
        end;
        if fr[l]=x then exit(l) else exit(0);
End;

Procedure Process;
Var     i,v:longint;
Begin
        sort(1,coul,fl); sort(1,cour,fr);
        fr[0]:=-oo; dr[0]:=0; cou:=cour; cour:=0;
        for i:=1 to cou do
                if fr[i]>fr[i-1] then
                begin
                        inc(cour);
                        fr[cour]:=fr[i]; dr[cour]:=1;
                end else inc(dr[cour]);
        res:=0;
        for i:=1 to coul do
        begin
                v:=bina_se(s-fl[i]);
                res:=res+dr[v];
        end;
        if s=0 then dec(res);
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
