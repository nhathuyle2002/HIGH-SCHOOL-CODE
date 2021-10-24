const   ginp='puzzle.inp';
        gout='puzzle.out';

var     m,n:longint;
        a:array[0..1010] of ansistring;
        res:ansistring;

procedure enter;
var     i:longint;
begin
        readln(m,n);
        for i:=1 to m do readln(a[i]);
        res:='';
end;

function min(x,y:longint):longint;
begin
        if x<y then min:=x else min:=y;
end;

function cmp(x,y:ansistring):boolean;
var     i:longint;
begin
        if x='' then exit(true);
        for i:=1 to min(length(x),length(y)) do
                if x[i]<y[i] then exit(true) else
                if x[i]>y[i] then exit(false);
        if length(x)<length(y) then exit(true) else exit(false);
end;

procedure process;
var     i,j:longint;
        b:ansistring;
begin
        for i:=1 to m do
        begin
                b:='';
                for j:=1 to n do
                        if a[i,j]='#' then
                        begin
                                if (b<>'') and (cmp(res,b)) then res:=b;
                                b:='';
                        end
                        else b:=b+a[i,j];
                if (b<>'') and (cmp(res,b)) then res:=b;
        end;
        for j:=1 to n do
        begin
                b:='';
                for i:=1 to m do
                        if (a[i,j]='#') then
                        begin
                                if (b<>'') and (cmp(res,b)) then res:=b;
                                b:='';
                        end
                        else b:=b+a[i,j];
                if (b<>'') and (cmp(res,b)) then res:=b;
        end;
        write(res);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        process;
        close(input);close(output);
end.
