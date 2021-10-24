const   ginp='hinhvuong.inp';
        gout='hinhvuong.out';

var     gi,go:text;
        x,y:array[1..4] of int64;
        dodai:real;
        d:array[1..4] of boolean;


procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        for i:=1 to 4 do readln(gi,x[i],y[i]);
        fillchar(d,sizeof(d),false);
end;

procedure kt(i:longint);
var     j,dem:longint;
        ok1,ok2:boolean;
begin
        ok1:=false;
        ok2:=false;
        dem:=0;
        for j:=1 to 4 do
                if ((x[i]=x[j]) and (abs(y[i]-y[j])=dodai)) then dem:=dem+1;
        if dem=1 then ok1:=true;
        dem:=0;
        for j:=1 to 4 do
                if ((y[i]=y[j]) and (abs(x[i]-x[j])=dodai)) then dem:=dem+1;
        if dem=1 then ok2:=true;
        if (ok1) and (ok2) then d[i]:=true;
end;

procedure process;
var     i:longint;
begin
        for i:=2 to 4 do
                if x[1]=x[i] then dodai:=abs(y[1]-y[i]);
        if dodai=0 then
        begin
                write(go,-1);
                exit;
        end;
        for i:=1 to 4 do kt(i);
        for i:=1 to 4 do
                if d[i]=false then
                begin
                        write(go,-1);
                        exit;
                end;
        if (x[1]=x[2]) then write(go,sqr(y[1]-y[2])) else write(go,sqr(x[1]-x[2]));
end;

procedure output;
begin
        close(gi);close(go);
end;

begin
        input;
        process;
        output;
end.
