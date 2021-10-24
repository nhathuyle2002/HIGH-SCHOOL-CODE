Const   ginp='ss.inp';
        gout='ss.out';
        maxn=200010;

Type    point= record x,y:longint; end;

Var     n:longint;
        s:ansistring;
        a,b:array[0..maxn] of point;

Procedure Enter;
Var     i:longint;
Begin
        readln(n);
        readln(s);
        read(b[n].x,b[n].y);
        a[0].x:=0; a[0].y:=0;
        for i:=1 to n do
        with a[i] do
        begin
                a[i]:=a[i-1];
                if s[i]='U' then inc(y) else
                if s[i]='D' then dec(y) else
                if s[i]='L' then dec(x) else
                inc(x);
        end;
        for i:=n-1 downto 0 do
        with b[i] do
        begin
                b[i]:=b[i+1];
                if s[i+1]='D' then inc(y) else
                if s[i+1]='U' then dec(y) else
                if s[i+1]='R' then dec(x) else
                inc(x);
        end;
End;

Procedure Process;
Var     i,l,r,mid:longint;
        ok:boolean;
Begin
        if (b[n].x+b[n].y-n) mod 2<>0 then
        begin
                write(-1);
                exit;
        end;
        l:=0; r:=n+1;
        while l<r do
        begin
                mid:=(l+r) shr 1;
                ok:=false;
                for i:=1 to n-mid+1 do
                        if abs(a[i-1].x-b[i+mid-1].x)+abs(a[i-1].y-b[i+mid-1].y)<=mid then
                        begin
                                ok:=true;
                                break;
                        end;
                if ok then r:=mid else l:=mid+1;
        end;
        if l=n+1 then write(-1) else write(l);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
