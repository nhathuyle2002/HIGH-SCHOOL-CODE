const   ginp='ss.inp';
        gout='ss.out';

type    trie=^node;
        node=record
                u,f:longint;
                c:array[0..1] of trie;
        end;

var     gi,go:text;
        m,n,res:longint;
        root:trie;

procedure add(var a:trie); inline;
var     i:longint;
begin
        new(a);
        a^.u:=0;a^.f:=0;
        for i:=0 to 1 do a^.c[i]:=nil;
end;

procedure input;
var     i,j,k,x:longint;
        p:trie;
begin
        readln(gi,m,n);
        add(root);
        for j:=1 to m do
        begin
                read(gi,k);p:=root;
                for i:=1 to k do
                begin
                        read(gi,x);
                        if p^.c[x]=nil then add(p^.c[x]);
                        inc(p^.f);p:=p^.c[x];
                end;
                inc(p^.u);readln(gi);
        end;
end;

procedure dfs(a:trie;k:longint);
var     x:longint;
        p:trie;
begin
        if k=0 then
        begin
                res:=res+a^.f;
                exit;
        end;
        read(gi,x);p:=a^.c[x];
        if p=nil then exit;
        dfs(p,k-1);
        res:=res+p^.u;
end;

procedure process;
var     i,k:longint;
begin
        for i:=1 to n do
        begin
                read(gi,k);
                res:=0;dfs(root,k);
                writeln(go,res);
                readln(gi);
        end;
end;

begin
        assign(gi,ginp);reset(gi);
        assign(go,gout);rewrite(go);
        input;
        process;
        close(gi);close(go);
end.
