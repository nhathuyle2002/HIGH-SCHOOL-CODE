Const   ginp='race.inp';
        gout='race.out';
        maxn=1000010;

Type    save= record g,pos,res:longint; end;

Var     n,top:longint;
        q,res:array[0..maxn] of longint;
        a,b:array[0..maxn] of save;

Procedure Sort(l,r:longint; var d:array of save);
Var     i,j:longint;
        t,tmp:save;
Begin
        if l>=r then exit;
        i:=l; j:=r;
        t:=d[random(r-l+1)+l];
        repeat
                while d[i].g<t.g do inc(i);
                while d[j].g>t.g do dec(j);
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
        with a[i] do
        begin
                read(g);
                pos:=i; res:=0;
        end;
        for i:=1 to n do
        with b[i] do
        begin
                read(g);
                pos:=i; res:=0;
        end;
        sort(1,n,a);
        sort(1,n,b);
End;

Procedure Process;
Var     i,j:longint;
Begin
        top:=0; j:=1;
        for i:=1 to n do
        begin
                while (j<=n) and (b[j].g<a[i].g) do
                begin
                        inc(top); q[top]:=j;
                        inc(j);
                end;
                if top>0 then
                begin
                        a[i].res:=q[top]; b[q[top]].res:=-1;
                        dec(top);
                end;
        end;
        top:=0; j:=1;
        for i:=1 to n do
        if a[i].res=0 then
        begin
                while (j<=n) and (b[j].g<=a[i].g) do
                begin
                        if b[j].res=0 then
                        begin
                                inc(top); q[top]:=j;
                        end;
                        inc(j);
                end;
                if top>0 then
                begin
                        a[i].res:=q[top]; b[q[top]].res:=-1;
                        dec(top);
                end;
        end;
        top:=0;
        for j:=1 to n do
                if b[j].res=0 then
                begin
                        inc(top); q[top]:=j;
                end;
        for i:=1 to n do
                if a[i].res=0 then
                begin
                        a[i].res:=q[top];
                        dec(top);
                end;
        for i:=1 to n do
                res[a[i].pos]:=b[a[i].res].pos;
        for i:=1 to n do writeln(i,' ',res[i]);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
