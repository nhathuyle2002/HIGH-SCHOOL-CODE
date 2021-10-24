Const   ginp='ss.inp';
        gout='ss.out';
        maxn=200010;
        maxg=1000010;

Type    query= record l,r,v:longint; end;

Var     n,qq,nn:longint;
        sum:int64;
        a:array[0..maxn] of longint;
        q:array[0..maxn] of query;
        d:array[0..maxg] of longint;
        res:array[0..maxn] of int64;

function cmp(x,y:query):boolean; inline;
begin
        if x.l div nn<>y.l div nn then exit(x.l<y.l);
        if x.r<>y.r then exit(x.r<y.r);
        exit(x.l<y.l);
end;

procedure sort(l,r:longint);
var     i,j:longint;
        t,tmp:query;
begin
        if l>=r then exit;
        i:=l; j:=r;
        t:=q[random(r-l+1)+l];
        repeat
                while cmp(q[i],t) do inc(i);
                while cmp(t,q[j]) do dec(j);
                if i<=j then
                begin
                        tmp:=q[i]; q[i]:=q[j]; q[j]:=tmp;
                        inc(i); dec(j);
                end;
        until i>j;
        sort(l,j); sort(i,r);
end;

Procedure Push(x:longint); inline;
begin
        sum:=sum+int64(x)*(2*d[x]+1);
        inc(d[x]);
end;

Procedure Pop(x:longint); inline;
begin
        sum:=sum-int64(x)*(2*d[x]-1);
        dec(d[x]);
end;

Procedure Enter;
Var     i:longint;
Begin
        readln(n,qq);
        for i:=1 to n do read(a[i]);
        for i:=1 to qq do
        begin
                readln(q[i].l,q[i].r);
                q[i].v:=i;
        end;
        nn:=trunc(sqrt(n));
        sort(1,qq);
        for i:=0 to maxg do d[i]:=0;
End;

Procedure Process;
Var     i,vl,vr:longint;
Begin
        sum:=0;
        vl:=1;vr:=0;
        for i:=1 to qq do
        begin
                while vl>q[i].l do
                begin
                        dec(vl); push(a[vl]);
                end;
                while vr<q[i].r do
                begin
                        inc(vr); push(a[vr]);
                end;
                while vl<q[i].l do
                begin
                        pop(a[vl]); inc(vl);
                end;
                while vr>q[i].r do
                begin
                        pop(a[vr]); dec(vr);
                end;
                res[q[i].v]:=sum;
        end;
        for i:=1 to qq do writeln(res[i]);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
