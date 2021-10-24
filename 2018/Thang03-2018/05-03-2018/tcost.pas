const   ginp='tcost.inp';
        gout='tcost.out';

var     gi,go:text;
        n,m:longint;
        w:array[0..1000] of int64;
        f,t:array[0..1000,0..1000] of int64;

procedure input;
var     i,j:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n,m);
        for i:=1 to n do read(gi,w[i]);
        readln(gi);
        for i:=1 to n do
        begin
                for j:=1 to n do
                begin
                        read(gi,f[i,j]);
                        if f[i,j]=-1 then f[i,j]:=1000000000000000000;
                        t[i,j]:=j;
                end;
                readln(gi);
        end;
end;

procedure floyd;
var     i,j,k:longint;
begin
        for k:=1 to n do
                for i:=1 to n do
                        for j:=1 to n do
                        if (k<>i) and (k<>j) then
                                if f[i,j]>f[i,k]+f[k,j]+w[k] then
                                begin
                                        f[i,j]:=f[i,k]+f[k,j]+w[k];
                                        t[i,j]:=t[i,k];
                                end;
end;

procedure process;
var     i,j,d,c,l,r:longint;
begin
        for i:=1 to m do
        begin
                readln(gi,d,c);
                l:=d;r:=c;
                write(go,d,' ');
                repeat
                        l:=t[l,r];
                        write(go,l,' ');
                until t[l,r]=c;
                write(go,c);
                writeln(go);
                writeln(go,f[d,c]);
        end;
end;

procedure output;
begin
        close(gi);close(go);
end;

begin
        input;
        floyd;
        process;
        output;
end.






