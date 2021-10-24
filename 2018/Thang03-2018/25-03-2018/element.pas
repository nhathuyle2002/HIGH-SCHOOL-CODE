const   ginp='element.inp';
        gout='element.out';

var     gi,go:text;
        n:longint;
        ans:int64;
        a:array[0..5001] of longint;
        dd:array[0..5001] of boolean;
        d:array[-200001..200001] of boolean;

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
        fillchar(d,sizeof(d),false);
        fillchar(dd,sizeof(dd),false);
        for i:=1 to n do
        begin
                for j:=i downto 1 do d[a[i]+a[j]]:=true;
                for j:=i+1 to n do
                        if d[a[j]-a[i]] then dd[j]:=true;
        end;
        ans:=0;
        for i:=1 to n do
                if dd[i] then inc(ans);
end;

procedure output;
begin
        write(go,ans);
        close(gi);close(go);
end;

begin
        input;
        process;
        output;
end.
