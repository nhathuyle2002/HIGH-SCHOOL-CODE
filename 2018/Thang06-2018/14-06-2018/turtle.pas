const   ginp='turtle.inp';
        gout='turtle.out';

var     gi,go:text;
        res:int64;
        a:array[1..4] of int64;
        d:array[1..4] of longint;
        dd:array[1..4] of boolean;

function max(x,y:int64):int64;
begin
        if x>y then exit(x) else exit(y);
end;

function min(x,y:int64):int64;
begin
        if x<y then exit(x) else exit(y);
end;

procedure dfs(i:longint);
var     j:longint;
begin
        if i=5 then
                res:=max(res,min(a[d[1]],a[d[2]])*min(a[d[3]],a[d[4]]));
        for j:=1 to 4 do
                if dd[j] then
                begin
                        dd[j]:=false;
                        d[i]:=j;
                        dfs(i+1);
                        dd[j]:=true;
                end;
end;

procedure main;
var     i:longint;
begin
        for i:=1 to 4 do read(gi,a[i]);
        fillchar(dd,sizeof(dd),true);
        res:=0;
        dfs(1);
        write(go,res);
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        main;
        close(gi);close(go);
end.