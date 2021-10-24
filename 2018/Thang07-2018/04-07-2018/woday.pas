const   ginp='woday.inp';
        gout='woday.out';

var     gi,go:text;
        n,res:longint;
        d:array[0..200010] of boolean;

procedure try(x:longint);
var     i,j:longint;
begin
        if d[x] then exit;
        d[x]:=true;
        for i:=2 to trunc(sqrt(x)) do
                if x mod i=0 then try((i-1)*(x div i+1));
end;

procedure main;
var     i:longint;
begin
        read(n);
        fillchar(d,sizeof(d),false);
        d[0]:=true;
        try(n);
        res:=0;
        for i:=0 to n-1 do
                if d[i] then inc(res);
        writeln(res);
        for i:=0 to n-1 do
                if d[i] then write(i,' ');
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        main;
        close(input);close(output);
end.