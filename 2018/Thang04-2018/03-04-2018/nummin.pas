const   ginp='nummin.inp';
        gout='nummin.out';
        k=11235813;

var     gi,go:text;
        n,m:longint;
        link,y,x:array[0..1000100] of longint;
        head,kc:array[0..100100] of longint;
        cd:array[0..100100] of int64;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n,m);
        for i:=1 to m do readln(gi,x[i],y[i]);
end;

procedure swap(var xx,yy:longint);
var     tm:longint;
begin
        tm:=xx;
        xx:=yy;
        yy:=tm;
end;

procedure sort(l,r:longint);
var     i,j,tmx,tmy:longint;
begin
        if l>=r then exit;
        i:=random(r-l+1)+l;
        tmx:=x[i];tmy:=y[i];
        i:=l;j:=r;
        repeat
                while (x[i]<tmx) or ((x[i]=tmx) and (y[i]<tmy)) do inc(i);
                while (x[j]>tmx) or ((x[j]=tmx) and (y[j]>tmy)) do dec(j);
                if i<=j then
                begin
                        swap(x[i],x[j]);
                        swap(y[i],y[j]);
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j);sort(i,r);
end;

procedure create;
var     i:longint;
begin
        sort(1,m);
        for i:=1 to m do
                if (x[i]<>x[i-1]) or (y[i]<>y[i-1]) then
                begin
                        link[i]:=head[x[i]];
                        head[x[i]]:=i;
                end;
end;

procedure bfs;
var     i,v,l,r,u:longint;
        d:array[0..100100] of boolean;
        q:array[0..1000100] of longint;
begin
        l:=0;r:=1;q[1]:=1;cd[1]:=1;
        fillchar(d,sizeof(d),true);
        d[1]:=false;
        repeat
                inc(l);
                u:=q[l];
                i:=head[u];
                while i<>0 do
                begin
                        v:=y[i];
                        if d[v] then
                        begin
                                kc[v]:=kc[u]+1;
                                cd[v]:=cd[u];
                                inc(r);
                                q[r]:=v;
                                d[v]:=false;
                        end
                        else    if kc[v]=kc[u]+1 then cd[v]:=(cd[u]+cd[v]) mod k;
                        i:=link[i];
                end;
        until l>=r;
end;

procedure output;
var     i:longint;
begin
        for i:=1 to n do write(go,cd[i],' ');
        close(gi);close(go);
end;

begin
        input;
        create;
        bfs;
        output;
end.











