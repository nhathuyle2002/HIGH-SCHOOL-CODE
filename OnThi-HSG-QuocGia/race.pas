Const   ginp='race.inp';
        gout='race.out';
        maxn=100001;

Type    save= record g,pos,res:longint; end;

Var     n,top:longint;
        a,b:array[0..maxn] of save;
        q,aw:array[0..maxn] of longint;

Procedure Sort(l,r:longint; var c:array of save);
Var     i,j:longint;
        t,tmp:save;
Begin
        if l>=r then exit;
        i:=l; j:=r;
        t:=c[random(r-l+1)+l];
        repeat
                while c[i].g<t.g do inc(i);
                while c[j].g>t.g do dec(j);
                if i<=j then
                begin
                        tmp:=c[i]; c[i]:=c[j]; c[j]:=tmp;
                        inc(i); dec(j);
                end;
        until i>j;
        sort(l,j,c); sort(i,r,c);
End;

Procedure Enter;
Var     i:longint;
Begin
        readln(n);
        for i:=1 to n do
        begin
                read(a[i].g);
                a[i].pos:=i; a[i].res:=0;
        end;
        readln;
        for i:=1 to n do
        begin
                read(b[i].g);
                b[i].pos:=i; b[i].res:=0;
        end;
        sort(1,n,a);
        sort(1,n,b);
End;

Procedure Process;
Var     i,j:longint;
Begin
        j:=1; top:=0;
        for i:=1 to n do
        begin
                while (j<=n) and (b[j].g<a[i].g) do
                begin
                        inc(top); q[top]:=j;
                        inc(j);
                end;
                if top>0 then
                begin
                        a[i].res:=q[top];
                        b[q[top]].res:=-1;
                        dec(top);
                end;
        end;
        j:=1; top:=0;
        for i:=1 to n do
        if a[i].res=0 then
        begin
                while (j<=n) and (b[j].g=a[i].g) do
                begin
                        if b[j].res=0 then
                        begin
                                inc(top); q[top]:=j;
                        end;
                        inc(j);
                end;
                if top>0 then
                begin
                        a[i].res:=q[top];
                        b[q[top]].res:=-1;
                        dec(top);
                end;
        end;
        top:=0;
        for i:=1 to n do
                if b[i].res=0 then
                begin
                        inc(top); q[top]:=i;
                end;
        for i:=1 to n do
                if a[i].res=0 then
                begin
                        a[i].res:=q[top];
                        dec(top);
                end;
        for i:=1 to n do
                aw[a[i].pos]:=b[a[i].res].pos;
        for i:=1 to n do writeln(i,' ',aw[i]);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
