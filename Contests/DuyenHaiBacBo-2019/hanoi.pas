const   ginp='hanoi.inp';
        gout='hanoi.out';

var     gi,go:text;
        n,dem:longint;
        vt:array[0..31] of longint;
        luu:array[0..10000001,1..2] of longint;

procedure input;
var     i:longint;
        x:char;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n);
        for i:=1 to n do
        begin
                read(gi,x);
                vt[i]:=ord(x)-64;
        end;
end;

procedure dq(n,a,b:longint);
var     i:longint;
begin
        if n=0 then exit;
        dq(n-1,a,6-a-b);
        inc(dem);
        luu[dem,1]:=a;
        luu[dem,2]:=b;
        dq(n-1,6-a-b,b);
end;

procedure output;
var     i:longint;
begin
        vt[n+1]:=3;
        for i:=1 to n do
                if vt[i]<>vt[i+1] then dq(i,vt[i],vt[i+1]);
        writeln(go,dem);
        for i:=1 to dem do writeln(go,chr(luu[i,1]+64),chr(luu[i,2]+64));
        close(gi);close(go);
end;

begin
        input;
        output;
end.
