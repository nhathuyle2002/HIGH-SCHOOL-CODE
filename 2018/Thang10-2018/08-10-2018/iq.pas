Const   ginp='iq.inp';
        gout='iq.out';
        maxn=100010;

Type    hinhhoc= record g,v:longint; end;

Var     n:longint;
        a,b:array[0..maxn] of hinhhoc;
        res:array[0..maxn] of longint;

Procedure Sort(l,r:longint; var d:array of hinhhoc);
Var     i,j,t:longint;
        tmp:hinhhoc;
Begin
        if l>=r then exit;
        i:=l; j:=r;
        t:=d[random(r-l+1)+l].g;
        repeat
                while d[i].g<t do inc(i);
                while d[j].g>t do dec(j);
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
        for i:=1 to n do
        begin
                read(a[i].g);
                a[i].v:=i;
        end;
        readln;
        for i:=1 to n do
        begin
                read(b[i].g);
                b[i].v:=i;
        end;
        sort(1,n,a); sort(1,n,b);
End;

Procedure Process;
Var     i,left,right,mid:longint;
        ok:boolean;
Begin
        left:=1; right:=n;
        while left<right do
        begin
                mid:=(left+right) shr 1;
                ok:=true;
                for i:=1 to mid do
                        if b[i].g>a[n-mid+i].g then ok:=false;
                if ok then left:=mid+1 else right:=mid;
        end;
        mid:=left-1;
        for i:=1 to mid do
                res[a[n-mid+i].v]:=b[i].v;
        for i:=1 to n-mid do
                res[a[i].v]:=b[mid+i].v;
        for i:=1 to n do write(res[i],' ');
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
