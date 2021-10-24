const   ginp='ctimso.inp';
        gout='ctimso.out';
        oo=trunc(1e10);

var     n,m,res:int64;
        k:longint;
        d:array[0..100,1..2] of longint;

function ccl(x:longint):int64;
var     i:longint;
        xx:int64;
begin
        ccl:=0;xx:=1;
        for i:=1 to 32 do
        begin
                xx:=xx*x;
                if xx>n then break;
                ccl:=ccl+n div xx;
        end;
end;

procedure process;
var     i:longint;
        tmp:int64;
begin
        read(n,m);
        i:=2;
        while i<=sqrt(m) do
        begin
                if m mod i=0 then
                begin
                        inc(k);
                        d[k,1]:=i;d[k,2]:=1;
                        m:=m div i;
                end;
                while m mod i=0 do
                begin
                        inc(d[k,2]);
                        m:=m div i;
                end;
                inc(i);
        end;
        if m>1 then
        begin
                inc(k);
                d[k,1]:=m;d[k,2]:=1;
        end;
        res:=oo;
        for i:=1 to k do
        begin
                tmp:=ccl(d[i,1]);
                if tmp div d[i,2]<res then res:=tmp div d[i,2];
        end;
        write(res);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        process;
        close(input);close(output);
end.
