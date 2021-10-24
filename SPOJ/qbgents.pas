const   ginp='ss.inp';
        gout='ss.out';

type    que=record u1,u2,k:longint;end;

var     gi,go:text;
        n,m,s,t:longint;
        f:array[0..251,0..251,1..2] of longint;
        x,y,link:array[0..40000] of longint;
        head:array[0..251] of longint;
        l,r:longint;
        q:array[0..150000] of que;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n,m);
        readln(gi,s,t);
        for i:=1 to m do
        begin
                readln(gi,x[i],y[i]);
                link[i]:=head[x[i]];
                head[x[i]]:=i;
        end;
end;

procedure push(u1,u2,k:longint);
begin
        inc(r);
        q[r].u1:=u1;
        q[r].u2:=u2;
        q[r].k:=k;
end;

procedure process;
var     i,u1,u2,v,k,j:longint;
begin
        for i:=1 to n do
                for j:=1 to n do
                        for k:=1 to 2 do f[i,j,k]:=-1;
        l:=0;r:=0;
        f[s,t,1]:=0;push(s,t,1);
        repeat
                inc(l);
                u1:=q[l].u1;
                u2:=q[l].u2;
                k:=q[l].k;
                if k=1 then
                begin
                        i:=head[u1];
                        while i<>0 do
                        begin
                                v:=y[i];
                                if f[v,u2,2]=-1 then
                                begin
                                        f[v,u2,2]:=f[u1,u2,1]+1;
                                        push(v,u2,2);
                                end;
                                i:=link[i];
                        end;
                end;
                if k=2 then
                begin
                        i:=head[u2];
                        while i<>0 do
                        begin
                                v:=y[i];
                                if f[u1,v,1]=-1 then
                                begin
                                        f[u1,v,1]:=f[u1,u2,2]+1;
                                        push(u1,v,1);
                                end;
                                i:=link[i];
                        end;
                end;
        until l>=r;
end;

procedure output;
var     i,ans:longint;
begin
        ans:=trunc(1e9);
        for i:=1 to n do
                if f[i,i,1]<>-1 then
                if f[i,i,1]<ans then ans:=f[i,i,1];
        if ans=trunc(1e9) then write(go,-1) else write(go,ans div 2);
        close(gi);close(go);
end;

begin
        input;
        process;
        output;
end.













