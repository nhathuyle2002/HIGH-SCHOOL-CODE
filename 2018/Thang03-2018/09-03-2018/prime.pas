const   ginp='prime.inp';
        gout='prime.out';

var     gi,go:text;
        n,t,l,r:longint;
        d:array[0..100001] of boolean;
        dem:array[0..100001] of longint;

procedure input;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,t);
end;

procedure snt;
var     i,j:longint;
begin
        fillchar(d,sizeof(d),true);
        d[0]:=false;d[1]:=false;
        for i:=2 to 1000 do
                if d[i] then
                        for j:=2 to 100001 div i do d[i*j]:=false;
        for i:=1 to 100001 do
                if d[i] then dem[i]:=dem[i-1]+1 else dem[i]:=dem[i-1];
end;

procedure process;
var     i:longint;
begin
        for i:=1 to t do
        begin
                readln(gi,l,r);
                writeln(go,dem[r]-dem[l-1]);
        end;
end;

procedure output;
begin
        close(gi);close(go);
end;

begin
        input;
        snt;
        process;
        output;
end.