Uses    Math;

Const   ginp='parentheses.inp';
        gout='parentheses.out';
        maxn=110;

Var     n,nb:longint;
        res:int64;
        a:ansistring;
        sum,v,b:array[0..maxn] of longint;
        q:array[0..4*maxn] of longint;

Procedure Sort(l,r:longint);
Var     i,j,t,tv,tmp:longint;
Begin
        if l>=r then exit;
        i:=l; j:=r;
        t:=random(r-l+1)+l;
        tv:=v[t]; t:=sum[t];
        repeat
                while (sum[i]<t) or ((sum[i]=t) and (v[i]<tv)) do inc(i);
                while (sum[j]>t) or ((sum[j]=t) and (v[j]>tv)) do dec(j);
                if i<=j then
                begin
                        tmp:=sum[i]; sum[i]:=sum[j]; sum[j]:=tmp;
                        tmp:=v[i]; v[i]:=v[j]; v[j]:=tmp;
                        inc(i); dec(j);
                end;
        until i>j;
        sort(l,j); sort(i,r);
End;

Procedure Build(id,l,r:longint);
Var     mid:longint;
Begin
        if l=r then q[id]:=sum[l] else
        begin
                mid:=(l+r) shr 1;
                build(id*2,l,mid);
                build(id*2+1,mid+1,r);
                q[id]:=min(q[id*2],q[id*2+1]);
        end;
End;

Function Quece(id,l,r,dd,cc:longint):longint;
Var     mid:longint;
Begin
        if (l>r) or (l>cc) or (r<dd) then exit(maxn);
        if (dd<=l) and (r<=cc) then exit(q[id]);
        mid:=(l+r) shr 1;
        quece:=min(quece(id*2,l,mid,dd,cc),quece(id*2+1,mid+1,r,dd,cc));
End;

Procedure Answer(ss:longint);
Var     l,r:longint;
Begin
        if ss=0 then
        for l:=1 to nb do
                if quece(1,1,n,1,b[l])>=0 then inc(res);
        r:=1;
        for l:=1 to nb do
        begin
                while (r<=nb) and (quece(1,1,n,b[l],b[r])>=ss) do inc(r);
                res:=res+r-l-1;
        end;
End;

Procedure Enter;
Var     i:longint;
Begin
        n:=length(a);
        for i:=1 to n do
        begin
                if a[i]='(' then sum[i]:=sum[i-1]+1 else sum[i]:=sum[i-1]-1;
                v[i]:=i;
        end;
        build(1,1,n);
        sort(1,n);
End;

Procedure Process;
Var     i:longint;
Begin
        sum[0]:=sum[1]; sum[n+1]:=maxn+10;
        res:=0; nb:=0;
        for i:=1 to n+1 do
        begin
                if sum[i]>sum[i-1] then
                begin
                        answer(sum[i-1]);
                        nb:=0;
                end;
                inc(nb); b[nb]:=v[i];
        end;
        writeln(res);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        repeat
                readln(a);
                if a='' then break;
                Enter;
                Process;
        until false;
        Close(input); Close(output);
End.
