const   ginp='least.inp';
        gout='least.out';

var     gi,go:text;
        n,m,ks,kt,ans:longint;
        link,y:array[0..1000100] of longint;
        head,tp:array[0..100100] of longint;

procedure input;
var     i,u:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n,m);
        for i:=1 to m do
        begin
                readln(gi,u,y[i]);
                link[i]:=head[u];
                head[u]:=i;
        end;
        read(gi,ks);
        for i:=1 to ks do
        begin
                read(gi,u);
                tp[u]:=1;
        end;
        readln(gi);
        read(gi,kt);
        for i:=1 to kt do
        begin
                read(gi,u);
                tp[u]:=2;
        end;
end;

procedure bfs;
var     i,v,l,r:longint;
        d:array[0..100100] of boolean;
        q,kc:array[0..1000100] of longint;
begin
        ans:=-1;
        l:=0;r:=0;
        fillchar(d,sizeof(d),true);
        for i:=1 to n do
                if tp[i]=1 then
                begin
                        inc(r);
                        q[r]:=i;
                        kc[r]:=0;
                        d[i]:=false;
                end;
        repeat
                inc(l);
                if tp[q[l]]=2 then
                begin
                        ans:=kc[l];
                        exit;
                end;
                i:=head[q[l]];
                while i<>0 do
                begin
                        v:=y[i];
                        if d[v] then
                        begin
                                inc(r);
                                q[r]:=v;
                                d[v]:=false;
                                kc[r]:=kc[l]+1;
                        end;
                        i:=link[i];
                end;
        until l>=r;
end;

procedure output;
begin
        write(go,ans);
        close(gi);close(go);
end;

begin
        input;
        bfs;
        output;
end.











