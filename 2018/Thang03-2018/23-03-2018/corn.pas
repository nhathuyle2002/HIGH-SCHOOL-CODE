const   ginp='corn.inp';
        gout='corn.out';

var     gi,go:text;
        m,n,i1,j1,i2,j2:longint;
        k,smin:int64;
        f:array[0..501,0..501] of int64;

procedure input;
var     i,j:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,m,n,k);
        for i:=1 to m do
        begin
                for j:=1 to n do
                begin
                        read(gi,f[i,j]);
                        f[i,j]:=f[i-1,j]+f[i,j-1]-f[i-1,j-1]+f[i,j];
                end;
                readln(gi);
        end;
end;

procedure process;
var     i,j,h1,h2:longint;
        sum,tmp:int64;
begin
        smin:=maxlongint;
        if f[m,n]<k then exit;
        for i:=1 to n do
                for j:=i to n do
                begin
                        h1:=1;h2:=1;
                        repeat
                                sum:=f[h2,j]-f[h1-1,j]-f[h2,i-1]+f[h1-1,i-1];
                                if sum>=k then
                                begin
                                        tmp:=(j-i+1)*(h2-h1+1);
                                        if tmp<smin then
                                        begin
                                                smin:=tmp;
                                                i1:=h1;j1:=i;i2:=h2;j2:=j;
                                        end;
                                        inc(h1);
                                end
                                else inc(h2);
                        until (h2>m);
                end;
end;

procedure output;
begin
        if smin=maxlongint then write(go,-1)
        else
        begin
                writeln(go,smin);
                write(go,i1,' ',j1,' ',i2,' ',j2);
        end;
        close(gi);close(go);
end;

begin
        input;
        process;
        output;
end.








