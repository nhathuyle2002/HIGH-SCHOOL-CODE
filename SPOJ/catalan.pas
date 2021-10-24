const   ginp='ss.inp';
        gout='ss.out';

var     gi,go:text;
        n:longint;
        p,re:int64;
        a,b:array[0..31] of longint;
        f:array[0..16,-1..16] of int64;

procedure input;
var     i:longint;
begin
        readln(gi,n);
        for i:=1 to 2*n+1 do read(gi,a[i]);readln(gi);
        read(gi,p);
end;

procedure process;
var     i,j,u,v:longint;
begin
        f[1,0]:=1;
        for i:=2 to n+1 do
                for j:=0 to i-1 do f[i,j]:=f[i-1,j]+f[i,j-1];
        re:=0;u:=n+1;v:=n+1;
        for i:=2 to 2*n+1 do
                begin
                        if a[i]=a[i-1]+1 then
                        begin
                                dec(v);
                                re:=re+f[u-1,v];
                        end
                        else dec(u);
                end;
        inc(re);
        u:=n+1;v:=n;
        b[1]:=0;
        for i:=2 to 2*n+1 do
                if p>f[u-1,v] then
                begin
                        p:=p-f[u-1,v];
                        b[i]:=b[i-1]+1;
                        dec(v);
                end else
                begin
                        b[i]:=b[i-1]-1;
                        dec(u);
                end;
end;

procedure output;
var     i:longint;
begin
        writeln(go,re);
        for i:=1 to 2*n+1 do write(go,b[i],' ');
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        input;
        process;
        output;
        close(gi);close(go);
end.
