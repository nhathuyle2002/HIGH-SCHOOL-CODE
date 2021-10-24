const   ginp='ss.inp';
        gout='ss.out';
        maxa=50001;
        oo=trunc(1e9)+10;

var     gi,go:text;
        n,nh,m:longint;
        a:array[0..5001] of longint;
        d,t,v,h:array[0..maxa] of longint;
        f:array[0..maxa] of longint;

procedure swap(var x,y:longint);inline;
var     tm:longint;
begin
        tm:=x;x:=y;y:=tm;
end;

procedure downh(i:longint);inline;
var     j:longint;
begin
        j:=i shl 1;
        if j>nh then exit;
        if (j<nh) and (f[h[j]]>f[h[j+1]]) then inc(j);
        if f[h[i]]>f[h[j]] then
        begin
                swap(h[i],h[j]);
                swap(v[h[i]],v[h[j]]);
                downh(j);
        end;
end;

procedure uph(i:longint);inline;
var     j:longint;
begin
        j:=i shr 1;
        if j=0 then exit;
        if f[h[i]]<f[h[j]] then
        begin
                swap(h[i],h[j]);
                swap(v[h[i]],v[h[j]]);
                uph(j);
        end;
end;

function pop:longint;inline;
begin
        pop:=h[1];
        swap(h[1],h[nh]);
        swap(v[h[1]],v[h[nh]]);
        dec(nh);
        downh(1);
end;

procedure push(u:longint);inline;
begin
        if v[u]=0 then
        begin
                inc(nh);
                v[u]:=nh;
                h[nh]:=u;
        end;
        uph(v[u]);
end;

procedure input;
var     i,tm:longint;
        dd:array[0..maxa] of boolean;
begin
        readln(gi,n);
        for i:=1 to n do readln(gi,a[i]);
        fillchar(dd,sizeof(dd),true);
        for i:=2 to n do
        begin
                tm:=a[i] mod a[1];
                if (tm<>0) and (dd[tm]) then
                begin
                        dd[tm]:=false;
                        inc(m);
                        d[m]:=a[i];t[m]:=tm;
                end;
        end;
end;

procedure dijkstra;
var     i,u,vv:longint;
        put:array[0..maxa] of boolean;
begin
        for i:=1 to a[1] do
        begin
                f[i]:=oo;put[i]:=true;
        end;
        f[0]:=0;put[0]:=false;
        push(0);
        repeat
                if nh=0 then exit;
                u:=pop;
                put[u]:=false;
                for i:=1 to m do
                begin
                        {vv:=u-i;
                        if vv<=0 then vv:=vv+a[1];
                        if (put[vv]) and (f[vv]>f[u]+d[i]) then
                        begin
                                f[vv]:=f[u]+d[i];
                                push(vv);
                        end;  }
                        vv:=u+t[i];
                        if vv>a[1] then vv:=vv-a[1];
                        if (put[vv]) and (f[vv]>f[u]+d[i]) then
                        begin
                                f[vv]:=f[u]+d[i];
                                push(vv);
                        end;
                end;
        until false;
end;

procedure output;
var     i,q,x:longint;
begin
        readln(gi,q);
        for i:=1 to q do
        begin
                readln(gi,x);
                if x>=f[x mod a[1]] then writeln(go,'TAK')
                else writeln(go,'NIE');
        end;
end;

begin
        assign(gi,ginp);reset(gi);
        assign(go,gout);rewrite(go);
        input;
        dijkstra;
        output;
        close(gi);close(go);
end.
