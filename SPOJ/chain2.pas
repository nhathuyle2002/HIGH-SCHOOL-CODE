const   ginp='ss.inp';
        gout='ss.out';

type    trie=^node;
        node=record
                u,f:longint;
                c:array['a'..'z'] of trie;
        end;

var     gi,go:text;
        n:longint;
        root:trie;

function max(x,y:longint):longint; inline;
begin
        if x>y then exit(x) else exit(y);
end;

procedure add(var p:trie); inline;
var     i:char;
begin
        new(p);
        p^.u:=0;
        p^.f:=0;
        for i:='a' to 'z' do p^.c[i]:=nil;
end;

procedure input;
var     i,j:longint;
        s:string;
begin
        readln(gi,n);
        add(root);
        for j:=1 to n do
        begin
                readln(gi,s);p:=root;
                for i:=1 to length(s) do
                begin
                        if p^.c[s[i]]=nil then add(p^.c[s[i]]);
                        p:=p^.c[s[i]];
                end;
                p^.u:=1;
        end;
end;

procedure dfs(p:trie); inline;
var     i:char;
        v:trie;
begin
        p^.f:=p^.u;
        for i:='a' to 'z' do
                if p^.c[i]<>nil then
                begin
                        v:=p^.c[i];dfs(v);
                        p^.f:=max(p^.f,v^.f+p^.u);
                end;
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        input;
        dfs(root);
        writeln(go,root^.f);
        close(gi);close(go);
end.



