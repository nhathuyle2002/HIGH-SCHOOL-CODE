const   ginp='flower.inp';
        gout='flower.out';

var     gi,go:text;
        n,l:longint;
        ans:real;
        a,c:array[0..1001] of longint;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n,l);
        for i:=1 to n do read(gi,a[i]);
        readln(gi);
        for i:=1 to n do read(gi,c[i]);
end;

procedure swap(var x,y:longint);
var     tmp:longint;
begin
        tmp:=x;
        x:=y;
        y:=tmp;
end;

procedure create;
var     i,j:longint;
begin
        for i:=1 to n-1 do
                for j:=i+1 to n do
                        if (c[i]/a[i])>(c[j]/a[j]) then
                        begin
                                swap(a[i],a[j]);
                                swap(c[i],c[j]);
                        end;
end;

procedure process;
var     i:longint;
        sum1,sum2,sl1,sl2:int64;
begin
        sum1:=0;sum2:=0;sl1:=0;sl2:=0;
        if l<=n div 2 then
        begin
                for i:=1 to l do
                begin
                        sum1:=sum1+c[i];
                        sl1:=sl1+a[i];
                end;
                for i:=l+1 to n do
                begin
                        sum2:=sum2+c[i];
                        sl2:=sl2+a[i];
                end;
        end
        else begin
                for i:=1 to n-l do
                begin
                        sum1:=sum1+c[i];
                        sl1:=sl1+a[i];
                end;
                for i:=n-l+1 to n do
                begin
                        sum2:=sum2+c[i];
                        sl2:=sl2+a[i];
                end;
        end;
        ans:=(sum1*sum2)/(sl1*sl2);
end;

procedure output;
begin
        write(go,ans:0:3);
        close(gi);close(go);
end;

begin
        input;
        create;
        process;
        output;
end.










