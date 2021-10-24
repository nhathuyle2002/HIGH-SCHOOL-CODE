const   ginp='trafftax.inp';
        gout='trafftax.out';
        maxn=200001;

type    edge=record y,k:longint;d:boolean;end;

var     n,k,res:longint;
        e:array[-maxn..maxn] of edge;
        head,h:array[0..maxn] of longint;

procedure add(i,u,v:longint);
begin
        with e[i] do
        begin
                y:=v;
                k:=head[u];
                d:=true;
        end;
        head[u]:=i;
end;

procedure dfs(u:longint);
var     i,v:longint;
begin
        i:=head[u];
        while i<>0 do
        begin
                if e[i].d then
                begin
                        e[-i].d:=false;
                        v:=e[i].y;
                        dfs(v);
                        h[u]:=h[u]+h[v]+1;
                end;
                i:=e[i].k;
        end;
        if h[u]>=k then
        begin
                inc(res);
                h[u]:=-1;
        end;
end;

procedure main;
var     i,u,v:longint;
begin
        readln(n,k);
        for i:=1 to n-1 do
        begin
                readln(u,v);
                add(i,u,v);
                add(-i,v,u);
        end;
        res:=0;dfs(1);
        write(res);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        main;
        close(input);close(output);
end.
