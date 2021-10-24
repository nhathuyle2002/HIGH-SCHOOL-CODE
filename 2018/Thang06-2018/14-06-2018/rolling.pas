const   ginp='rolling.inp';
        gout='rolling.out';

var     gi,go:text;
        m,n:longint;
        res:int64;
        a,b:array[1..6] of longint;

procedure swap(var x,y:longint);
var     tm:longint;
begin
        tm:=x;x:=y;y:=tm;
end;

procedure main;
var     i,tm,j:longint;
begin
        read(gi,m,n);
        res:=0;
        a[1]:=6;a[2]:=4;a[3]:=1;a[4]:=3;a[5]:=2;a[6]:=5;
        for i:=1 to m do
        begin
                res:=(a[1]+a[2]+a[3]+a[4])*(n div 4)+res;
                tm:=(n-1) mod 4;b:=a;
                if tm<>3 then for j:=1 to tm+1 do inc(res,a[j]);
                for j:=1 to 4-tm do a[j]:=b[j+tm];
                for j:=4-tm+1 to 4 do a[j]:=b[j-4+tm];
                tm:=a[1];a[1]:=a[6];a[6]:=a[3];a[3]:=a[5];a[5]:=tm;
                swap(a[2],a[4]);
        end;
        write(go,res);
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        main;
        close(gi);close(go);
end.