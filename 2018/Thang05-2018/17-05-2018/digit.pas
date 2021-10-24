const   ginp='digit.inp';
        gout='digit.out';
        maxn=100001;

type    bignum=array[1..maxn] of longint;

var     gi,go:text;
        k:int64;
        sl:longint;
        a,b,c:bignum;

procedure input;
var     i,tm:longint;
        s:ansistring;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,s);read(gi,k);
        sl:=length(s);
        tm:=maxn;
        for i:=length(s) downto 1 do
        begin
                if (s[i]>='0') and (s[i]<='9') then a[tm]:=ord(s[i])-48
                else if (s[i]>='a') and (s[i]<='z') then a[tm]:=ord(s[i])-87;
                dec(tm);
        end;
end;

procedure chuyendoi(x:int64);
var     i:longint;
begin
        for i:=maxn downto 1 do
        begin
                c[i]:=x mod 36;
                x:=x div 36;
        end;
end;

function cong(x,y:bignum):bignum;
var     i,nho,sum:longint;
begin
        nho:=0;
        for i:=maxn downto 1 do
        begin
                sum:=x[i]+y[i]+nho;
                nho:=sum div 36;
                cong[i]:=sum mod 36;
        end;
end;

function tru(x,y:bignum):int64;
var     i,nho,sum,tm:longint;
        tbn:bignum;
begin
        nho:=0;
        for i:=maxn downto 1 do
        begin
                sum:=y[i]-x[i]-nho;
                if sum<0 then
                begin
                        sum:=sum+36;
                        nho:=1;
                end else nho:=0;
                tbn[i]:=sum mod 36;
        end;
        tru:=0;tm:=1;
        while tbn[tm]=0 do inc(tm);
        for i:=tm to maxn do tru:=tru*36+tbn[i];
end;

function check:boolean;
var     i,tm:longint;
begin
        tm:=1;
        while b[tm]=0 do inc(tm);
        if maxn-tm+1>sl then
        begin
                check:=false;
                for i:=1 to maxn do b[i]:=0;
                b[maxn-sl]:=1;
                k:=k-tru(a,b)*sl;
                for i:=maxn downto 1 do a[i]:=0;
                a[maxn-sl]:=1;
                inc(sl);
        end
        else check:=true;
end;

procedure xuat(x:longint);
begin
        if (x>=0) and (x<=9) then write(go,x)
        else write(go,chr(x+87));
end;

procedure output;
var     i:longint;
        tm:int64;
begin
        repeat
                if k mod sl<>0 then tm:=1 else tm:=0;
                tm:=k div sl+tm-1;
                chuyendoi(tm);
                b:=cong(a,c);
        until check;
        if k mod sl=0 then xuat(b[maxn]) else xuat(b[maxn-sl+k mod sl]);
        close(gi);close(go);
end;

begin
        input;
        output;
end.
