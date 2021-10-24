const   ginp='ss.inp';
        gout='ss.out';
        vc=1000000000;

var     gi,go:text;
        n,maxt,m,ans:longint;
        link,x,y,w,t:array[-10000..10000] of longint;
        ft,fd,head:array[0..101] of longint;

procedure add(i,u,v,c,p:longint);
begin
        x[i]:=u;y[i]:=v;w[i]:=c;t[i]:=p;
        link[i]:=head[u];head[u]:=i;
end;

procedure input;
var     i,u,v,c,p:longint;
begin
        readln(gi,maxt);
        readln(gi,n);
        readln(gi,m);
        fillchar(link,sizeof(link),0);
        fillchar(head,sizeof(head),0);
        for i:=1 to m do
        begin
                readln(gi,u,v,c,p);
                add(i,u,v,c,p);
                add(-i,v,u,c,p);
        end;
end;

procedure dijkstra1;
var     i,u,v:longint;
        d:array[0..101] of boolean;
begin
        for i:=0 to n do fd[i]:=vc;
        fillchar(d,sizeof(d),true);
        fd[n]:=0;
        repeat
                u:=0;
                for i:=1 to n do
                        if (fd[i]<fd[u]) and (d[i]) then u:=i;
                if u=0 then exit;
                d[u]:=false;
                i:=head[u];
                while i<>0 do
                begin
                        v:=y[i];
                        if (d[v]) and (fd[v]>fd[u]+w[i]) then fd[v]:=fd[u]+w[i];
                        i:=link[i];
                end;
        until false;
end;

procedure dijkstra2;
var     i,u,v:longint;
        d:array[0..101] of boolean;
begin
        for i:=0 to n do ft[i]:=vc;
        fillchar(d,sizeof(d),true);
        ft[n]:=0;
        repeat
                u:=0;
                for i:=1 to n do
                        if (ft[i]<ft[u]) and (d[i]) then u:=i;
                if u=0 then exit;
                d[u]:=false;
                i:=head[u];
                while i<>0 do
                begin
                        v:=y[i];
                        if (d[v]) and (ft[v]>ft[u]+t[i]) then ft[v]:=ft[u]+t[i];
                        i:=link[i];
                end;
        until false;
end;

procedure try(u,cp,qd:longint);
var     i,v:longint;
begin
        if ft[u]>cp then exit;
        if qd+fd[u]>=ans then exit;
        if u=n then
        begin
                if qd<ans then ans:=qd;
                exit;
        end;
        i:=head[u];
        while i<>0 do
        begin
                v:=y[i];
                try(v,cp-t[i],qd+w[i]);
                i:=link[i];
        end;
end;

procedure main;
var     i,st:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,st);
        for i:=1 to st do
        begin
                input;
                dijkstra1;
                dijkstra2;
                ans:=vc;
                try(1,maxt,0);
                if ans=vc then writeln(go,-1) else writeln(go,ans);
        end;
        close(gi);close(go);
end;

begin
        main;
end.
