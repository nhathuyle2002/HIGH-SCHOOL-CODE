Uses    Math;

Const   ginp='';//square.inp';
        gout='';//square.out';
        maxn=100010;
        maxg=trunc(1e9)+1;

Type    point= record x,y:longint; end;

Var     st,ms,n:longint;
        res:longint;
        a:array[0..maxn] of point;
        p1,p2:point;
        l1,r1,l2,r2:array[0..maxn] of longint;

Procedure Sortx(l,r:longint); inline;
Var     i,j:longint;
        t,tmp:point;
Begin
        if l>=r then exit;
        i:=l; j:=r;
        t:=a[random(r-l+1)+l];
        repeat
                while a[i].x<t.x do inc(i);
                while a[j].x>t.x do dec(j);
                if i<=j then
                begin
                        tmp:=a[i]; a[i]:=a[j]; a[j]:=tmp;
                        inc(i); dec(j);
                end;
        until i>j;
        sortx(l,j); sortx(i,r);
End;

Procedure Sorty(l,r:longint); inline;
Var     i,j:longint;
        t,tmp:point;
Begin
        if l>=r then exit;
        i:=l; j:=r;
        t:=a[random(r-l+1)+l];
        repeat
                while a[i].y<t.y do inc(i);
                while a[j].y>t.y do dec(j);
                if i<=j then
                begin
                        tmp:=a[i]; a[i]:=a[j]; a[j]:=tmp;
                        inc(i); dec(j);
                end;
        until i>j;
        sorty(l,j); sorty(i,r);
End;

Procedure Enter;
Var     i:longint;
Begin
        readln(n);
        for i:=1 to n do readln(a[i].x,a[i].y);
        p1.x:=maxg; p1.y:=maxg;
        p2.x:=-maxg; p2.y:=-maxg;
        for i:=1 to n do
        begin
                p1.x:=min(p1.x,a[i].x);
                p1.y:=min(p1.y,a[i].y);
                p2.x:=max(p2.x,a[i].x);
                p2.y:=max(p2.y,a[i].y);
        end;
End;

Procedure Process1;
Var     {l,r,mid,}i:longint;
        g:longint;
        //p3,p4:point;
Begin
        g:=0;
        for i:=1 to n do
                g:=max(g,min(max(a[i].x-p1.x,a[i].y-p1.y),max(p2.x-a[i].x,p2.y-a[i].y)));
        res:=g;
        g:=0;
        for i:=1 to n do
                g:=max(g,min(max(a[i].x-p1.x,p2.y-a[i].y),max(p2.x-a[i].x,a[i].y-p1.y)));
        res:=min(res,g);
        {l:=0; r:=max(p2.x-p1.x,p2.y-p1.y);
        while l<r do
        begin
                mid:=(l+r) div 2;
                p3.x:=maxg; p3.y:=maxg;
                p4.x:=-maxg; p4.y:=-maxg;
                for i:=1 to n do
                        if (a[i].x-p1.x>mid) or (a[i].y-p1.y>mid) then
                        begin
                                p3.x:=min(p3.x,a[i].x);
                                p3.y:=min(p3.y,a[i].y);
                                p4.x:=max(p4.x,a[i].x);
                                p4.y:=max(p4.y,a[i].y);
                        end;
                if max(p4.x-p3.x,p4.y-p3.y)<=mid then r:=mid else l:=mid+1;
        end;
        res:=r;
        l:=0; r:=max(p2.x-p1.x,p2.y-p1.y);
        while l<r do
        begin
                mid:=(l+r) div 2;
                p3.x:=maxg; p3.y:=maxg;
                p4.x:=-maxg; p4.y:=-maxg;
                for i:=1 to n do
                        if (a[i].x-p1.x>mid) or (p2.y-a[i].y>mid) then
                        begin
                                p3.x:=min(p3.x,a[i].x);
                                p3.y:=min(p3.y,a[i].y);
                                p4.x:=max(p4.x,a[i].x);
                                p4.y:=max(p4.y,a[i].y);
                        end;
                if max(p4.x-p3.x,p4.y-p3.y)<=mid then r:=mid else l:=mid+1;
        end;
        res:=min(res,r);}
        //if res=0 then res:=1;
        writeln(res);
End;

Procedure Process2;
Var     i:longint;
Begin
        res:=max(p2.x-p1.x,p2.y-p1.y);
        sortx(1,n);
        l1[0]:=maxg; l2[0]:=-maxg;
        for i:=1 to n-1 do
        begin
                l1[i]:=min(l1[i-1],a[i].y);
                l2[i]:=max(l2[i-1],a[i].y);
        end;
        r1[n+1]:=maxg; r2[n+1]:=-maxg;
        for i:=n downto 2 do
        begin
                r1[i]:=min(r1[i+1],a[i].y);
                r2[i]:=max(r2[i+1],a[i].y);
        end;
        for i:=1 to n-1 do
                if a[i].x<>a[i+1].x then
                res:=min(res,max(max(a[i].x-p1.x,l2[i]-l1[i]),max(p2.x-a[i+1].x,r2[i+1]-r1[i+1])));

        sorty(1,n);
        l1[0]:=maxg; l2[0]:=-maxg;
        for i:=1 to n-1 do
        begin
                l1[i]:=min(l1[i-1],a[i].x);
                l2[i]:=max(l2[i-1],a[i].x);
        end;
        r1[n+1]:=maxg; r2[n+1]:=-maxg;
        for i:=n downto 2 do
        begin
                r1[i]:=min(r1[i+1],a[i].x);
                r2[i]:=max(r2[i+1],a[i].x);
        end;
        for i:=1 to n-1 do
                if a[i].y<>a[i+1].y then
                res:=min(res,max(max(a[i].y-p1.y,l2[i]-l1[i]),max(p2.y-a[i+1].y,r2[i+1]-r1[i+1])));

        //if res=0 then res:=1;
        writeln(res);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        readln(st,ms);
        for st:=1 to st do
        begin
                Enter;
                if ms=1 then Process1 else Process2;
        end;
        Close(input); Close(output);
End.
