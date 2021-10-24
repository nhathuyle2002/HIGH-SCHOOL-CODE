const   ginp='uocso.inp';
        gout='uocso.out';
        maxn=trunc(sqrt(1e9))+1;

var     gi,go:text;
        a,b,res,cou1,cou2,n:longint;
        nt:array[0..maxn] of longint;

procedure sangnt;
var     i,j:longint;
        d:array[0..maxn] of boolean;
begin
        fillchar(d,sizeof(d),true);
        n:=0;
        for i:=2 to maxn do
                if d[i] then
                begin
                        inc(n);nt[n]:=i;
                        for j:=2 to maxn div i do d[i*j]:=false;
                end;
end;

function pt(x:longint):longint;
var     i,tmp:longint;
begin
        pt:=1;
        for i:=1 to n do
        begin
                if nt[i]>sqrt(x) then break;
                tmp:=1;
                while x mod nt[i]=0 do
                begin
                        inc(tmp);
                        x:=x div nt[i];
                end;
                pt:=pt*tmp;
        end;
        if x>1 then pt:=pt*2;
end;

procedure main;
var     i,tm:longint;
begin
        read(gi,a,b);
        cou1:=0;
        for i:=a to b do
        begin
                tm:=pt(i);
                if tm>cou1 then
                begin
                        res:=i;
                        cou1:=tm;
                        cou2:=1;
                end else
                if tm=cou1 then inc(cou2);
        end;
        write(go,res,' ',cou1,' ',cou2);
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        sangnt;
        main;
        close(gi);close(go);
end.
