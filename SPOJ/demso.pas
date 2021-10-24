const   ginp='ss.inp';
        gout='ss.out';

var     gi,go:text;
        d,k:longint;
        a,b:array[0..16] of longint;
        f:array[0..16,0..9,0..16] of int64;

procedure create(x:int64;var t:array of longint);
var     i,tm,cou:longint;
begin
        cou:=0;
        while x>0 do
        begin
                inc(cou);
                t[cou]:=x mod 10;
                x:=x div 10;
        end;
        if n=0 then n:=cou;
        for i:=1 to n div 2 do
        begin
                tm:=t[i];t[i]:=t[n-i+1];t[n-i+1]:=tm;
        end;
end;

procedure input;
var     tm,i:longint;
        aa,bb:int64;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        read(gi,aa,bb,d,k);
        create(bb,b);create(aa,a);
end;

procedure process;
var     i,j,t:longint;
begin
        for i:=1 to 16 do
                for j:=0 to 9 do
                        for k:=1 to
