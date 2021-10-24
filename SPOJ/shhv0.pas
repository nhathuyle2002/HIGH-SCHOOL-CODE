const   ginp='ss.inp';
        gout='ss.out';

var     gi,go:text;
        n,p,re:longint;
        a,f,b:array[0..12] of longint;
        d:array[0..12] of boolean;

procedure input;
begin
        n:=0;
        while not seekeoln(gi) do
        begin
                inc(n);
                read(gi,a[n]);
        end;
        readln(gi);read(gi,p);
end;

procedure process;
var     i,j,tm:longint;
begin
        f[0]:=1;
        for i:=1 to n do f[i]:=f[i-1]*i;
        re:=0;
        fillchar(d,sizeof(d),true);
        for i:=1 to n do
        begin
                tm:=0;
                for j:=1 to a[i]-1 do
                        if d[j] then inc(tm);
                re:=re+f[n-i]*tm;
                d[a[i]]:=false;
        end;
        writeln(go,re+1);
        fillchar(d,sizeof(d),true);
        for i:=1 to n do
        begin
                for j:=1 to n do
                        if d[j] then
                                if p>f[n-i] then p:=p-f[n-i] else break;
                d[j]:=false;b[i]:=j;
        end;
        for i:=1 to n do write(go,b[i],' ');
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        input;
        process;
        close(gi);close(go);
end.
