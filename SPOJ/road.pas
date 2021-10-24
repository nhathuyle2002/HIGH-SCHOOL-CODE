const   ginp='ss.inp';
        gout='ss.out';
        vc=trunc(1e9);

type    edge=record a,b:longint;end;

var     gi,go:text;
        n,m,nh,maxt,ans:longint;
        x,y,w,t,link:array[0..10001] of longint;
        head:array[0..101] of longint;
        put:array[0..101,0..10001] of boolean;
        d,vt:array[0..101,0..10001] of longint;
        h:array[0..1000001] of edge;

procedure add(i,u,v,c,p:longint);
begin
        x[i]:=u;y[i]:=v;w[i]:=c;t[i]:=p;
        link[i]:=head[u];head[u]:=i;
end;

procedure input;
var     i,u,v,c,p:longint;
begin
        fillchar(link,sizeof(link),0);
        fillchar(head,sizeof(head),0);
        readln(gi,maxt);
        readln(gi,n);
        readln(gi,m);
        for i:=1 to m do
        begin
                readln(gi,u,v,c,p);
                add(i,u,v,c,p);
        end;
end;

procedure swap1(var xx,yy:edge);
var     tm:edge;
begin
        tm:=xx;xx:=yy;yy:=tm;
end;

procedure swap2(var xx,yy:longint);
var     tm:longint;
begin
        tm:=xx;xx:=yy;yy:=tm;
end;

procedure uph(i:longint);
var     j:longint;
begin
        if i<=1 then exit;
        j:=i div 2;
        if d[h[i].a,h[i].b]<d[h[j].a,h[j].b] then
        begin
                swap1(h[i],h[j]);
                swap2(vt[h[i].a,h[i].b],vt[h[j].a,h[j].b]);
                uph(j);
        end;
end;

procedure downh(i:longint);
var     j:longint;
begin
        j:=i*2;
        if j>nh then exit;
        if (j<nh) and (d[h[j+1].a,h[j+1].b]<d[h[j].a,h[j].b]) then inc(j);
        if d[h[j].a,h[j].b]<d[h[i].a,h[j].b] then
        begin
                swap1(h[i],h[j]);
                swap2(vt[h[i].a,h[i].b],vt[h[j].a,h[j].b]);
                downh(j);
        end;
end;

procedure push(i,j:longint);
begin
        if vt[i,j]=0 then
        begin
                inc(nh);
                vt[i,j]:=nh;
                h[nh].a:=i;
                h[nh].b:=j;
                uph(nh);
        end else uph(nh);
end;

function pop:edge;
begin
        pop:=h[1];
        swap1(h[1],h[nh]);
        swap2(vt[h[1].a,h[1].b],vt[h[nh].a,h[nh].b]);
        dec(nh);
        downh(1);
end;

procedure dijkstra;
var     i,j:longint;
        u,v:edge;
begin
        fillchar(put,sizeof(put),true);
        fillchar(vt,sizeof(vt),0);
        for i:=1 to n do
                for j:=0 to maxt do d[i,j]:=vc;
        d[1,maxt]:=0;push(1,maxt);
        repeat
                u:=pop;
                i:=head[u.a];
                while i<>0 do
                begin
                        v.a:=y[i];
                        v.b:=u.b-t[i];
                        if v.b>=0 then
                        if (put[v.a,v.b]) and (d[v.a,v.b]>d[u.a,u.b]+w[i]) then
                        begin
                                d[v.a,v.b]:=d[u.a,u.b]+w[i];
                                push(v.a,v.b);
                        end;
                        i:=link[i];
                end;
        until nh=0;
        ans:=vc;
        for i:=0 to maxt do
                if d[n,i]<ans then ans:=d[n,i];
        if ans=vc then ans:=-1;
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
                dijkstra;
                writeln(go,ans);
        end;
        close(gi);close(go);
end;

begin
        main;
end.
