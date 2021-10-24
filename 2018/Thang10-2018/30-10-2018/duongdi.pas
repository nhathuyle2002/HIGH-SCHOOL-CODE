Uses    Math;

Const   ginp='duongdi.inp';
        gout='duongdi.out';
        maxn=100010;
        maxm=1000010;

Type    Edge= record x,y,link:longint; end;
        Save= record v,pos:longint; end;

Var     n,m,nt,res:longint;
        e,e1,e2:array[0..maxm] of edge;
        head,head1,head2:array[0..maxn] of longint;
        id:array[0..maxn] of save;
        tp,f:array[0..maxn,0..5] of longint;
        d:array[0..maxn] of boolean;
        ff:array[0..5] of longint;
        dd:array[0..5,0..5] of longint;
        d2:array[0..5] of boolean;
        top,cou:longint;
        num,low,st:array[0..maxn] of longint;

Procedure Cycle(u:longint);
Var     i,cc:longint;
Begin
        inc(cou); num[u]:=cou; low[u]:=cou;
        inc(top); st[top]:=u;
        i:=head[u];
        while i<>0 do
        with e[i] do
        begin
                if num[y]=0 then
                begin
                        cycle(y);
                        low[u]:=min(low[u],low[y]);
                end else
                if id[y].v=0 then
                        low[u]:=min(low[u],num[y]);
                i:=link;
        end;
        if low[u]=num[u] then
        begin
                inc(nt); cc:=0;
                repeat
                        i:=st[top]; dec(top);
                        inc(cc); tp[nt,cc]:=i;
                        id[i].v:=nt; id[i].pos:=cc;
                until i=u;
                tp[nt,0]:=cc;
        end;
End;

Procedure Try(paa,u,dep:longint);
Var     i:longint;
Begin
        d2[id[u].pos]:=false;
        dd[paa,id[u].pos]:=max(dd[paa,id[u].pos],dep);
        i:=head1[u];
        while i<>0 do
        with e1[i] do
        begin
                if d2[id[y].pos] then try(paa,y,dep+1);
                i:=link;
        end;
        d2[id[u].pos]:=true;
End;

Procedure Dfs(u:longint);
Var     i,ii:longint;
Begin
        d[u]:=false;
        for ii:=1 to tp[u,0] do
        begin
                for i:=1 to tp[u,0] do
                begin
                        dd[ii,i]:=0;
                        d2[i]:=true;
                end;
                try(ii,tp[u,ii],0);
        end;
        for ii:=1 to tp[u,0] do
        begin
                i:=head2[tp[u,ii]];
                ff[ii]:=1;
                while i<>0 do
                with e2[i] do
                begin
                        if d[id[y].v] then dfs(id[y].v);
                        ff[ii]:=max(ff[ii],f[id[y].v,id[y].pos]+1);
                        i:=link;
                end;
        end;
        for ii:=1 to tp[u,0] do
                for i:=1 to tp[u,0] do
                        f[u,ii]:=max(f[u,ii],dd[ii,i]+ff[i]);
End;

Procedure Enter;
Var     i:longint;
Begin
        readln(n,m);
        for i:=1 to m do
        with e[i] do
        begin
                readln(x,y);
                link:=head[x];
                head[x]:=i;
        end;
        for i:=1 to n do
                if num[i]=0 then cycle(i);
        for i:=1 to m do
        with e[i] do
                if id[x].v=id[y].v then
                begin
                        e1[i].x:=x; e1[i].y:=y;
                        e1[i].link:=head1[x];
                        head1[x]:=i;
                end else
                begin
                        e2[i].x:=x; e2[i].y:=y;
                        e2[i].link:=head2[x];
                        head2[x]:=i;
                end;
End;

Procedure Process;
Var     i,ii:longint;
Begin
        fillchar(d,sizeof(d),true);
        res:=0;
        for i:=1 to nt do
        begin
                if d[i] then dfs(i);
                for ii:=1 to tp[i,0] do
                        res:=max(res,f[i,ii]);
        end;
        write(res);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
