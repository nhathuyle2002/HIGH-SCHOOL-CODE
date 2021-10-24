const   ginp='ss.inp';
        gout='ss.out';
        vc=1000*3000*10;

var     gi,go:text;
        n,m,nh:longint;
        doc,nag,h,f,sh:array[0..3000*11] of longint;
        d:array[0..3000*11] of boolean;

procedure input;
var     i,j:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,m,n);
        for i:=1 to 2*m do
        begin
                if i mod 2=1 then
                for j:=1 to n do read(gi,doc[n*(i div 2)+j]);
                if i mod 2=0 then
                for j:=1 to n-1 do read(gi,nag[n*(i div 2-1)+j]);
                readln(gi);
        end;
end;

procedure swap(var x,y:longint);
var     tm:longint;
begin
        tm:=x;x:=y;y:=tm;
end;

procedure uph(i:longint);
var     j:longint;
begin
        if i<=1 then exit;
        j:=i div 2;
        if f[h[i]]<f[h[j]] then
        begin
                swap(h[i],h[j]);
                swap(sh[h[i]],sh[h[j]]);
                uph(j);
        end;
end;

procedure downh(i:longint);
var     j:longint;
begin
        j:=i*2;
        if j>nh then exit;
        if (j<nh) and (f[h[j]]>f[h[j+1]]) then inc(j);
        if f[h[i]]>f[h[j]] then
        begin
                swap(h[i],h[j]);
                swap(sh[h[i]],sh[h[j]]);
                downh(j);
        end;
end;

function pop:longint;
begin
        if nh=0 then exit(0);
        pop:=h[1];
        swap(h[1],h[nh]);
        swap(sh[h[1]],sh[h[nh]]);
        dec(nh);
        downh(1);
end;

procedure update(i:longint);
begin
        if sh[i]=0 then
        begin
                inc(nh);
                h[nh]:=i;sh[i]:=nh;
                uph(nh);
        end else uph(sh[i]);
end;

procedure dijkstraheap;
var     i:longint;
begin
        nh:=0;
        fillchar(d,sizeof(d),true);
        for i:=1 to m*n do f[i]:=vc;
        for i:=1 to n do
        begin
                f[i]:=doc[i];
                update(i);
        end;
        repeat
                i:=pop;d[i]:=false;
                if i=m*n then exit;
                if i mod n<>0 then
                if (f[i]+nag[i]<f[i+1]) and (d[i+1]) then
                begin
                        f[i+1]:=f[i]+nag[i];
                        update(i+1);
                end;
                if i mod n<>1 then
                if (f[i]+nag[i-1]<f[i-1]) and (d[i-1]) then
                begin
                        f[i-1]:=f[i]+nag[i-1];
                        update(i-1);
                end;
                if i-n>0 then
                if (f[i]+doc[i]<f[i-n]) and (d[i-n]) then
                begin
                        f[i-n]:=f[i]+doc[i];
                        update(i-n);
                end;
                if i+n<=m*n then
                if (f[i]+doc[i+n]<f[i+n]) and (d[i+n]) then
                begin
                        f[i+n]:=f[i]+doc[i+n];
                        update(i+n);
                end;
        until false;
end;

procedure output;
begin
        write(go,f[m*n]);
        close(gi);close(go);
end;

begin
        input;
        dijkstraheap;
        output;
end.
