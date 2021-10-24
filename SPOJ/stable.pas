const   ginp='ss.inp';
        gout='ss.out';

var     gi,go:text;
        n,m,s:longint;
        link,x,y:array[0..50010] of longint;
        f,head,ch:array[0..10010] of longint;

procedure swap(var xx,yy:longint);
var     tm:longint;
begin
        tm:=xx;xx:=yy;yy:=tm;
end;

procedure sort(l,r:longint);
var     i,j,t,tm1,tm2:longint;
begin
        if l>=r then exit;
        i:=l;j:=r;
        tm1:=random(r-l+1)+l;
        tm2:=y[tm1];tm1:=x[tm1];
        repeat
                while (x[i]<tm1) or ((x[i]=tm1) and (y[i]<tm2)) do inc(i);
                while (x[j]>tm1) or ((x[j]=tm1) and (y[j]>tm2)) do dec(j);
                if i<=j then
                begin
                        swap(x[i],x[j]);swap(y[i],y[j]);
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j);sort(i,r);
end;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n,m,s);
        for i:=1 to m do readln(gi,x[i],y[i]);
        sort(1,m);
        for i:=1 to m do
                if (x[i]<>x[i-1]) or (y[i]<>y[i-1]) then
                begin
                        link[i]:=head[x[i]];
                        head[x[i]]:=i;
                end;
end;

procedure process;
var     i,r,l,u,v:longint;
        q:array[0..10010] of longint;
begin
        for i:=1 to n do f[i]:=-1;
        f[s]:=0;l:=0;r:=1;q[1]:=s;ch[s]:=1;
        repeat
                inc(l);u:=q[l];i:=head[u];
                while i<>0 do
                begin
                        v:=y[i];
                        if f[v]=-1 then
                        begin
                                inc(r);q[r]:=v;
                                f[v]:=f[u]+1;ch[v]:=ch[u];
                        end else
                        if f[v]=f[u]+1 then ch[v]:=2;
                        i:=link[i];
                end;
        until l>=r;
end;

procedure output;
var     i,ans:longint;
begin
        ans:=0;
        for i:=1 to n do
                if ch[i]>=2 then inc(ans);
        write(go,ans);
        close(gi);close(go);
end;

begin
        input;
        process;
        output;
end.
