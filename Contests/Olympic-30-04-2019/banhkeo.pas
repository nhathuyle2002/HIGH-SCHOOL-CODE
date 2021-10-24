const   ginp='banhkeo.inp';
        gout='banhkeo.out';

var     gi,go:text;
        n,m,w,ans:longint;
        link,y,x:array[-100001..100001] of longint;
        head:array[0..1001] of longint;
        d:array[0..1001] of boolean;

procedure ad(i,u,v:longint);
begin
        x[i]:=u;y[i]:=v;
        link[i]:=head[u];head[u]:=i;
end;

procedure input;
var     i,k,c,u,v:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n,m,k);
        w:=maxlongint;
        for i:=1 to k do
        begin
                read(gi,c);
                if c<w then w:=c;
        end;
        readln(gi);
        for i:=1 to m do
        begin
                readln(gi,u,v,c);
                if c>=w then
                begin
                        ad(i,u,v);
                        ad(-i,v,u);
                end;
        end;
end;

procedure dfs(u:longint);
var     i,v:longint;
begin
        d[u]:=false;
        i:=head[u];
        while i<>0 do
        begin
                v:=y[i];
                if d[v] then dfs(v);
                i:=link[i];
        end;
end;

procedure output;
var     i:longint;
begin
        ans:=0;
        fillchar(d,sizeof(d),true);
        for i:=1 to n do
                if d[i] then
                begin
                        inc(ans);
                        dfs(i);
                end;
        write(go,ans);
        close(gi);close(go);
end;

begin
        input;
        output;
end.
