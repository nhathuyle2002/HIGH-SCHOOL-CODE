Uses    Math;

Const   ginp='radar.inp';
        gout='radar.out';
        maxn=10001;

Type    point= record x,y:longint; end;
        hcn= record p1,p2:point; end;
        edge= record y,link:longint; end;

Var     r,st,n,res:longint;
        a:array[0..maxn] of hcn;
        f:array[0..maxn] of longint;
        m:longint;
        e:array[0..maxn*maxn] of edge;
        head,d:array[0..maxn] of longint;

Function Cmp(a,b:hcn):boolean;
Begin
        if a.p1.x<>b.p1.x then exit(a.p1.x<b.p1.x);
        if a.p2.y<>b.p2.y then exit(a.p2.y<b.p2.y);
        exit(false);
End;

Procedure Sort(l,r:longint);
Var     i,j:longint;
        t,tmp:hcn;
Begin
        if l>=r then exit;
        i:=l; j:=r;
        t:=a[random(r-l+1)+l];
        repeat
                while cmp(a[i],t) do inc(i);
                while cmp(t,a[j]) do dec(j);
                if i<=j then
                begin
                        tmp:=a[i]; a[i]:=a[j]; a[j]:=tmp;
                        inc(i); dec(j);
                end;
        until i>j;
        sort(l,j); sort(i,r);
End;

Function See(a,b:hcn):boolean; inline;
Begin
        if (a.p1.x<=b.p2.x) and (a.p1.y>=b.p2.y) then exit(true);
        if (b.p1.x<=a.p2.x) and (b.p1.y>=a.p2.y) then exit(true);
        exit(false);
End;

Procedure Enter;
Var     i:longint;
Begin
        readln(n);
        for i:=1 to n do
        with a[i] do readln(p1.x,p1.y,p2.x,p2.y);
End;

Procedure Process;
Var     i,j:longint;
Begin
        sort(1,n);
        res:=0;
        for i:=1 to n do
        begin
                f[i]:=1;
                for j:=i-1 downto 1 do
                        if (a[i].p1.x>a[j].p2.x) and (a[i].p2.y>a[j].p1.y) then f[i]:=max(f[i],f[j]+1);
                res:=max(res,f[i]);
        end;
        writeln(res);
End;

Procedure Try(cou,ii:longint);
Var     u,i:longint;
Begin
        if res<cou then res:=cou;
        for u:=ii+1 to n do
        if d[u]=0 then
        begin
                d[u]:=1; i:=head[u];
                while i<>0 do
                with e[i] do
                begin
                        if d[y]=0 then
                        begin
                                d[y]:=1;
                                try(cou+1,u);
                                d[y]:=0;
                        end;
                        i:=link;
                end;
                d[u]:=0;
        end;
End;

Procedure Process2;
Var     i,j:longint;
Begin
        for i:=1 to n do head[i]:=0;
        m:=0;
        for i:=1 to n do
                for j:=i+1 to n do
                        if see(a[i],a[j]) then
                        begin
                                inc(m);
                                with e[m] do
                                begin
                                        y:=j;
                                        link:=head[i];
                                end;
                                head[i]:=m;
                        end;
        res:=0;
        for i:=1 to n do d[i]:=0;
        try(0,0);
        writeln(res);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        readln(r);
        readln(st);
        for st:=1 to st do
        begin
                Enter;
                if r=1 then Process else Process2;
        end;
        Close(input); Close(output);
End.
