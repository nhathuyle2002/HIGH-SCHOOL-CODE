const   ginp='piramida.inp';
        gout='piramida.out';

var     gi,go:text;
        n,k:int64;
        s:ansistring;
        f:array['A'..'Z',0..1000001] of int64;

procedure input;
var     i:longint;
        j:char;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n);
        readln(gi,s);n:=length(s);
        readln(gi,k);
        for i:=1 to n do
                for j:='A' to 'Z' do
                        if s[i]=j then f[j,i]:=f[j,i-1]+1 else f[j,i]:=f[j,i-1];
end;

function sumh(x:int64):int64;
begin
        if x mod 2=0 then sumh:=((x div 2) mod n)*((x+1) mod n) mod n
        else sumh:=(((x+1) div 2) mod n)*(x mod n) mod n;
end;

procedure output;
var     h,d,tm:int64;
        i:longint;
        x:char;
begin
        for i:=1 to k do
        begin
                read(gi,h,x);
                while x=' ' do read(gi,x);readln(gi);
                d:=sumh(h-1);
                if n-d<h then
                begin
                        tm:=f[x,n]-f[x,d];
                        h:=h-(n-d);
                        tm:=tm+f[x,h mod n];
                        tm:=tm+f[x,n]*(h div n);
                end
                else    tm:=f[x,h]-f[x,d];
                writeln(go,tm);
        end;
        close(gi);close(go);
end;

begin
        input;
        output;
end.












