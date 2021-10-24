Const   ginp='dulich.inp';
        gout='dulich.out';
        maxn=50010;
        maxm=150010;
        maxmf=1010;
        oo=trunc(1e14);

Type    edge= record y,link,w:longint; end;
        save= record u,k:longint; end;

Var     n,m,mf,start,finish,nheap:longint;
        head,headf:array[0..maxn] of longint;
        ef:array[0..maxmf] of edge;
        e:array[-maxm..maxm] of edge;
        d:array[0..maxn,0..1] of int64;
        pos:array[0..maxn,0..1] of longint;
        hp:array[0..2*maxn] of save;

Procedure Add(i,u,v,c,t:longint);
Begin
        if t=1 then
        with e[i] do
        begin
                y:=v; w:=c;
                link:=head[u];
                head[u]:=i;
        end;
        if t=-1 then
        with ef[i] do
        begin
                y:=v;
                link:=headf[u];
                headf[u]:=i;
        end;
End;

Procedure Update(u,k:longint; x:int64);
Var     i,j:longint;
Begin
        if d[u,k]<=x then exit;
        d[u,k]:=x;
        if pos[u,k]=0 then
        begin
                inc(nheap);
                pos[u,k]:=nheap;
        end;
        i:=pos[u,k];
        repeat
                j:=i shr 1;
                if (j<1) or (d[hp[j].u,hp[j].k]<=x) then break;
                pos[hp[j].u,hp[j].k]:=i;
                hp[i]:=hp[j];
                i:=j;
        until false;
        pos[u,k]:=i;
        hp[i].u:=u; hp[i].k:=k;
End;

Function Pop:save;
Var     i,j,u,k:longint;
Begin
        pop:=hp[1];
        u:=hp[nheap].u; k:=hp[nheap].k; dec(nheap);
        i:=1;
        repeat
                j:=i shl 1;
                if (j<nheap) and (d[hp[j+1].u,hp[j+1].k]<d[hp[j].u,hp[j].k]) then inc(j);
                if (j>nheap) or (d[u,k]<=d[hp[j].u,hp[j].k]) then break;
                pos[hp[j].u,hp[j].k]:=i;
                hp[i]:=hp[j];
                i:=j;
        until false;
        pos[u,k]:=i;
        hp[i].u:=u; hp[i].k:=k;
End;

Procedure Enter;
Var     i,u,v,c:longint;
Begin
        readln(n,m,mf,start,finish);
        for i:=1 to m do
        begin
                readln(u,v,c);
                add(i,u,v,c,1);
                add(-i,v,u,c,1);
        end;
        for i:=1 to mf do
        begin
                readln(u,v);
                add(i,u,v,0,-1);
        end;
End;

Procedure Process;
Var     i:longint;
        u:save;
Begin
        for i:=0 to n-1 do
        begin
                d[i,0]:=oo; pos[i,0]:=0;
                d[i,1]:=oo; pos[i,1]:=0;
        end;
        nheap:=0;
        update(start,0,0);
        repeat
                u:=pop;
                if u.u=finish then break;
                i:=head[u.u];
                while i<>0 do
                with e[i] do
                begin
                        update(y,u.k,d[u.u,u.k]+w);
                        i:=link;
                end;
                if u.k=1 then continue;
                i:=headf[u.u];
                while i<>0 do
                with ef[i] do
                begin
                        update(y,1,d[u.u,u.k]);
                        i:=link;
                end;
        until false;
        write(d[u.u,u.k]);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
