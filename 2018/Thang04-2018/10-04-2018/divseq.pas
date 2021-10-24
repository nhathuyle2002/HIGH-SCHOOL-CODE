const   ginp='divseq.inp';
        gout='divseq.out';

var     gi,go:text;
        n,r:longint;
        sl,a,f:array[0..100010] of longint;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n);
        for i:=1 to n do read(gi,a[i]);
end;

procedure process;
var     i,d,c,m:longint;
begin
        f[1]:=a[1];r:=1;
        for i:=2 to n do
                 if a[i]<f[r] then
                 begin
                        inc(r);
                        f[r]:=a[i];
                 end
                 else
                 begin
                        d:=1;c:=r;
                        while d<c do
                        begin
                                m:=(d+c) div 2;
                                if f[m]>a[i] then d:=m+1 else c:=m;
                        end;
                        f[d]:=a[i];
                 end;
end;

procedure output;
begin
        write(go,r);
        close(gi);close(go);
end;

begin
        input;
        process;
        output;
end.







