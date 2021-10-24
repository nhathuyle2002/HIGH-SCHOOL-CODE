const   ginp='lock.inp';
        gout='lock.out';

var     gi,go:text;
        n,k,bd:longint;
        a,b,c:array[0..301] of longint;

function kc(x,y:longint):longint;
begin
        if x<=y then exit(y-x);
        exit(y+k+1-x);
end;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n,k);
        for i:=1 to n do read(gi,a[i]);
        readln(gi);
        for i:=1 to n do read(gi,b[i]);
        for i:=1 to n do bd:=bd+kc(a[i],b[i]);
end;

procedure process;
var     i,j,t,tm,sum:longint;
begin
        for t:=0 to n-1 do
        begin
                for i:=1 to n do
                begin
                        if i+t>n then tm:=(i+t) mod n else tm:=i+t;
                        c[i]:=kc(a[i],b[tm]);
                end;
                sum:=0;
                for i:=1 to n do
                        sum:=sum+c[i];
                if bd>sum+t then bd:=sum+t;
                for i:=1 to n do
                begin
                        sum:=0;
                        for j:=1 to n do sum:=sum+kc(c[i],c[j]);
                        if bd>sum+t+c[i] then bd:=sum+t+c[i];
                end;
        end;
end;

procedure output;
begin
        write(go,bd);
        close(gi);close(go);
end;

begin
        input;
        process;
        output;
end.



















