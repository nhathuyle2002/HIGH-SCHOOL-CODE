const   ginp='ss.inp';
        gout='ss.out';
        maxn=100010;
        mm=trunc(sqrt(maxn));

var     gi,go:text;
        l,r,nnt,res:longint;
        nt:array[0..mm] of longint;

procedure sangnt;
var     i,j:longint;
        dd:array[0..mm] of boolean;
begin
        nnt:=0;
        fillchar(dd,sizeof(dd),true);
        for i:=2 to mm do
                if dd[i] then
                begin
                        inc(nnt);nt[nnt]:=i;
                        for j:=2 to mm div i do dd[i*j]:=false;
                end;
end;

function ptich(x:longint):longint;
var     i,sum,tm,tmp:longint;
begin
        sum:=1;i:=1;
        while (nt[i]<=sqrt(x)) and (i<=nnt) do
        begin
                tm:=1;tmp:=1;
                while x mod nt[i]=0 do
                begin
                        tmp:=tmp*nt[i];
                        tm:=tm+tmp;
                        x:=x div nt[i];
                end;
                sum:=sum*tm;
                inc(i);
        end;
        if x>1 then sum:=sum*(x+1);
        exit(sum);
end;

procedure main;
var     i:longint;
begin
        read(gi,l,r);
        res:=0;
        for i:=l to r do
                if ptich(i)>2*i then inc(res);
        write(go,res);
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        sangnt;
        main;
        close(gi);close(go);
end.














