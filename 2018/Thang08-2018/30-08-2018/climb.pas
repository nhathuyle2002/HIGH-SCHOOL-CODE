const   ginp='climb.inp';
        gout='climb.out';

var     m,n,res:longint;
        h,f,v:array[0..1000010] of longint;
        d:array[1..4] of longint;

procedure enter;
var     i,j:longint;
begin
        readln(m,n);
        for i:=1 to m do
        begin
                for j:=1 to n do
                begin
                        v[(i-1)*n+j]:=(i-1)*n+j;
                        read(h[(i-1)*n+j]);
                end;
                readln;
        end;
end;

function max(x,y:longint):longint;
begin
        if x>y then exit(x) else exit(y);
end;

procedure sort(l,r:longint);
var     i,j,t,tm:longint;
begin
        if l>=r then exit;
        i:=l;j:=r;
        t:=h[random(r-l+1)+l];
        repeat
                while h[i]<t do inc(i);
                while h[j]>t do dec(j);
                if i<=j then
                begin
                        tm:=h[i];h[i]:=h[j];h[j]:=tm;
                        tm:=v[i];v[i]:=v[j];v[j]:=tm;
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j);sort(i,r);
end;

function check(u,k:longint):boolean;
begin
        if (u<=0) or (u>m*n) or ((k=2) and (u mod n=0)) or ((k=3) and (u mod n=1)) then exit(false);
        exit(true);
end;

procedure dfs(u:longint);
var     k,v,tmp:longint;
begin
        if f[u]>0 then exit;
        tmp:=0;
        for k:=1 to 4 do
        begin
                v:=u+d[k];
                if (check(v,k)) and (h[u]<h[v]) then
                begin
                        dfs(v);
                        tmp:=max(tmp,f[v]);
                end;
        end;
        f[u]:=tmp+1;
end;

procedure process;
var     u:longint;
begin
        d[1]:=-n;d[2]:=-1;d[3]:=1;d[4]:=n;
        for u:=1 to m*n do
        begin
                dfs(u);
                res:=max(res,f[u]);
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
