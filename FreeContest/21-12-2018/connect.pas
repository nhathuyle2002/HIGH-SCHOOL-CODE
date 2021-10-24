Const   ginp='connect.inp';
        gout='connect.out';
        maxn=100010;

Type    edge= record x,y:longint; w:int64; end;
        point= record i,j:longint; end;

Var     n,m,p,q,modul,coue:longint;
        res:int64;
        e1,e2:array[0..maxn] of edge;
        pa:array[0..4010,0..4010] of point;
        h:array[0..4010,0..4010] of longint;

Procedure Sort(l,r:longint; var e:array of edge);
Var     i,j:longint;
        t,tmp:edge;
Begin
        if l>=r then exit;
        i:=l; j:=r;
        t:=e[random(r-l+1)+l];
        repeat
                while e[i].w<t.w do inc(i);
                while e[j].w>t.w do dec(j);
                if i<=j then
                begin
                        tmp:=e[i]; e[i]:=e[j]; e[j]:=tmp;
                        inc(i); dec(j);
                end;
        until i>j;
        sort(l,j,e); sort(i,r,e);
End;

Function FF(x,y:int64):int64;
Begin
        if x=0 then exit(0);
        ff:=(ff(x div 5,(y*5) mod modul)+x mod 5*y mod modul) mod modul;
End;

Procedure Enter;
Var     i,j:longint;
Begin
        readln(n,m,p,q,modul);
        res:=0;
        for i:=1 to p do
        with e1[i] do
        begin
                readln(x,y,w);
                res:=(res+ff(n,w)) mod modul;
        end;
        sort(1,p,e1);
        for i:=1 to q do
        with e2[i] do
        begin
                readln(x,y,w);
                res:=(res+ff(m,w)) mod modul;
        end;
        sort(1,q,e2);
        for i:=1 to n do
                for j:=1 to m do
                begin
                        pa[i,j].i:=i;
                        pa[i,j].j:=j;
                end;
End;

Function Find(i,j:longint):point;
Var     p:point;
Begin
        p.i:=i; p.j:=j;
        while (pa[p.i,p.j].i<>p.i) or (pa[p.i,p.j].j<>p.j) do p:=pa[i,j];
        find:=p;
End;

Function Max(x,y:longint):longint;
Begin
        if x>y then max:=x else max:=y;
End;

Procedure Add(i1,j1,i2,j2:longint; w:int64);
Var     r1,r2:point;
Begin
        r1:=find(i1,j1); r2:=find(i2,j2);
        if (r1.i<>r2.i) or (r1.j<>r2.j) then
        begin
                inc(coue); res:=(res-w) mod modul;
                if h[r1.i,r1.j]<h[r2.i,r2.j] then
                begin
                        pa[i1,j1]:=r2; pa[i2,j2]:=r2; pa[r1.i,r1.j]:=r2;
                end else
                begin
                        pa[i1,j1]:=r1; pa[i2,j2]:=r1; pa[r2.i,r2.j]:=r1;
                        h[r1.i,r1.j]:=max(h[r1.i,r1.j],h[r2.i,r2.j]+1);
                end;
        end else
        begin
                pa[i1,j1]:=r2; pa[i2,j2]:=r2;
        end;
End;

Procedure Process;
Var     i1,i2,j:longint;
Begin
        coue:=0;
        i2:=1;
        for i1:=1 to p do
        begin
                if coue=n*m-1 then break;
                while (i2<=q) and (e2[i2].w<=e1[i1].w) do
                begin
                        for j:=1 to m do add(e2[i2].x,j,e2[i2].y,j,e2[i2].w);
                        inc(i2);
                end;
                for j:=1 to n do add(j,e1[i1].x,j,e1[i1].y,e1[i1].w);
        end;
        while (i2<=q) and (e2[i2].w<=e1[i1].w) do
        begin
                if coue=n*m-1 then break;
                for j:=1 to m do add(e2[i2].x,j,e2[i2].y,j,e2[i2].w);
                inc(i2);
        end;
        write((res+modul) mod modul);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
