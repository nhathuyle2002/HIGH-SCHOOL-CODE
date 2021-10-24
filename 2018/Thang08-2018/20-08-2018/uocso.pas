const   ginp='uocso.inp';
        gout='uocso.out';
        maxn=trunc(sqrt(1000000001));

var     a,b,n,gmin,cmin,cou:longint;
        nt:array[0..maxn] of longint;

procedure create;
var     i,j:longint;
        d:array[0..maxn] of boolean;
begin
        fillchar(d,sizeof(d),true);
        n:=0;
        for i:=2 to maxn do
                if d[i] then
                begin
                        inc(n);nt[n]:=i;
                        for j:=i to maxn div i do d[i*j]:=false;
                end;
end;

function ccl(x:longint):longint;
var     i,cou:longint;
begin
        ccl:=1;
        for i:=1 to n do
                if nt[i]>sqrt(x) then break else
                begin
                        cou:=0;
                        while x mod nt[i]=0 do
                        begin
                                inc(cou);
                                x:=x div nt[i];
                        end;
                        ccl:=ccl*(cou+1);
                end;
        if x>1 then ccl:=ccl*2;
end;

procedure process;
var     i,tmp:longint;
begin
        read(a,b);
        gmin:=0;cmin:=0;cou:=0;
        for i:=a to b do
        begin
                tmp:=ccl(i);
                if tmp=cmin then inc(cou) else
                if tmp>cmin then
                begin
                        gmin:=i;
                        cmin:=tmp;
                        cou:=1;
                end;
        end;
        write(gmin,' ',cmin,' ',cou);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        create;
        process;
        close(input);close(output);
end.
