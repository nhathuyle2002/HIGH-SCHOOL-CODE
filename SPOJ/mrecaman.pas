const   ginp='ss.inp';
        gout='ss.out';

var     gi,go:text;
        n,i:longint;
        d:array[0..10000000] of boolean;
        f:array[0..500100] of int64;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
end;

procedure main;
var     i,tm:longint;
begin
        fillchar(d,sizeof(d),true);
        f[0]:=0;
        for i:=1 to 500000 do
        begin
                tm:=f[i-1]-i;
                if (tm<=0) then f[i]:=f[i-1]+i
                else if (d[tm]=false) then f[i]:=f[i-1]+i
                else f[i]:=tm;
                d[f[i]]:=false;
        end;
end;

procedure output;
var     k:longint;
begin
        repeat
                readln(gi,k);
                if k=-1 then break;
                writeln(go,f[k]);
        until false;
        close(gi);close(go);
end;

begin
        input;
        main;
        output;
end.
