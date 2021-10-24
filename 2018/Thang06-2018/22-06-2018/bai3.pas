const   ginp='bai3.inp';
        gout='bai3.out';

var     gi,go:text;
        n,m:longint;
        a,b,d:array[0..1001] of longint;
        f,t:array[0..100001] of longint;

procedure input;
var     i:longint;
begin
        readln(gi,n,m);
        for i:=1 to n do readln(gi,a[i],b[i]);
end;

procedure main;
var     i,j,vr:longint;
begin
        vr:=0;f[0]:=0;
        for j:=1 to m do
        begin
                for i:=1 to n do
                        if j-a[i]>=0 then
                        if f[j]<f[j-a[i]]+b[i] then
                        begin
                                t[j]:=i;
                                f[j]:=f[j-a[i]]+b[i];
                        end;
                if f[vr]<f[j] then vr:=j;
        end;
        writeln(go,f[vr]);
        while vr>0 do
        begin
                inc(d[t[vr]]);
                vr:=vr-a[t[vr]];
        end;
        for i:=1 to n do writeln(go,d[i]);
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        input;
        main;
        close(gi);close(go);
end.