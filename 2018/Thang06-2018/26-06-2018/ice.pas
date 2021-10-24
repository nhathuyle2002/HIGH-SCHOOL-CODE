const   ginp='ice.inp';
        gout='ice.out';
        oo=trunc(1e9)+1000;

type    point=record x,y,v:longint;end;
        save=record p:point;u,k:longint;end;

var     gi,go:text;
        n,l,r,m,res:longint;
        a,b:array[0..20010] of point;
        f:array[0..20010,1..4] of longint;
        q,ch:array[0..80010] of save;

procedure sort1(l,r:longint);
var     i,j:longint;
        t,tm:point;
begin
        if l>=r then exit;
        i:=l;j:=r;
        t:=a[random(r-l+1)+l];
        repeat
                while (a[i].x<t.x) or ((a[i].x=t.x) and (a[i].y<t.y)) do inc(i);
                while (a[j].x>t.x) or ((a[j].x=t.x) and (a[j].y>t.y)) do dec(j);
                if i<=j then
                begin
                        tm:=a[i];a[i]:=a[j];a[j]:=tm;
                        inc(i);dec(j);
                end;
        until i>j;
        sort1(l,j);sort1(i,r);
end;

procedure sort2(l,r:longint);
var     i,j:longint;
        t,tm:point;
begin
        if l>=r then exit;
        i:=l;j:=r;
        t:=b[random(r-l+1)+l];
        repeat
                while (b[i].y<t.y) or ((b[i].y=t.y) and (b[i].x<t.x)) do inc(i);
                while (b[j].y>t.y) or ((b[j].y=t.y) and (b[j].x>t.x)) do dec(j);
                if i<=j then
                begin
                        tm:=b[i];b[i]:=b[j];b[j]:=tm;
                        inc(i);dec(j);
                end;
        until i>j;
        sort2(l,j);sort2(i,r);
end;

function cnp1(p:point):longint;
var     dd,cc,mm:longint;
begin
        dd:=1;cc:=n+1;
        while dd<cc do
        begin
                mm:=(dd+cc)>>1;
                if (a[mm].x<p.x) or ((a[mm].x=p.x) and (a[mm].y<=p.y)) then dd:=mm+1 else cc:=mm;
        end;
        exit(dd);
end;

function cnp2(p:point):longint;
var     dd,cc,mm:longint;
begin
        dd:=1;cc:=n+1;
        while dd<cc do
        begin
                mm:=(dd+cc)>>1;
                if (b[mm].y<p.y) or ((b[mm].y=p.y) and (b[mm].x<p.x)) then dd:=mm+1 else cc:=mm;
        end;
        exit(dd);
end;

procedure push(p:point;u,k,ff:longint);
begin
        inc(r);
        q[r].p:=p;q[r].u:=u;q[r].k:=k;
        f[u,k]:=ff;
end;

procedure input;
var     i,tt:longint;
        s,t:point;
begin
        readln(gi,n,s.x,s.y,t.x,t.y);
        m:=0;
        for i:=1 to n do
        begin
                readln(gi,a[i].x,a[i].y);a[i].v:=i;
                if a[i].x=t.x then
                begin
                        if a[i].y-t.y=1 then
                        begin
                                inc(m);ch[m].u:=i;ch[m].k:=2;
                        end;
                        if t.y-a[i].y=1 then
                        begin
                                inc(m);ch[m].u:=i;ch[m].k:=3;
                        end;
                end;
                if a[i].y=t.y then
                begin
                        if a[i].x-t.x=1 then
                        begin
                                inc(m);ch[m].u:=i;ch[m].k:=1;
                        end;
                        if t.x-a[i].x=1 then
                        begin
                                inc(m);ch[m].u:=i;ch[m].k:=4;
                        end;
                end;
        end;
        a[0].x:=-oo;a[0].y:=-oo;
        a[n+1].x:=oo;a[n+1].y:=oo;
        b:=a;sort1(1,n);sort2(1,n);
        for i:=0 to n+1 do
                for tt:=1 to 4 do f[i,tt]:=-1;
        l:=0;r:=0;
        tt:=cnp1(s);
        if a[tt].x=s.x then push(a[tt],a[tt].v,2,1);
        dec(tt);
        if a[tt].x=s.x then push(a[tt],a[tt].v,3,1);
        tt:=cnp2(s);
        if b[tt].y=s.y then push(b[tt],b[tt].v,1,1);
        dec(tt);
        if b[tt].y=s.y then push(b[tt],b[tt].v,4,1);
end;

procedure process;
var     i,u,k,tt:longint;
        p:point;
begin
        repeat
                inc(l);p:=q[l].p;u:=q[l].u;k:=q[l].k;
                if (k=1) or (k=4) then
                begin
                        if k=1 then dec(p.x) else inc(p.x);
                        tt:=cnp1(p);
                        if (a[tt].x=p.x) and (f[a[tt].v,2]=-1) then push(a[tt],a[tt].v,2,f[u,k]+1);
                        dec(tt);
                        if (a[tt].x=p.x) and (f[a[tt].v,3]=-1) then push(a[tt],a[tt].v,3,f[u,k]+1);
                end;
                if (k=2) or (k=3) then
                begin
                        if k=2 then dec(p.y) else inc(p.y);
                        tt:=cnp2(p);
                        if (b[tt].y=p.y) and (f[b[tt].v,1]=-1) then push(b[tt],b[tt].v,1,f[u,k]+1);
                        dec(tt);
                        if (b[tt].y=p.y) and (f[b[tt].v,4]=-1) then push(b[tt],b[tt].v,4,f[u,k]+1);
                end;
        until l>=r;
        res:=oo;
        for i:=1 to m do
                if (f[ch[i].u,ch[i].k]>-1) and (f[ch[i].u,ch[i].k]<res) then res:=f[ch[i].u,ch[i].k];
        write(go,res);
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        input;
        process;
        close(gi);close(go);
end.


