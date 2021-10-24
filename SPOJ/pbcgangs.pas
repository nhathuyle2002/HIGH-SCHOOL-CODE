const   ginp='ss.inp';
        gout='ss.out';

type    edge=record x,y,k:longint;end;

var     n,m,cou,res:longint;
        e:array[-3000010..3000010] of edge;
        head:array[0..1010] of longint;
        d:array[0..1010,0..1010] of longint;
        dd:array[0..1010] of boolean;

procedure add(i,u,v:longint);
begin
        with e[i] do
        begin
                x:=u;y:=v;
                k:=head[u];
        end;
        head[u]:=i;
end;

procedure push(u,v:longint);
var     i:longint;
begin
        for i:=1 to d[u,0] do
        begin
                inc(cou);
                add(m+cou,v,d[u,i]);
                add(-m-cou,d[u,i],v);
        end;
        inc(d[u,0]);
        d[u,d[u,0]]:=v;
end;

procedure enter;
var     i,u,v:longint;
        c:string[1];
begin
        readln(n);readln(m);
        cou:=0;
        for i:=1 to m do
        begin
                readln(c,u,v);
                if c='F' then
                begin
                        add(i,u,v);
                        add(-i,v,u);
                end else
                begin
                        push(u,v);
                        push(v,u);
                end;
        end;
end;

procedure dfs(u:longint);
var     i,v:longint;
begin
        dd[u]:=false;
        i:=head[u];
        while i<>0 do
        begin
                v:=e[i].y;
                if dd[v] then dfs(v);
                i:=e[i].k;
        end;
end;

procedure process;
var     i:longint;
begin
        res:=0;
        fillchar(dd,sizeof(dd),true);
        for i:=1 to n do
                if dd[i] then
                begin
                        inc(res);
                        dfs(i);
                end;
        write(res);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        process;
        close(input);close(output);
end.
