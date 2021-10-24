const   ginp='seqgame.inp';
        gout='seqgame.out';

var     m,n:longint;
        sum1,sum2,a1,a2:array[0..2001] of int64;
        f:array[0..2001,0..2001] of int64;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,m,n);
        for i:=1 to m do read(gi,a1[n-i+1]);
        for i:=1 to m do sum1[i]:=sum1[i-1]+a1[i];
        readln(gi);
        for i:=1 to n do read(go,a2[n-i+1]);
        for i:=1 to n do sum2[i]:=sum2[i-1]+a2[i];
end;

procedure process;
var     i,j:longint;
begin
        for i:=1 to m do
                for j:=1 to n do
                begin
                        f[i,j]:=(sum1[m]-sum1[i])*(sum2[n]-sum2[j]);


end;

procedure output;
begin
        close(gi);close(go);
end;

begin
        input;
        process;
        output;
end.















