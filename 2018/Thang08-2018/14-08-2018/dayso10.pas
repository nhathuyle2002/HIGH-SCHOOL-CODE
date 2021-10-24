const   ginp='dayso10.inp';
        gout='dayso10.out';
        oo=trunc(1e13);

var     n:longint;
        a:array[0..3010] of int64;
        res:int64;
        mi,sum:array[0..3010,0..3010] of int64;

procedure enter;
var     i:longint;
begin
        readln(n);
        for i:=1 to n do read(a[i]);
end;

function min(x,y:int64):int64;
begin
        if x<y then exit(x) else exit(y);
end;

function max(x,y:int64):int64;
begin
        if x>y then exit(x) else exit(y);
end;

procedure process;
var     i,j:longint;
begin
        res:=-oo;
        for i:=1 to n do
                for j:=n downto i+1 do
                begin
                        sum[i,j]:=sum[i-1,j+1]+a[i]*a[j];
                        res:=max(res,sum[i,j]-mi[i-1,j+1]);
                        mi[i,j]:=min(mi[i-1,j+1],sum[i,j]);
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
