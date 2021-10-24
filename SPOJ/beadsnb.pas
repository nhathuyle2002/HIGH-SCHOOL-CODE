const   ginp='ss.inp';
        gout='ss.out';

var     gi,go:text;
        n,rt,rg,res:longint;
        a,dt,dg:array[0..100010] of longint;

procedure input;
var     i:longint;
begin
        readln(gi,n);
        for i:=1 to n do read(gi,a[i]);
end;

procedure process;
var     i,g1,g2,d,m,c:longint;
begin
        dt[0]:=0;a[0]:=0;
        dg[0]:=n+1;a[n+1]:=maxlongint;
        for i:=n downto 1 do
        begin
                if a[i]>a[dt[rt]] then
                begin
                        inc(rt);dt[rt]:=i;
                        g1:=rt;
                end else
                begin
                        d:=1;c:=rt;
                        while d<>c do
                        begin
                                m:=(d+c) shr 1;
                                if a[dt[m]]<a[i] then d:=m+1
                                else c:=m;
                        end;
                        g1:=d;
                        if a[dt[d]]>a[i] then dt[d]:=i;
                end;
                if a[i]<a[dg[rg]] then
                begin
                        inc(rg);dg[rg]:=i;
                        g2:=rg;
                end else
                begin
                        d:=1;c:=rg;
                        while d<>c do
                        begin
                                m:=(d+c) shr 1;
                                if a[dg[m]]>a[i] then d:=m+1
                                else c:=m;
                        end;
                        g2:=d;
                        if a[dg[d]]<a[i] then dg[d]:=i;
                end;
                if g1+g2-1>res then res:=g1+g2-1;
        end;
        write(go,res);
end;

begin
        assign(gi,ginp);reset(gi);
        assign(go,gout);rewrite(go);
        input;
        process;
        close(gi);close(go);
end.
