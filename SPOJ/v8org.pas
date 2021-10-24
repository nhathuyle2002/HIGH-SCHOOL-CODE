const   ginp='ss.inp';
        gout='ss.out';

var     gi,go:text;
        n,k:longint;
        x,y,link,head,f:array[0..10001] of longint;
        d:array[0..10001] of boolean;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,k);
        readln(gi,n);
        for i:=2 to n do
        begin
                read(gi,x[i]);y[i]:=i;
                link[i]:=head[x[i]];head[x[i]]:=i;
        end;
end;

procedure try(u:longint);
var     i,v:longint;
begin
        i:=head[u];f[u]:=1;
        while i<>0 do
        begin
                v:=y[i];
                try(v);
                f[u]:=f[u]+f[v];
                i:=link[i];
        end;
        if f[u]>=k then
        begin
                d[u]:=false;
                f[u]:=0;
        end;
end;

procedure output;
var     i,ans:longint;
begin
        fillchar(d,sizeof(d),true);
        try(1);
        ans:=0;
        for i:=1 to n do
                if d[i]=false then inc(ans);
        write(go,ans);
        close(gi);close(go);
end;

begin
        input;
        output;
end.
