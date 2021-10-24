const   ginp='bonus.inp';
        gout='bonus.out';

var     gi,go:text;
        m,n,ok1,ok2,q:longint;
        f1:array[0..1001,0..10001] of int64;
        f2:array[0..11,0..1000001] of int64;
        f3:array[0..101,0..100001] of int64;

procedure swap(var x,y:longint);
var     tmp:longint;
begin
        tmp:=x;
        x:=y;
        y:=tmp;
end;

procedure input;
var     i,j:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,m,n,q);
        if m>n then
        begin
                swap(m,n);
                ok1:=1;
        end else ok1:=0;
        if n>100000 then
        begin
                ok2:=2;
                if ok1=0 then
                for i:=1 to m do
                begin
                        for j:=1 to n do
                        begin
                                read(gi,f2[i,j]);
                                f2[i,j]:=f2[i-1,j]+f2[i,j-1]-f2[i-1,j-1]+f2[i,j];
                        end;
                        readln(gi);
                end
                else
                for j:=1 to n do
                begin
                        for i:=1 to m do
                        begin
                                read(gi,f2[i,j]);
                                f2[i,j]:=f2[i-1,j]+f2[i,j-1]-f2[i-1,j-1]+f2[i,j];
                        end;
                        readln(gi);
                end
        end
        else if n>10000 then
        begin
                ok2:=3;
                if ok1=0 then
                for i:=1 to m do
                begin
                        for j:=1 to n do
                        begin
                                read(gi,f3[i,j]);
                                f3[i,j]:=f3[i-1,j]+f3[i,j-1]-f3[i-1,j-1]+f3[i,j];
                        end;
                        readln(gi);
                end
                else
                for j:=1 to n do
                begin
                        for i:=1 to m do
                        begin
                                read(gi,f3[i,j]);
                                f3[i,j]:=f3[i-1,j]+f3[i,j-1]-f3[i-1,j-1]+f3[i,j];
                        end;
                        readln(gi);
                end
        end else
        begin
                ok2:=1;
                if ok1=0 then
                for i:=1 to m do
                begin
                        for j:=1 to n do
                        begin
                                read(gi,f1[i,j]);
                                f1[i,j]:=f1[i-1,j]+f1[i,j-1]-f1[i-1,j-1]+f1[i,j];
                        end;
                        readln(gi);
                end
                else
                for j:=1 to n do
                begin
                        for i:=1 to m do
                        begin
                                read(gi,f1[i,j]);
                                f1[i,j]:=f1[i-1,j]+f1[i,j-1]-f1[i-1,j-1]+f1[i,j];
                        end;
                        readln(gi);
                end
        end;
end;

procedure output;
var     k,i1,j1,i2,j2:longint;
        tmp:int64;
begin
        for k:=1 to q do
        begin
                readln(gi,i1,j1,i2,j2);
                if ok1=1 then
                begin
                        swap(i1,j1);
                        swap(i2,j2);
                end;
                if ok2=1 then tmp:=f1[i2,j2]-f1[i2,j1-1]-f1[i1-1,j2]+f1[i1-1,j1-1]
                else if ok2=2 then tmp:=f2[i2,j2]-f2[i2,j1-1]-f2[i1-1,j2]+f2[i1-1,j1-1]
                else tmp:=f3[i2,j2]-f3[i2,j1-1]-f3[i1-1,j2]+f3[i1-1,j1-1];
                writeln(go,tmp);
        end;
        close(gi);close(go);
end;

begin
        input;
        output;
end.
