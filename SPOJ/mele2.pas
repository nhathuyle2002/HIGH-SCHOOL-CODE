const   ginp='ss.inp';
        gout='ss.out';
        maxa=100001;
        oo=trunc(1e18)+10;

var     gi,go:text;
        n,nh:longint;
        high,res:int64;
        a:array[0..3] of longint;
        v,h:array[0..maxa] of longint;
        f:array[0..maxa] of qword;

procedure swap(var x,y:longint);
var     tm:longint;
begin
        tm:=x;x:=y;y:=tm;
end;

procedure downh(i:longint);
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

procedure uph(i:longint);
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

function pop:longint;
begin
        pop:=h[1];
        swap(h[1],h[nh]);
        swap(v[h[1]],v[h[nh]]);
        dec(nh);
        downh(1);
end;

procedure push(u:longint);
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
var     i,j:longint;
begin
        readln(gi,high);
        for i:=1 to 3 do read(gi,a[i]);
        for i:=1 to 2 do
                for j:=i+1 to 3 do
                        if a[i]>a[j] then swap(a[i],a[j]);
end;

procedure dijkstra;
var     i,u,vv:longint;
        put:array[0..maxa] of boolean;
begin
        for i:=0 to a[1]-1 do
        begin
                f[i]:=oo;put[i]:=true;
        end;
        f[1]:=1;put[1]:=false;
        push(1);
        repeat
                if nh=0 then exit;
                u:=pop;
                put[u]:=false;
                for i:=1 to 3 do
                begin
                        vv:=(u+a[i]) mod a[1];
                        if (put[vv]) and (f[vv]>f[u]+a[i]) then
                        begin
                                f[vv]:=f[u]+a[i];
                                push(vv);
                        end;
                end;
        until false;
end;

procedure output;
var     i:longint;
begin
        res:=0;
        for i:=0 to a[1]-1 do
                if f[i]<=high then
                        res:=res+(high-f[i]) div a[1]+1;
        write(go,res);
end;

begin
        assign(gi,ginp);reset(gi);
        assign(go,gout);rewrite(go);
        input;
        if a[1]=1 then write(go,high) else
        begin
                dijkstra;
                output;
        end;
        close(gi);close(go);
end.
