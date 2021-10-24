const   ginp='is.inp';
        gout='is.out';

var     gi,go:text;
        n,vt:longint;
        a,f,w,trace:array[0..100001] of int64;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n);
        for i:=1 to n do read(gi,a[i]);
        readln(gi);
        for i:=1 to n do read(gi,w[i]);
end;

procedure process;
var     i,j:longint;
begin
        fillchar(f,sizeof(f),0);
        vt:=0;
        for i:=1 to n do
        begin
                for j:=i-1 downto 0 do
                        if (a[j]<a[i]) and (f[i]<f[j]+w[i]) then
                        begin
                                trace[i]:=j;
                                f[i]:=f[j]+w[i];
                        end;
                if f[i]>f[vt] then vt:=i;
        end;
end;

procedure output;
var     i,dem:longint;
        xuat:array[0..100001] of longint;
begin
        dem:=0;
        repeat
                inc(dem);
                xuat[dem]:=vt;
                vt:=trace[vt];
        until vt=0;
        writeln(go,dem);
        for i:=dem downto 1 do write(go,xuat[i],' ');
        close(gi);close(go);
end;

begin
        input;
        process;
        output;
end.














