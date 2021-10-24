const   ginp='candy.inp';
        gout='candy.out';
        maxn=1000100;

var     gi,go:text;
        n:longint;
        a:array[0..110] of longint;
        snt:array[0..maxn] of boolean;

procedure sangnt;
var     i,j:longint;
begin
        fillchar(snt,sizeof(snt),true);
        snt[1]:=false;
        for i:=2 to trunc(sqrt(maxn)) do
                if snt[i] then
                        for j:=2 to maxn div i do snt[i*j]:=false;
end;

function pt(x,i:longint):longint;
begin
        pt:=0;
        while x mod i=0 do
        begin
                inc(pt);
                x:=x div i;
        end;
end;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n);
        for i:=1 to n do read(gi,a[i]);
end;

procedure output;
var     i,j,sum,tm,cou,ans:longint;
        d:array[0..110] of longint;
begin
        ans:=1;cou:=0;
        for i:=2 to maxn do
        if snt[i] then
        begin
                sum:=0;
                for j:=1 to n do
                begin
                        d[j]:=pt(a[j],i);
                        sum:=sum+d[j];
                end;
                tm:=sum div j;
                if tm>0 then
                begin
                        for j:=1 to n do
                                if d[j]<tm then cou:=cou+tm-d[j];
                        for j:=1 to tm do ans:=ans*i;
                end;
        end;
        write(go,ans,' ',cou);
        close(gi);close(go);
end;

begin
        sangnt;
        input;
        output;
end.
