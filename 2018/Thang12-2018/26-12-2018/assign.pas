Const   ginp='assign.inp';
        gout='assign.out';
        maxn=100001;

Type    edge= record x,y,link:longint; end;

Var     n,m,m2:longint;
        e:array[0..maxn] of edge;
        head:array[0..maxn] of longint;
        avail:array[0..maxn] of boolean;
        lab,match,a:array[0..maxn] of longint;
        find:boolean;

Procedure Enter;
Var     i:longint;
Begin
        readln(m,n);
        i:=1;
        while not seekeof do
        with e[i] do
        begin
                readln(x,y);
                link:=head[x]; head[x]:=i;
                if (lab[x]=0) and (match[y]=0) then
                begin
                        lab[x]:=y;
                        match[y]:=x;
                end;
                inc(i);
        end;
End;

Procedure Visit(u:longint);
Var     i:longint;
Begin
        i:=head[u];
        while i<>0 do
        with e[i] do
        begin
                if avail[y] then
                begin
                        avail[y]:=false;
                        if match[y]=0 then find:=true else visit(match[y]);
                        if find then
                        begin
                                match[y]:=x; //lab[x]:=y;
                                exit;
                        end;
                end;
                i:=link;
        end;
End;

Procedure Process;
Var     i,om:longint;
Begin
        for i:=1 to m do
                if lab[i]=0 then
                begin
                        inc(m2); a[m2]:=i;
                end;
        repeat
                om:=m2;
                fillchar(avail[1],n*sizeof(avail[1]),true);
                for i:=m2 downto 1 do
                begin
                        find:=false;
                        visit(a[i]);
                        if find then
                        begin
                                a[i]:=a[m2];
                                dec(m2);
                        end;
                end;
        until om=m2;
        writeln(m-m2);
        for i:=1 to n do write(match[i],' ');
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
