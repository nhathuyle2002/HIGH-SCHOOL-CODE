const   ginp='chiaqua.inp';
        gout='chiaqua.out';

var     n,maxk:longint;
        res:int64;
        f:array[0..101,0..101,0..101] of int64;
        sum:array[0..101,-1..101] of int64;

procedure main;
var     i,k,s:longint;
begin
        read(n,maxk);
        f[0,0,0]:=1;
        for k:=1 to maxk do
        begin
                fillchar(sum,sizeof(sum),0);
                for s:=0 to n do
                        for i:=0 to n do
                                sum[s,i]:=sum[s,i-1]+f[k-1,s,i];
                for s:=0 to n do
                        for i:=0 to s do
                                f[k,s,i]:=sum[s-i,i];
        end;
        res:=0;
        for i:=1 to n do
                res:=res+f[maxk,n,i];
        write(res);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        main;
        close(input);close(output);
end.
