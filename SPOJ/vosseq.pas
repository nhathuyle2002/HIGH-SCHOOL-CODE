const   ginp='ss.inp';
        gout='ss.out';
        maxn=1000010;

var     n,nh,m:longint;
        deg,head,y,link,h:array[0..maxn] of longint;

procedure swap(var u,v:longint);
var     tm:longint;
begin
        tm:=u;u:=v;v:=tm;
end;

procedure upheap(i:longint);
var     j:longint;
begin
        j:=i shr 1;
        if j<1 then exit;
        if h[i]<h[j] then
        begin
                swap(h[i],h[j]);
                upheap(j);
        end;
end;

procedure push(u:longint);
begin
        inc(nh);
        h[nh]:=u;
        upheap(nh);
end;

procedure downh(i:longint);
var     j:longint;
begin
        j:=i shl 1;
        if j>nh then exit;
        if (j<nh) and (h[j+1]<h[j]) then inc(j);
        if h[j]<h[i] then
        begin
                swap(h[i],h[j]);
                downh(j);
        end;
end;

function pop:longint;
begin
        pop:=h[1];
        h[1]:=h[nh];
        dec(nh);
        downh(1);
end;

procedure enter;
var     i,t,u,v,kk,k:longint;
begin
        m:=0;n:=1;
        readln(kk);
        for t:=1 to kk do
        begin
                readln(k);read(u);
                if u>n then n:=u;
                for i:=1 to k-1 do
                begin
                        read(v);inc(deg[v]);
                        inc(m);y[m]:=v;
                        link[m]:=head[u];
                        head[u]:=m;
                        u:=v;
                        if u>n then n:=u;
                end;
        end;
end;

procedure process;
var     u,v,i:longint;
begin
        for u:=1 to n do
                if deg[u]=0 then push(u);
        repeat
                u:=pop;
                write(u,' ');
                i:=head[u];
                while i<>0 do
                begin
                        v:=y[i];
                        dec(deg[v]);
                        if deg[v]=0 then push(v);
                        i:=link[i];
                end;
                dec(n);
        until n=0;
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        process;
        close(input);close(output);
end.
