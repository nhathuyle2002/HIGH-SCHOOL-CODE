const   ginp='high.inp';
        gout='high.out';

var     gi,go:text;
        n,b:longint;
        x:array[0..1000001] of longint;

procedure input;
var     i:longint;
        xx:char;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,b,n);
        for i:=1 to n do
        begin
                read(gi,xx);
                x[i]:=ord(xx)-48;
        end;
end;

procedure process;
var     i,j,it,sum:longint;
begin
        it:=0;sum:=0;
        if x[n]<>0 then it:=n;
        for i:=n-1 downto 1 do
        begin
                if (x[i]<>b-1) and (it<>0) then
                begin
                        inc(x[i]);
                        for j:=n downto i+1 do sum:=sum+x[j];
                        dec(sum);
                        it:=sum div (b-1);
                        for j:=1 to it do x[n-j+1]:=b-1;
                        x[n-it]:=sum mod (b-1);
                        for j:=i+1 to n-it-1 do x[j]:=0;
                        exit;
                end;
                if (x[i]<>0) then it:=i;
        end;
        n:=1;x[1]:=0;
end;

procedure output;
var     i:longint;
begin
        for i:=1 to n do write(go,x[i]);
        close(gi);close(go);
end;

begin
        input;
        process;
        output;
end.
