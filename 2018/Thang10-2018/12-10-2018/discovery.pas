Const   ginp='discovery.inp';
        gout='discovery.out';
        maxn=1000010;
        dx:array[1..4] of longint =(1,0,0,-1);
        dy:array[1..4] of longint =(0,1,-1,0);
        ans:array[1..4] of char =('E','N','S','W');

Type    point= record x,y,pos:longint; end;
        tick= array[1..4] of boolean;

Var     n,below,top,start,finish:longint;
        a:array[0..maxn] of point;
        tracek,traceu,q:array[0..maxn] of longint;
        y:array[0..maxn,1..4] of longint;
        d:array[0..maxn] of tick;

Procedure Sort(l,r:longint);
Var     i,j:longint;
        t,tmp:point;
        tt:tick;
Begin
        if l>=r then exit;
        i:=l; j:=r;
        t:=a[random(r-l+1)+l];
        repeat
                while (a[i].x<t.x) or ((a[i].x=t.x) and (a[i].y<t.y)) do inc(i);
                while (a[j].x>t.x) or ((a[j].x=t.x) and (a[j].y>t.y)) do dec(j);
                if i<=j then
                begin
                        tmp:=a[i]; a[i]:=a[j]; a[j]:=tmp;
                        tt:=d[i]; d[i]:=d[j]; d[j]:=tt;
                        inc(i); dec(j);
                end;
        until i>j;
        sort(l,j); sort(i,r);
End;

Function Search(x,y:longint):longint;
Var     l,r,mid:longint;
Begin
        l:=1; r:=n;
        while l<r do
        begin
                mid:=(l+r) shr 1;
                if (a[mid].x<x) or ((a[mid].x=x) and (a[mid].y<y)) then l:=mid+1 else r:=mid;
        end;
        search:=l;
        if (a[l].x<>x) or (a[l].y<>y) then search:=0;
End;

Procedure Push(u,pa,k:longint);
Begin
        traceu[u]:=pa;
        tracek[u]:=k;
        inc(top); q[top]:=u;
End;

Function Pop:longint;
Begin
        pop:=q[below]; inc(below);
End;

Procedure Enter;
Var     i,nn,k:longint;
        s:ansistring;
Begin
        read(s);
        nn:=length(s);
        fillchar(d[1],sizeof(d[1]),false);
        a[1].x:=0; a[1].y:=0; a[1].pos:=1;
        for i:=1 to nn do
        begin
                a[i+1].pos:=i+1;
                fillchar(d[i+1],sizeof(d[i+1]),false);
                if s[i]='N' then
                begin
                        a[i+1].x:=a[i].x;
                        a[i+1].y:=a[i].y+1;
                        d[i,2]:=true; d[i+1,3]:=true;
                end else
                if s[i]='S' then
                begin
                        a[i+1].x:=a[i].x;
                        a[i+1].y:=a[i].y-1;
                        d[i,3]:=true; d[i+1,2]:=true;
                end else
                if s[i]='W' then
                begin
                        a[i+1].x:=a[i].x-1;
                        a[i+1].y:=a[i].y;
                        d[i,4]:=true; d[i+1,1]:=true;
                end else
                if s[i]='E' then
                begin
                        a[i+1].x:=a[i].x+1;
                        a[i+1].y:=a[i].y;
                        d[i,1]:=true; d[i+1,4]:=true;
                end;
        end;
        sort(1,nn+1);
        n:=0; a[0].x:=-maxn+1;
        for i:=1 to nn+1 do
        begin
                if (a[i].x<>a[i-1].x) or (a[i].y<>a[i-1].y) then
                begin
                        inc(n);
                        a[n]:=a[i];
                        d[n]:=d[i];
                end else
                for k:=1 to 4 do d[n,k]:=d[n,k] or d[i,k];
                if a[i].pos=1 then start:=n;
                if a[i].pos=nn+1 then finish:=n;
        end;
        for i:=1 to n do
                for k:=1 to 4 do y[i,k]:=search(a[i].x+dx[k],a[i].y+dy[k]);
End;

Procedure Process;
Var     k,u,v:longint;
Begin
        below:=1; top:=0;
        start:=search(0,0);
        push(finish,-1,0);
        repeat
                u:=pop;
                for k:=1 to 4 do
                begin
                        v:=y[u,k];
                        if (d[u,k]) and (v<>0) and (traceu[v]=0) then push(v,u,k);
                end;
        until (traceu[start]<>0) or (below>top);
End;

Procedure Answer;
Var     u:longint;
        s:ansistring;
Begin
        u:=start; s:='';
        while traceu[u]<>-1 do
        begin
                s:=s+ans[tracek[u]];
                u:=traceu[u];
        end;
        for u:=length(s) downto 1 do write(s[u]);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Answer;
        Close(input); Close(output);
End.
