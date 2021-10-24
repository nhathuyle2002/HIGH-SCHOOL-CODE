const   ginp='toponym.inp';
        gout='toponym.out';

type    trie=^node;
        node=record
                u,f:longint;
                c:array[' '..'z'] of trie;
        end;

var     n:longint;
        res:int64;
        root:trie;

function max(x,y:int64):int64;
begin
        if x>y then exit(x) else exit(y);
end;

procedure add(var p:trie);
var     i:char;
begin
        new(p);
        p^.c[' ']:=nil;
        for i:='A' to 'z' do p^.c[i]:=nil;
        p^.u:=0;p^.f:=0;
end;

procedure dfs(p:trie;ds:longint);
var     i:char;
begin
        if p^.c[' ']<>nil then
        begin
                dfs(p^.c[' '],ds+1);
                p^.f:=p^.f+(p^.c[' '])^.f;
        end;
        for i:='A' to 'z' do
                if p^.c[i]<>nil then
                begin
                        dfs(p^.c[i],ds+1);
                        p^.f:=p^.f+(p^.c[i])^.f;
                end;
        p^.f:=p^.f+p^.u;
        res:=max(res,int64(ds)*p^.f);
end;

procedure main;
var     i,ii:longint;
        p:trie;
        s:ansistring;
begin
        add(root);
        readln(n);
        for ii:=1 to n do
        begin
                readln(s);
                p:=root;
                for i:=1 to length(s) do
                begin
                        if p^.c[s[i]]=nil then add(p^.c[s[i]]);
                        p:=p^.c[s[i]];
                end;
                inc(p^.u);
        end;
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        main;
        res:=0;
        dfs(root,0);
        write(res);
        close(input);close(output);
end.

