const   ginp='ss.inp';
        gout='ss.out';

type    trie=^node;
        node=record
                f:longint;
                c:array['@'..'z'] of trie;
        end;

var     gi,go:text;
        n:longint;
        root:trie;
        s:array[0..100010] of string[15];
        f:array[0..100010] of trie;

procedure add(var a:trie);
var     i:char;
begin
        new(a);
        for i:='@' to 'z' do a^.c[i]:=nil;
        a^.f:=0;
end;

procedure main;
var     i,k:longint;
        p:trie;
begin
        readln(gi,n);
        add(root);
        for k:=1 to n do
        begin
                readln(gi,s[k]);p:=root;
                for i:=1 to length(s[k]) do
                begin
                        if p^.c[s[k,i]]=nil then add(p^.c[s[k,i]]);
                        p:=p^.c[s[k,i]];
                end;
                inc(p^.f);f[k]:=p;
        end;
        for i:=1 to n do
                if f[i]^.f=1 then write(go,s[i]);
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        main;
        close(gi);close(go);
end.
