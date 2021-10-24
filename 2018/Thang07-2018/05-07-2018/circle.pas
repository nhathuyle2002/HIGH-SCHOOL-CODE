const   ginp='circle.inp';
        gout='circle.out';

var     ma,mi,n:integer;
        f:array[-100..200,-100..200] of integer;

function max(x,y:integer):integer;
begin
        if x>y then exit(x) else exit(y);
end;

function min(x,y:integer):integer;
begin
        if x<y then exit(x) else exit(y);
end;

procedure enter;
var     i,c,r:integer;
begin
        readln(n);
        ma:=-100;mi:=200;
        for i:=1 to n do
        begin
                readln(c,r);
                f[c-r,c+r]:=1;
                ma:=max(ma,c+r);
                mi:=min(mi,c-r);
        end;
end;

procedure process;
var     i,j,kc,k,tm:integer;
begin
        for kc:=2 to ma-mi do
                for i:=mi to ma-kc do
                begin
                        j:=i+kc;tm:=0;
                        for k:=i+1 to j-1 do tm:=max(tm,f[i,k]+f[k,j]);
                        f[i,j]:=f[i,j]+tm;
                end;
        write(n-f[mi,ma]);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        process;
        close(input);close(output);
end.