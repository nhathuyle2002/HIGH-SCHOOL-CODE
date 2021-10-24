Uses    Math;

Const   ginp='rect.inp';
        gout='rect.out';
        maxn=1001;

Type    point= record x,y:longint; end;
        save= record td:point; le:int64; g:extended; end;

Var     n,nc,nb:longint;
        res:int64;
        a:array[0..maxn] of point;
        c:array[0..maxn*maxn] of save;
        //p:array[0..maxn*maxn] of point;
        b:array[0..maxn*maxn] of extended;

Function Cmp(p,q:save):boolean; inline;
Begin
        if p.le<>q.le then exit(p.le<q.le);
        if p.td.x<>q.td.x then exit(p.td.x<q.td.x);
        if p.td.y<>q.td.y then exit(p.td.y<q.td.y);
        if p.g<>q.g then exit(p.g<q.g);
        exit(false);
End;

Function Khac(p,q:save):boolean; inline;
Begin
        if p.le<>q.le then exit(true);
        if p.td.x<>q.td.x then exit(true);
        if p.td.y<>q.td.y then exit(true);
        //if p.g<>q.g then exit(true);
        exit(false);
End;

Procedure Sort(l,r:longint); inline;
Var     i,j:longint;
        t,tmp:save;
        //t2:point;
Begin
        if l>=r then exit;
        i:=l; j:=r;
        t:=c[random(r-l+1)+l];
        repeat
                while cmp(c[i],t) do inc(i);
                while cmp(t,c[j]) do dec(j);
                if i<=j then
                begin
                        tmp:=c[i]; c[i]:=c[j]; c[j]:=tmp;
                        //t2:=p[i]; p[i]:=p[j]; p[j]:=t2;
                        inc(i); dec(j);
                end;
        until i>j;
        sort(l,j); sort(i,r);
End;

Procedure Enter;
Var     i,j:longint;
Begin
        readln(n);
        for i:=1 to n do readln(a[i].x,a[i].y);
        nc:=0;
        for i:=1 to n do
                for j:=1 to n do
                begin
                        inc(nc);
                        with c[nc] do
                        begin
                                td.x:=a[i].x+a[j].x;
                                td.y:=a[i].y+a[j].y;
                                le:=int64(a[i].x-a[j].x)*(a[i].x-a[j].x)+int64(a[i].y-a[j].y)*(a[i].y-a[j].y);
                                if a[i].x-a[j].x=0 then g:=pi/2
                                else g:=arctan((a[i].y-a[j].y)/(a[i].x-a[j].x));
                        end;
                        //p[nc].x:=i; p[nc].y:=j;
                end;
        sort(1,nc);
End;

Procedure Check(leng:int64); inline;
Var     i,j:longint;
Begin
        j:=1;
        for i:=1 to nb-1 do
        begin
                while (j<nb) and (b[j]-b[i]<=pi/2) do inc(j);
                res:=max(res,round(sin(b[j]-b[i])/2*leng));
                res:=max(res,round(sin(b[j-1]-b[i])/2*leng));
        end;
End;

Procedure Process;
Var     i:longint;
Begin
        res:=0;
        c[nc+1].le:=-1;
        nb:=1; b[1]:=c[1].g;
        for i:=2 to nc+1 do
        begin
                if khac(c[i],c[i-1]) then
                begin
                        check(c[i-1].le);
                        nb:=0;
                end;
                inc(nb); b[nb]:=c[i].g;
        end;
        write(res);
End;

Procedure Sinh;
Var     i,p:longint;
Begin
        assign(output,ginp); rewrite(output);
        n:=1000;  p:=trunc(1e8);
        writeln(n);
        for i:=1 to n do
                writeln(random(2*p)-p,' ',random(2*p)-p);
        close(output);
End;

Begin
        //Sinh;
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.

