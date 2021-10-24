const   ginp='doihinh.inp';
        gout='doihinh.out';
        oo=trunc(1e15);

var     n,k:longint;
        res:int64;
        a:array[0..501,0..501] of int64;

procedure enter;
var     i,j:longint;
begin
        readln(n,k);
        for i:=1 to n do
        begin
                for j:=1 to n do
                begin
                        read(a[i,j]);
                        a[i,j]:=a[i,j-1]+a[i,j];
                end;
                readln;
        end;
end;

function min(x,y:int64):int64;
begin
        if x<y then exit(x) else exit(y);
end;

procedure process;
var     i,j,ii:longint;
        sum:int64;
begin
        res:=oo;
        for i:=k to n do
                for j:=k to n do
                begin
                        sum:=0;
                        for ii:=i-1 downto i-k+1 do sum:=sum+a[ii,j]-a[ii,j-i+ii];
                        for ii:=i downto i-k+1 do sum:=sum-a[ii,j-i+ii-1]+a[ii,j-k];
                        if sum<0 then sum:=-sum;
                        res:=min(res,sum);
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

