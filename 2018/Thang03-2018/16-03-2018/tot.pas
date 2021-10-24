const   ginp='tot.inp';
        gout='tot.out';

var     gi,go:text;
        dpp:array[-200001..200001] of boolean;
        n,dem:longint;
        a:array[0..5001] of longint;
        d:array[0..5001] of boolean;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n);
        for i:=1 to n do read(gi,a[i]);
end;

procedure process;
var     i,j:longint;
begin
        dem:=0;
        fillchar(dpp,sizeof(dpp),false);
        fillchar(d,sizeof(d),false);
        for i:=1 to n-1 do
        begin
                for j:=1 to i do dpp[a[i]+a[j]]:=true;
                for j:=i+1 to n do
                        if dpp[a[j]-a[i]] then d[j]:=true;
        end;
        for i:=1 to n do
                if d[i] then inc(dem);
end;

procedure output;
begin
        write(go,dem);
        close(gi);close(go);
end;

begin
        input;
        process;
        output;
end.