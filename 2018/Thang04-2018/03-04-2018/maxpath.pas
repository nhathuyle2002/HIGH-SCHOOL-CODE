const   ginp='maxpath.inp';
        gout='maxpath.out';

var     gi,go:text;
        n,m,s,t:longint;
        sum,ans:int64;
        link,y,w,x:array[0..1000100] of longint;
        head:array[0..100100] of longint;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n,m,s,t);
        for i:=1 to m do
        begin
                readln(gi,x[i],y[i],w[i]);
                link[i]:=head[x[i]];
                head[x[i]]:=i;
        end;
end;

procedure dfs(u:longint);
var     v,i:longint;
begin
        if (u=t) and (ans<sum) then ans:=sum;
        i:=head[u];
        while i<>0 do
        begin
                v:=y[i];
                sum:=sum+w[i];
                dfs(v);
                sum:=sum-w[i];
                i:=link[i];
        end;
end;

procedure output;
begin
        ans:=-maxlongint;
        sum:=0;
        dfs(s);
        if ans=-maxlongint then write(go,'NO') else
        begin
                writeln(go,'YES');
                write(go,ans);
        end;
        close(gi);close(go);
end;

begin
        input;
        output;
end.











