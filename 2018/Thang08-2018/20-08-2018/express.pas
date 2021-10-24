const   ginp='express.inp';
        gout='express.out';

var     n:longint;
        res,sum:int64;
        a:array[0..1010] of int64;

procedure enter;
var     i:longint;
begin
        readln(n);
        for i:=1 to n do
        begin
                read(a[i]);
                sum:=sum+a[i];
        end;
end;

function max(x,y:int64):int64;
begin
        if x>y then exit(x) else exit(y);
end;

procedure process;
var     i,j:longint;
        tmp:int64;
begin
        res:=-trunc(1e15);
        for i:=1 to n-2 do
        begin
                res:=max(res,sum-a[i]-a[i+1]-a[i+2]+a[i]*a[i+1]*a[i+2]);
                tmp:=sum-a[i]-a[i+1]+a[i]*a[i+1];
                for j:=i+2 to n-1 do
                        res:=max(res,tmp-a[j]-a[j+1]+a[j]*a[j+1]);
        end;
        write(res);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        process;
        close(input);close(output);
end.
