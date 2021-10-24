const   ginp='trafftax.inp';
        gout='trafftax.out';
        maxn=200100;

type    edge=record y,k:longint;d:boolean;end;

var     gi,go:text;
        n,k:longint;
        e:array[-maxn..maxn] of edge;
        head:array[0..maxn] of longint;
        f:array[0..maxn,0..101] of longint;

procedure add(i,u,v:longint);
begin
        with e[i] do
        begin
                y:=v;k:=head[u];
                d:=true;
        end;
        head[u]:=i;
end;

procedure input;
var     i,u,v:longint;
begin
        readln(gi,n,k);
        for i:=1 to n-1 do
        begin
                readln(gi,u,v);
                add(i,u,v);
                add(-i,v,u);
        end;
end;

function max(x,y:longint):longint;
begin
        if x>y then exit(x) else exit(y);
end;

procedure dfs(u:longint);
var     i,j,v:longint;
        ma1,ma2:array[0..101] of longint;
begin
        i:=head[u];
        f[u,0]:=1;
        for j:=1 to k do
        begin
                ma1[j]:=n+1;
                ma2[j]:=n+1;               /sai/
        end;
        while i<>0 do
        begin
                if e[i].d then
                begin
                        e[-i].d:=false;
                        v:=e[i].y;
                        dfs(v);
                        f[u,0]:=max(f[u,0],f[v,k]+1);
                        for j:=1 to k do
                                if f[v,j-1]>=f[ma1[j],j] then
                                begin
                                        ma2[j]:=ma1[j];ma1[j]:=v;
                                end else
                                if f[v,j-1]>f[ma2[j],j] then ma2[j]:=v;
                end;
                i:=e[i].k;
        end;
        for j:=1 to k do
                if ma1[j]=ma1[k-j+1] then f[u,j]:=f[ma1[j],j-1]+f[ma2[k-j+1],k-j+1]
                else f[u,j]:=f[ma1[j],j-1]+f[ma2[k-j+1],k-j+1];
end;

procedure main;
var     i,res:longint;
begin
        dfs(1);
        res:=n;
        for i:=0 to k do
                if f[1,i]<res then res:=f[1,i];
        write(go,res);
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        input;
        main;
        close(gi);close(go);
end.