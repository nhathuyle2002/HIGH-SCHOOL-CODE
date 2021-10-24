type    maxn=180010;
        bignum=array[0..maxn] of longint;

const   ginp='ps3.inp';
        gout='ps3.out';

var     m:longint;
        a:bignum;

operator / (x:bignum;k:longint) z:bignum;
var     i,sum:longint;
begin
        sum:=0;
        for i:=1 to maxn do
        begin
                sum:=sum*10+x[i];
                z[i]:=(sum div k) mod 10;
                sum:=sum mod k+sum div 10;
        end;
end;

operator * (x:bignum;k:longint) z:bignum;
var     i,sum:longint;
begin
        sum:=0;
        for i:=maxn downto 1 do
        begin
                sum:=sum*+x[i];
                z[i]:=sum
end;

procedure main;
var     i:longint;
        s:ansitring;
begin
        read(s);
        for i:=1 to length(s) do
                if s[i]=' ' then break else a[maxn-i+1]:=ord(s[i])-48;
        val(copy(s,i+1,length(s)-i),m);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        main;
        close(input);close(output);
end.