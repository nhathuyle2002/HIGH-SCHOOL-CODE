const   ginp='prizes.inp';
        gout='prizes.out';

var     gi,go:text;
        n,k,m:longint;
        ans:int64;
        a,sum,ma1,ma2:array[-100001..200001] of int64;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n,k);
        for i:=1 to n do
        begin
                read(gi,a[i]);
                a[i]:=a[i-1]+a[i];
        end;
end;

function max(x,y:int64):int64;
begin
        if x>y then exit(x) else exit(y);
end;

procedure create;
var     i:longint;
begin
        for i:=k to n do
        begin
                inc(m);
                sum[m]:=a[i]-a[i-k];
        end;
        for i:=1 to m do ma1[i]:=max(ma1[i-1],sum[i]);
        for i:=m downto 1 do ma2[i]:=max(ma2[i+1],sum[i]);
end;

procedure process;
var     i:longint;
        tmp:int64;
begin
        ans:=ma1[m];
        for i:=1 to m do
        begin
                tmp:=max(ma1[i-k],ma2[i+k]);
                if (tmp<=sum[i]) and (sum[i]<ans) then ans:=sum[i];
        end;
end;

procedure output;
begin
        write(go,ans);
        close(gi);close(go);
end;

begin
        input;
        create;
        process;
        output;
end.































