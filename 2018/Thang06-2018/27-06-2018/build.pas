const   fi='BUILD.INP';
        fo='BUILD.OUT';
        oo=trunc(1e9);
        mn=60000;
var     cn,dd:array[0..mn] of boolean;
        c:array[0..5] of longint;
        m,n,k,now,nHeap,ll,i:longint;
        link,ke,w:array[-mn..mn] of longint;
        head,id,h:array[0..mn] of longint;
        d:array[0..mn,0..5] of longint;
        state:array[0..120,0..5] of longint;
        xt:array[0..5] of longint;
        avail:array[0..5] of boolean;

procedure swap(var a,b:longint);
var t:longint;
begin
        t:=a; a:=b; b:=t;
end;

procedure up(i:longint);
begin
        if i=1 then exit;
        if d[h[i shr 1],now]<=d[h[i],now] then exit;
        swap(id[h[i shr 1]],id[h[i]]);
        swap(h[i],h[i shr 1]);
        up(i shr 1);
end;
procedure down(i:longint);
var j:longint;
begin
        j:=i*2;
        if j>nHeap then exit;
        if (j<nHeap) and (d[h[j+1],now]<d[h[j],now]) then inc(j);
        if d[h[i],now]<=d[h[j],now] then exit;
        swap(id[h[i]],id[h[j]]);
        swap(h[i],h[j]);
        down(j);
end;

procedure re(u:longint);
begin
        if id[u]=0 then
        begin
                inc(nHeap);
                h[nHeap]:=u;
                id[u]:=nHeap;
        end;
        up(id[u]);
end;

function pop:longint;
begin
        pop:=h[1];
        h[1]:=h[nHeap];
        id[h[1]]:=1;
        dec(nHeap);
        down(1);
end;

procedure dijkstra;
var i,j,p,u,v:longint;
begin
        for p:=1 to k do
        begin
                now:=p;
                for i:=0 to n do
                begin
                        d[i,p]:=oo;
                        dd[i]:=true;
                        id[i]:=0;
                end;
                d[c[p],p]:=0;
                nHeap:=0;
                re(c[p]);
                repeat
                        u:=pop;  dd[u]:=false;
                        i:=head[u];
                        while i<>0 do
                        begin
                                v:=ke[i];
                                if (dd[v]) and (d[v,p]>d[u,p]+w[i]) then
                                begin
                                        d[v,p]:=d[u,p]+w[i];
                                        re(v);
                                end;
                                i:=link[i];
                        end;
                until nHeap=0;

        end;
end;

procedure gen(i:longint);
var j:longint;
begin
        if i=k+1 then
        begin
                inc(ll);
                state[ll]:=xt;
        end;
        for j:=1 to k do if avail[j] then
        begin
                avail[j]:=false;
                xt[i]:=j;
                gen(i+1);
                avail[j]:=true;
        end;
end;

procedure main;
var i,sum,j,g,kq:longint;
begin
        dijkstra;
        ll:=0; fillchar(avail,sizeof(avail),true);
        gen(1);
        kq:=oo;
        for i:=1 to n do if not cn[i] then
        begin
                for j:=1 to ll do
                begin
                        sum:=d[i,state[j,1]]+d[i,state[j,k]];
                        for g:=2 to k do sum:=sum+d[c[state[j,g-1]],state[j,g]];
                        if sum<kq then kq:=sum;
                end;
        end;
        write(kq);
end;

begin
        assign(input,fi);  assign(output,fo);
        reset(input);      rewrite(output);
        readln(n,m,k);
        fillchar(cn,sizeof(cn),false);
        for i:=1 to k do begin readln(c[i]); cn[c[i]]:=true; end;
        for i:=1 to m do
        begin
                readln(ke[-i],ke[i],w[i]);
                link[i]:=head[ke[-i]];
                head[ke[-i]]:=i;
                link[-i]:=head[ke[i]];
                head[ke[i]]:=-i;
                w[-i]:=w[i];
        end;
        main;
        close(input);      close(output);
end.
