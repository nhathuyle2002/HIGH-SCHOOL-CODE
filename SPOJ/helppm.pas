const   ginp='ss.inp';
        gout='ss.out';

var     gi,go:text;
        m,n,shcn:longint;
        x1,x2,y1,y2:longint;
        k:int64;
        a,f:array[0..501,0..501] of int64;

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
                        read(gi,a[i,j]);
                        f[i,j]:=a[i,j]+f[i-1,j]+f[i,j-1]-f[i-1,j-1];
                end;
                readln(gi);
        end;
end;

procedure process;
var     h1,h2,c1,c2:longint;
begin
        shcn:=maxlongint;
        for h1:=1 to m do
                for h2:=h1 to m do
                begin
                        c1:=1;c2:=1;
                        repeat
                                if f[h2,c2]-f[h2,c1-1]-f[h1-1,c2]+f[h1-1,c1-1]>=k then
                                begin
                                        if (h2-h1+1)*(c2-c1+1)<shcn then
                                        begin
                                                x1:=h1;x2:=h2;y1:=c1;y2:=c2;
                                                shcn:=(x2-x1+1)*(y2-y1+1);
                                        end;
                                        inc(c1);
                                end
                                else inc(c2);
                        until (c1>c2) or (c2>n);
                end;
end;

procedure output;
begin
        if shcn=maxlongint then write(go,-1) else
        begin
                writeln(go,shcn);
                write(go,x1,' ',y1,' ',x2,' ',y2);
        end;
        close(gi);close(go);
end;

begin
        input;
        process;
        output;
end.








